import assert from 'node:assert/strict';
import test from 'node:test';
import { createObsToolExecutor, obsTools } from '../src/obs-tools.mjs';

function createFakeObs(responses = {}) {
  const calls = [];
  return {
    calls,
    async call(type, args) {
      calls.push({ type, args });
      let response = responses[type];
      if (Array.isArray(response)) {
        response = response.shift();
      }
      if (response instanceof Error) {
        throw response;
      }
      return response ?? {};
    },
  };
}

test('lists all requested OBS control categories', () => {
  const names = new Set(obsTools.map(({ name }) => name));
  for (const name of [
    'obs_get_status',
    'obs_list_scenes',
    'obs_list_scene_sources',
    'obs_set_scene',
    'obs_set_source_visibility',
    'obs_set_input_mute',
    'obs_get_input_audio_state',
    'obs_set_input_volume',
    'obs_start_recording',
    'obs_stop_recording',
    'obs_start_streaming',
    'obs_stop_streaming',
  ]) {
    assert.ok(names.has(name), `missing ${name}`);
  }
});

test('blocks recording and streaming actions unless confirm is true', async () => {
  const obs = createFakeObs();
  const execute = createObsToolExecutor(obs);

  await assert.rejects(
    execute('obs_start_streaming', { confirm: false }),
    /explicit user approval and confirm=true/,
  );
  await assert.rejects(
    execute('obs_stop_recording', {}),
    /explicit user approval and confirm=true/,
  );
  assert.deepEqual(obs.calls, []);
});

test('runs a confirmed production action and reports OBS failures', async () => {
  const obs = createFakeObs({
    StartRecord: { outputPath: 'capture.mkv' },
    GetRecordStatus: { outputActive: true },
  });
  const execute = createObsToolExecutor(obs);

  assert.deepEqual(await execute('obs_start_recording', { confirm: true }), {
    success: true,
    action: 'obs_start_recording',
    outputPath: 'capture.mkv',
    outputActive: true,
  });
  assert.deepEqual(obs.calls, [
    { type: 'StartRecord', args: undefined },
    { type: 'GetRecordStatus', args: undefined },
  ]);

  const failed = createObsToolExecutor(createFakeObs({ StartStream: new Error('OBS is offline') }));
  await assert.rejects(failed('obs_start_streaming', { confirm: true }), /OBS is offline/);
});

test('maps each confirmed recording and streaming action to its verified OBS status', async () => {
  const cases = [
    ['obs_start_recording', 'StartRecord', 'GetRecordStatus', true],
    ['obs_stop_recording', 'StopRecord', 'GetRecordStatus', false],
    ['obs_start_streaming', 'StartStream', 'GetStreamStatus', true],
    ['obs_stop_streaming', 'StopStream', 'GetStreamStatus', false],
  ];

  for (const [toolName, requestType, statusType, outputActive] of cases) {
    const obs = createFakeObs({
      [requestType]: {},
      [statusType]: { outputActive },
    });
    const result = await createObsToolExecutor(obs)(toolName, { confirm: true });

    assert.equal(result.outputActive, outputActive);
    assert.deepEqual(obs.calls, [
      { type: requestType, args: undefined },
      { type: statusType, args: undefined },
    ]);
  }
});

test('validates scene, source, and audio operations before issuing changes', async () => {
  const obs = createFakeObs({
    GetSceneList: {
      scenes: [{ sceneName: 'Starting Soon' }],
      currentProgramSceneName: 'Starting Soon',
    },
    GetSceneItemList: { sceneItems: [{ sceneItemId: 7, sceneItemEnabled: false }] },
    GetInputMute: { inputMuted: true },
    GetInputVolume: { inputVolumeDb: -8 },
  });
  const execute = createObsToolExecutor(obs);

  await assert.rejects(execute('obs_set_scene', { sceneName: 'Missing' }), /scene not found/);
  await assert.rejects(execute('obs_set_input_volume', {
    inputName: 'Mic',
    inputVolumeDb: 27,
  }), /between -100 and 26/);
  assert.equal(obs.calls.length, 1);

  assert.deepEqual(await execute('obs_set_scene', { sceneName: 'Starting Soon' }), {
    success: true,
    currentProgramSceneName: 'Starting Soon',
  });
  await execute('obs_set_source_visibility', {
    sceneName: 'Starting Soon',
    sceneItemId: 7,
    visible: false,
  });
  assert.deepEqual(obs.calls.at(-1), {
    type: 'GetSceneItemList',
    args: { sceneName: 'Starting Soon' },
  });
  assert.deepEqual(await execute('obs_get_input_audio_state', { inputName: 'Mic' }), {
    inputName: 'Mic',
    muted: true,
    inputVolumeDb: -8,
  });
});

test('reports when OBS does not reach the requested scene, source, audio, or production state', async () => {
  const obs = createFakeObs({
    GetSceneList: [
      { scenes: [{ sceneName: 'Starting Soon' }], currentProgramSceneName: 'Starting Soon' },
      { currentProgramSceneName: 'Main' },
    ],
    GetSceneItemList: [
      { sceneItems: [{ sceneItemId: 7, sceneItemEnabled: true }] },
      { sceneItems: [{ sceneItemId: 7, sceneItemEnabled: true }] },
    ],
    GetInputMute: { inputMuted: false },
    GetInputVolume: { inputVolumeDb: -12 },
    GetRecordStatus: { outputActive: false },
  });
  const execute = createObsToolExecutor(obs);

  await assert.rejects(execute('obs_set_scene', { sceneName: 'Starting Soon' }), /did not switch/);
  await assert.rejects(execute('obs_set_source_visibility', {
    sceneName: 'Starting Soon',
    sceneItemId: 7,
    visible: false,
  }), /did not apply source visibility/);
  await assert.rejects(execute('obs_set_input_mute', {
    inputName: 'Mic',
    muted: true,
  }), /did not apply mute state/);
  await assert.rejects(execute('obs_set_input_volume', {
    inputName: 'Mic',
    inputVolumeDb: -8,
  }), /did not apply the requested volume/);
  await assert.rejects(execute('obs_start_recording', { confirm: true }), /did not complete/);
});
