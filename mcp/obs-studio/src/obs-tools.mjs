const noArguments = { type: 'object', properties: {}, additionalProperties: false };

function stringProperty(description) {
  return { type: 'string', minLength: 1, description };
}

function tool(name, description, properties = {}, required = []) {
  return {
    name,
    description,
    inputSchema: {
      type: 'object',
      properties,
      required,
      additionalProperties: false,
    },
  };
}

export const obsTools = [
  {
    name: 'obs_get_status',
    description: 'Read OBS version, current performance, and stream/recording state.',
    inputSchema: noArguments,
  },
  {
    name: 'obs_list_scenes',
    description: 'List OBS scenes and identify the current program scene.',
    inputSchema: noArguments,
  },
  tool(
    'obs_list_scene_sources',
    'List source names, item IDs, and visibility for one OBS scene.',
    { sceneName: stringProperty('Exact OBS scene name.') },
    ['sceneName'],
  ),
  tool(
    'obs_set_scene',
    'Switch the OBS program output to an existing scene.',
    { sceneName: stringProperty('Exact OBS scene name.') },
    ['sceneName'],
  ),
  tool(
    'obs_set_source_visibility',
    'Set one source item visible or hidden in a scene.',
    {
      sceneName: stringProperty('Exact OBS scene name.'),
      sceneItemId: { type: 'integer', minimum: 0, description: 'OBS scene item ID.' },
      visible: { type: 'boolean', description: 'Whether the source item should be visible.' },
    },
    ['sceneName', 'sceneItemId', 'visible'],
  ),
  tool(
    'obs_set_input_mute',
    'Set an OBS audio input to muted or unmuted.',
    {
      inputName: stringProperty('Exact OBS input name.'),
      muted: { type: 'boolean', description: 'Whether the input should be muted.' },
    },
    ['inputName', 'muted'],
  ),
  tool(
    'obs_get_input_audio_state',
    'Read the mute state and volume of an OBS audio input.',
    { inputName: stringProperty('Exact OBS input name.') },
    ['inputName'],
  ),
  tool(
    'obs_set_input_volume',
    'Set an OBS audio input volume in decibels (-100 to 26 dB).',
    {
      inputName: stringProperty('Exact OBS input name.'),
      inputVolumeDb: { type: 'number', minimum: -100, maximum: 26 },
    },
    ['inputName', 'inputVolumeDb'],
  ),
  ...['recording', 'streaming'].flatMap((action) => [
    tool(
      `obs_start_${action}`,
      `Start OBS ${action}; requires explicit user approval and confirm=true.`,
      { confirm: { type: 'boolean', description: 'Must be true after explicit user approval.' } },
      ['confirm'],
    ),
    tool(
      `obs_stop_${action}`,
      `Stop OBS ${action}; requires explicit user approval and confirm=true.`,
      { confirm: { type: 'boolean', description: 'Must be true after explicit user approval.' } },
      ['confirm'],
    ),
  ]),
];

function requiredString(args, key) {
  const value = args[key];
  if (typeof value !== 'string' || value.trim().length === 0) {
    throw new Error(`${key} must be a non-empty string.`);
  }
  return value.trim();
}

function requiredBoolean(args, key) {
  if (typeof args[key] !== 'boolean') {
    throw new Error(`${key} must be a boolean.`);
  }
  return args[key];
}

function requiredNumber(args, key, min, max) {
  const value = args[key];
  if (typeof value !== 'number' || !Number.isFinite(value) || value < min || value > max) {
    throw new Error(`${key} must be a finite number between ${min} and ${max}.`);
  }
  return value;
}

function requiredInteger(args, key, min) {
  const value = args[key];
  if (!Number.isInteger(value) || value < min) {
    throw new Error(`${key} must be an integer greater than or equal to ${min}.`);
  }
  return value;
}

function requireConfirmation(args) {
  if (args.confirm !== true) {
    throw new Error('OBS recording/streaming action blocked: explicit user approval and confirm=true are required.');
  }
}

