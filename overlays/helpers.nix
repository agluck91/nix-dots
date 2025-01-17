# Custom helper functions that can be accessed globally via `pkgs.helpers`
final: prev: {
  helpers = {
    nodeJsScript = name:
      final.writers.writeJSBin name {} (prev.lib.fileContents ./scripts/${name}.js);
  };
}
