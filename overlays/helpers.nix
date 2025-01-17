# Custom helper functions that can be accessed globally via `pkgs.helpers`
final: prev: {
  helpers = {
    nodeJsScript = name:
      final.writers.writeJSBin name {} (prev.lib.fileContents ./scripts/${name}.js);

    pyScript = name:
      final.writers.writePythonBin name {} (prev.lib.fileContents ./scripts/${name}.py);
  };
}
