{...}: {
  programs.helm.enable = true;
  programs.helm.plugins = ["diff"];
  programs.krew.enable = true;
  programs.krew.plugins = [
    "ctx"
    "ns"
    "whoami"
  ];
  programs.helmfile.enable = true;
  programs.kubectl.enable = true;
  programs.k9s.enable = true;
  programs.minikube.enable = true;
}
