#
# Shell
#

{ pkgs, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
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
        g = "sudo nixos-rebuild switch --flake .#desktop";
      };
      promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      setOptions = [
        "APPEND_HISTORY"
        "INC_APPEND_HISTORY"
        "SHARE_HISTORY"
      ];
      interactiveShellInit = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh;
        source ${pkgs.zsh-better-npm-completion}/share/zsh-better-npm-completion;
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions
        source ${pkgs.zsh-completions}/share/zsh/site-functions
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      '';
    };
  };
}
