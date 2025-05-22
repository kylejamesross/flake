{
  user,
  pkgs,
  ...
}: {
  home = {
    username = "${user}";
    stateVersion = "24.05";
    sessionVariables = {
      TERMINAL = "kitty";
      EDITOR = "nvim";
      VISUAL = "nvim";
      USERNAME = user;
      AICHAT_PLATFORM = "openai";
      TF_AUTO_SAVE_CREDENTIALS = "1";
      TF_DIFF_COMMAND = "${pkgs.meld}/bin/meld %1 %2";
      TF_MERGE_COMMAND = "${pkgs.meld}/bin/meld %1 %2 %3 --output=%4";
    };
  };
  programs.home-manager.enable = true;
}
