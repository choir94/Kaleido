import { MiningCoordinator } from './miner.js';

(async () => {
    try {
        await new MiningCoordinator().start();
    } catch (error) {
        console.error('Mining process failed:', error);
    }
})();
