#
# Shell
#

{ pkgs, host, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      histSize = 100000;
      shellAliases = {
        ls = "eza -bhal --icons --hyperlink --git --color auto";
        cat = "bat";
        pb = "git branch --merged | grep -v -E \"main|master|staging|dev|$(git rev-parse --abbrev-ref HEAD)\" > /tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches";
        n = "nvim";
        fonts = "fc-list";
        wlogin = "az acr login -n nsolutionsacregistry";
        access-token = "az account get-access-token | jaq .accessToken | sed 's/\"//g' | wl-copy";
        g = "if [[ \"${host.hostName}\" == \"laptop\" ]]; then sudo nixos-rebuild switch --flake .#laptop; else sudo nixos-rebuild switch --flake .#desktop; fi";
      };
      promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      setOptions = [
        "APPEND_HISTORY"
        "INC_APPEND_HISTORY"
        "SHARE_HISTORY"
      ];
      interactiveShellInit = ''
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh;
      '';
    };
  };
}
