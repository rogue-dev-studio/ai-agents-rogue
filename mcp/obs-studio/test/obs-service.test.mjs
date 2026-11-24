import assert from 'node:assert/strict';
import test from 'node:test';
import { createObsService, validateObsConfig } from '../src/obs-service.mjs';

test('accepts authenticated loopback WebSocket configuration', () => {
  assert.equal(
    validateObsConfig('ws://127.0.0.1:4455', 'test-password'),
    'ws://127.0.0.1:4455/',
  );
});

test('rejects remote WebSocket hosts and unsupported protocols', () => {
  assert.throws(
    () => validateObsConfig('ws://192.168.1.20:4455', 'test-password'),
    /loopback/,
  );
  assert.throws(
    () => validateObsConfig('http://127.0.0.1:4455', 'test-password'),
    /ws: or wss:/,
  );
});

test('requires a password and rejects credentials embedded in the URL', () => {
  assert.throws(
    () => validateObsConfig('ws://127.0.0.1:4455', ''),
    /OBS_WEBSOCKET_PASSWORD is required/,
  );
  assert.throws(
    () => validateObsConfig('ws://user:pass@127.0.0.1:4455', 'test-password'),
    /must not contain credentials/,
  );
});

test('serializes calls through one OBS connection', async () => {
  let connectCount = 0;
  const calls = [];
  const client = {
    identified: false,
    async connect(url, password) {
      connectCount += 1;
      assert.equal(url, 'ws://127.0.0.1:4455/');
      assert.equal(password, 'test-password');
      await new Promise((resolve) => setTimeout(resolve, 5));
      this.identified = true;
    },
    async call(type) {
      calls.push(type);
      return { type };
    },
    async disconnect() {
      this.identified = false;
    },
  };
  const service = createObsService({
    url: 'ws://127.0.0.1:4455',
    password: 'test-password',
    createClient: () => client,
  });

  const results = await Promise.all([service.call('GetVersion'), service.call('GetStats')]);
  assert.equal(connectCount, 1);
  assert.deepEqual(calls, ['GetVersion', 'GetStats']);
  assert.deepEqual(results, [{ type: 'GetVersion' }, { type: 'GetStats' }]);
  await service.close();
});
