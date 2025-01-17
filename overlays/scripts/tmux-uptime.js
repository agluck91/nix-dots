const os = require("os");

const seconds = os.uptime();
const hours = Math.floor(seconds / 3600);
const minutes = Math.floor((seconds % 3600) / 60);

console.log(`${hours}h ${minutes}m`);
