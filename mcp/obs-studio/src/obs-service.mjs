import OBSWebSocket from 'obs-websocket-js';

const loopbackHosts = new Set(['localhost', '127.0.0.1', '[::1]']);

export function validateObsConfig(urlValue, password) {
  if (typeof urlValue !== 'string' || urlValue.length === 0) {
    throw new Error('OBS_WEBSOCKET_URL must be a non-empty WebSocket URL.');
  }
  if (typeof password !== 'string' || password.length === 0) {
    throw new Error('OBS_WEBSOCKET_PASSWORD is required; set it in the host environment.');
  }

  let url;
  try {
    url = new URL(urlValue);
  } catch {
    throw new Error('OBS_WEBSOCKET_URL must be a valid WebSocket URL.');
  }

  if (!['ws:', 'wss:'].includes(url.protocol)) {
    throw new Error('OBS_WEBSOCKET_URL must use ws: or wss:.');
  }
  if (!loopbackHosts.has(url.hostname.toLowerCase())) {
    throw new Error('OBS_WEBSOCKET_URL must target localhost or a loopback address.');
  }
  if (url.username || url.password || url.search || url.hash) {
    throw new Error('OBS_WEBSOCKET_URL must not contain credentials, query parameters, or a fragment.');
  }

  return url.toString();
}

export function createObsService({
  url = process.env.OBS_WEBSOCKET_URL ?? 'ws://127.0.0.1:4455',
  password = process.env.OBS_WEBSOCKET_PASSWORD,
  createClient = () => new OBSWebSocket(),
} = {}) {
  const endpoint = validateObsConfig(url, password);
  const client = createClient();
  let requestQueue = Promise.resolve();

  function call(requestType, requestData) {
    const request = requestQueue.then(async () => {
      if (!client.identified) {
        await client.connect(endpoint, password);
      }
      return client.call(requestType, requestData);
    });

    requestQueue = request.then(() => undefined, () => undefined);
    return request;
  }

  async function close() {
    await requestQueue;
    if (client.identified) {
      await client.disconnect();
    }
  }

  return { call, close };
}
