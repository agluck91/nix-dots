{
  #nix Aliases

  nix-r = "sudo nixos-rebuild switch --flake ~/nix-dots#nixos";
  nix-u = "sudo flakes update";
  nix-e = "nvim ~/nix-dots";
  nix-g = "nix collect-garbage -d";

  #System Aliases
  ls = "exa --icons -gh --group-directories-first";
  ll = "exa --icons -gh --group-directories-first -l";
  la = "exa --icons -gh --group-directories-first -a";
  lla = "exa --icons -gh --group-directories-first -la";
  llt = "exa --icons --group-directories-first -T";
  cc = "/bin/cat";
  cat = "bat -p -P";
  rm = "rm -i";
  cp = "cp -i";
  mv = "mv -i";
  zshrc = "nvim ~/.zshrc";
  tf = "tail -f -n 1000";
  h = "history";

  #Misc aliases
  lg = "lazygit";
  vim = "nvim";

  #Docker aliases
  drm = "docker rm -f $(docker ps -aq)";
  drmi = "docker rmi -f $(docker images -aq)";
  dclean = "docker system prune -a";
  dnuke = "drm; drmi; docker system prune -a --volumes --force";
  d = "docker";
  dc = "docker compose";
  dcu = "docker compose up";
  dcd = "docker compose down";
  dcud = "docker compose up -d";
  dr = "docker run";
  dex = "docker exec -it";

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
