// @ts-check
const util = require("node:util");
const fs = require("node:fs");
const exec = util.promisify(require("node:child_process").exec);

(async function () {
  try {
    if (!fs.existsSync(".git")) {
      console.log("N/A");
      return;
    }

    const [{ stdout: branch }, { stdout: upstream }, { stdout: status }] =
      await Promise.all([
        // Get the current branch name
        exec("git rev-parse --abbrev-ref HEAD"),
        // Get upstream status (ahead/behind counts)
        exec("git rev-list --left-right --count @{upstream}...HEAD").catch(
          () => ({ stdout: "" }),
        ),
        // Get the status details
        exec("git status --porcelain"),
      ]);

    const currentBranch = branch.trim();
    const [behind, ahead] = upstream.trim().split("\t").map(Number);

    // Parse the file status counts
    const lines = status.split("\n").filter((l) => l.trim());
    const deleted = lines.filter((l) => l.startsWith(" D")).length;
    const modified = lines.filter((l) => l.startsWith(" M")).length;
    const added = lines.filter(
      (l) => l.startsWith("A ") || l.startsWith("?? "),
    ).length;

    let out = currentBranch;
    if (ahead) out += ` ↑${ahead}`;
    if (behind) out += ` ↓${behind}`;
    if (added) out += ` ?${added}`;
    if (modified) out += ` ~${modified}`;
    if (deleted) out += ` -${deleted}`;

    // Format and log the output
    console.log(out);
  } catch (error) {
    console.log(error.message);
  }
})();
