{
  programs.git = {
    enable = true;
    userEmail = "andrew.gluck91@gmail.com";
    userName = "Andrew Gluck";
    extraConfig = {
      core = {
        editor = "nvim";
      };
      pull = {
        rebase = true;
      };
      rebase = {
        autosquash = true;
      };
    };
  };
}
