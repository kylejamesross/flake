{user, ...}: {
  home = {
    username = "${user}";
    stateVersion = "24.05";
  };
  programs.home-manager.enable = true;
}
