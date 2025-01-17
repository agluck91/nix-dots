# Custom helper functions that can be accessed globally via `pkgs.helpers`
final: prev: {
  helpers = {
    nodeJsScript = name:
      final.writers.writeJSBin name {} (prev.lib.fileContents ./scripts/${name}.js);

    pyScript = name:
      final.writers.writePython3Bin name {doCheck = false;} (prev.lib.fileContents ./scripts/${name}.py);
  };
}
