{
  #nix Aliases
  nix-r = "sudo nixos-rebuild switch --flake ~/nix-dots#nixos";
  nix-mr = "darwin-rebuild switch --flake ~/nix-dots#mac";
  nix-u = "sudo flakes update";
  nix-e = "nvim ~/nix-dots";
  nix-g = "sudo nix collect-garbage -d 1w";

  #System Aliases
  ls = "exa --icons -gh --group-directories-first";
  ll = "exa --icons -gh --group-directories-first -l";
  la = "exa --icons -gh --group-directories-first -a";
  lla = "exa --icons -gh --group-directories-first -la";
  llt = "exa --icons --group-directories-first -T";
  cd = "z";
  cdi = "zi";
  cc = "/bin/cat";
  cat = "bat -p -P";
  rm = "rm -i";
  cp = "cp -i";
  mv = "mv -i";
  zshrc = "nvim ~/.zshrc";
  tf = "tail -f -n 1000";

  #Misc aliases
  lg = "lazygit";

  #Docker aliases
  drm = "docker rm -f $(docker ps -aq)";
  drmi = "docker rmi -f $(docker images -aq)";
  dclean = "docker system prune -a";
  dnuke = "drm; drmi; docker system prune -a --volumes --force";
  d = "docker";
  dc = "docker compose";
  dcu = "docker compose up -d";
  dcd = "docker compose down";
  dr = "docker run";
  dex = "docker exec -it";

  #Kubernetes aliases
  k = "kubectl";
  kg = "kubectl get";
  kd = "kubectl describe";
  krm = "kubectl delete";
  kaf = "kubectl apply -f";
  klo = "kubectl logs -f";
  kex = "kubectl exec -it";
  kpf = "kubectl port-forward";
  kgi = "kubectl get ingress";
  kgr = "kubectl get roles";
  kga = "kubectl get rolebindings";
  kgc = "kubectl get configmaps";
  kgs = "kubectl get secrets";
  kgn = "kubectl get nodes";
  kdp = "kubectl describe pods";
  kds = "kubectl describe services";
  kdd = "kubectl describe deployments";
  h = "helm";
  hi = "helm install";
  hu = "helm uninstall";
  hl = "helm list";
  hls = "helm ls";
  hld = "helm delete";
  hldp = "helm delete --purge";

  #Git Aliases
  g = "git";
  gs = "git status";
  gaa = "git add --all";
  gc = "git commit";
  gcm = "git commit -m";
  gca = "git commit --amend";
  gco = "git checkout";
  gcb = "git checkout -b";
  gbr = "git branch";
  gpl = "git pull";
  gp = "git push";
}
