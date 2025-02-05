import { MiningCoordinator } from './miner.js';

// Memulai proses penambangan
new MiningCoordinator().start().catch(console.error);
