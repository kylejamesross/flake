#
# Shell
#

{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;            # Auto suggest options and highlights syntax, searches in history for options
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      histSize = 100000;
      shellAliases = {
        ls = "exa -labg --git --color auto";
        cat = "bat";
        pb = "git branch --merged | grep -v -E \"main|master|staging|dev|$(git rev-parse --abbrev-ref HEAD)\" > /tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches";
        v = "nvim";
        fonts = "fc-list";
        wlogin = "az acr login -n nsolutionsacregistry";
      };
      promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "git-extras" "docker" "docker-compose" "npm" "ripgrep"];
      };
      setOptions = [
        "APPEND_HISTORY"
        "INC_APPEND_HISTORY"
        "SHARE_HISTORY"
      ];
    };
  };
}
