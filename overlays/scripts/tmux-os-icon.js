// @ts-check
const os = require("os");

const icons = {
  linux: "",
  darwin: "",
  default: "",
};

console.log(icons[os.platform()] ?? icons.default);