export function createObsToolExecutor(obs) {
  return async function execute(name, rawArgs = {}) {
    const args = rawArgs && typeof rawArgs === 'object' && !Array.isArray(rawArgs) ? rawArgs : {};

    switch (name) {
      case 'obs_get_status': {
        const [version, stats, stream, recording] = await Promise.all([
          obs.call('GetVersion'),
          obs.call('GetStats'),
          obs.call('GetStreamStatus'),
          obs.call('GetRecordStatus'),
        ]);
        return {
          obsVersion: version.obsVersion,
          obsWebSocketVersion: version.obsWebSocketVersion,
          currentFps: stats.activeFps,
          cpuUsage: stats.cpuUsage,
          stream,
          recording,
        };
      }
      case 'obs_list_scenes': {
        const result = await obs.call('GetSceneList');
        return {
          currentProgramSceneName: result.currentProgramSceneName,
          scenes: result.scenes.map(({ sceneName, sceneIndex }) => ({ sceneName, sceneIndex })),
        };
      }
      case 'obs_list_scene_sources': {
        const sceneName = requiredString(args, 'sceneName');
        const result = await obs.call('GetSceneItemList', { sceneName });
        return {
          sceneName,
          sources: result.sceneItems.map(({ sceneItemId, sourceName, sourceType, sceneItemEnabled }) => ({
            sceneItemId,
            sourceName,
            sourceType,
            visible: sceneItemEnabled,
          })),
        };
      }
      case 'obs_set_scene': {
        const sceneName = requiredString(args, 'sceneName');
        const { scenes } = await obs.call('GetSceneList');
        if (!scenes.some((scene) => scene.sceneName === sceneName)) {
          throw new Error(`OBS scene not found: ${sceneName}`);
        }
        await obs.call('SetCurrentProgramScene', { sceneName });
        const verified = await obs.call('GetSceneList');
        if (verified.currentProgramSceneName !== sceneName) {
          throw new Error(`OBS did not switch to scene: ${sceneName}`);
        }
        return { success: true, currentProgramSceneName: verified.currentProgramSceneName };
      }
      case 'obs_set_source_visibility': {
        const sceneName = requiredString(args, 'sceneName');
        const sceneItemId = requiredInteger(args, 'sceneItemId', 0);
        const visible = requiredBoolean(args, 'visible');
        const { sceneItems } = await obs.call('GetSceneItemList', { sceneName });
        if (!sceneItems.some((item) => item.sceneItemId === sceneItemId)) {
          throw new Error(`OBS scene item ${sceneItemId} not found in scene: ${sceneName}`);
        }
        await obs.call('SetSceneItemEnabled', { sceneName, sceneItemId, sceneItemEnabled: visible });
        const verified = await obs.call('GetSceneItemList', { sceneName });
        const item = verified.sceneItems.find((sceneItem) => sceneItem.sceneItemId === sceneItemId);
        if (!item || item.sceneItemEnabled !== visible) {
          throw new Error(`OBS did not apply source visibility for scene item ${sceneItemId}.`);
        }
        return { success: true, sceneName, sceneItemId, visible };
      }
      case 'obs_set_input_mute': {
        const inputName = requiredString(args, 'inputName');
        const inputMuted = requiredBoolean(args, 'muted');
        await obs.call('SetInputMute', { inputName, inputMuted });
        const verified = await obs.call('GetInputMute', { inputName });
        if (verified.inputMuted !== inputMuted) {
          throw new Error(`OBS did not apply mute state for input: ${inputName}`);
        }
        return { success: true, inputName, muted: verified.inputMuted };
      }
      case 'obs_get_input_audio_state': {
        const inputName = requiredString(args, 'inputName');
        const [mute, volume] = await Promise.all([
          obs.call('GetInputMute', { inputName }),
          obs.call('GetInputVolume', { inputName }),
        ]);
        return {
          inputName,
          muted: mute.inputMuted,
          inputVolumeDb: volume.inputVolumeDb,
        };
      }
      case 'obs_set_input_volume': {
        const inputName = requiredString(args, 'inputName');
        const inputVolumeDb = requiredNumber(args, 'inputVolumeDb', -100, 26);
        await obs.call('SetInputVolume', { inputName, inputVolumeDb });
        const verified = await obs.call('GetInputVolume', { inputName });
        if (Math.abs(verified.inputVolumeDb - inputVolumeDb) > 0.1) {
          throw new Error(`OBS did not apply the requested volume for input: ${inputName}`);
        }
        return { success: true, inputName, inputVolumeDb: verified.inputVolumeDb };
      }
      case 'obs_start_recording':
      case 'obs_stop_recording':
      case 'obs_start_streaming':
      case 'obs_stop_streaming': {
        requireConfirmation(args);
        const requestTypes = {
          obs_start_recording: 'StartRecord',
          obs_stop_recording: 'StopRecord',
          obs_start_streaming: 'StartStream',
          obs_stop_streaming: 'StopStream',
        };
        const result = await obs.call(requestTypes[name]);
        const status = await obs.call(
          name.includes('recording') ? 'GetRecordStatus' : 'GetStreamStatus',
        );
        const shouldBeActive = name.startsWith('obs_start_');
        if (status.outputActive !== shouldBeActive) {
          throw new Error(`OBS did not complete the requested action: ${name}`);
        }
        return { success: true, action: name, ...result, outputActive: status.outputActive };
      }
      default:
        throw new Error(`Unknown OBS tool: ${name}`);
    }
  };
}
