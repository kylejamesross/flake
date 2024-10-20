{
  pkgs,
  config,
  ...
}:
with config.lib.stylix.colors; {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      styles = {
        default = "none";
        unknown-token = "fg=#${base08},bold";
        reserved-word = "fg=#${base0A}";
        suffix-alias = "fg=#${base0B},underline";
        global-alias = "fg=#${base0C}";
        precommand = "fg=#${base0B},underline";
        commandseparator = "none";
        autodirectory = "fg=#${base0B},underline";
        path = "underline";
        path_pathseparator = "";
        path_prefix_pathseparator = "";
        globbing = "fg=#${base0D}";
        history-expansion = "fg=#${base0D}";
        command-substitution = "none";
        command-substitution-delimiter = "fg=#${base0E}";
        process-substitution = "none";
        process-substitution-delimiter = "fg=#${base0E}";
        single-hyphen-option = "none";
        double-hyphen-option = "none";
        back-quoted-argument = "none";
        back-quoted-argument-delimiter = "fg=#${base0E}";
        single-quoted-argument = "fg=#${base0A}";
        double-quoted-argument = "fg=#${base0A}";
        dollar-quoted-argument = "fg=#${base0A}";
        rc-quote = "fg=#${base0C}";
        dollar-double-quoted-argument = "fg=#${base0C}";
        back-double-quoted-argument = "fg=#${base0C}";
        back-dollar-quoted-argument = "fg=#${base0C}";
        assign = "none";
        redirection = "fg=#${base0A}";
        comment = "fg=#${base01},bold";
        named-fd = "none";
        numeric-fd = "none";
        arg0 = "fg=#${base0B}";
      };
    };
    history.size = 100000;
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza -bhal --icons --hyperlink --git --color auto";
      cat = "${pkgs.bat}/bin/bat";
      sb = "${pkgs.git}/bin/git branch | ${pkgs.fzf}/bin/fzf | xargs -I {} ${pkgs.git}/bin/git switch {}";
      pb = "${pkgs.git}/bin/git branch | ${pkgs.fzf}/bin/fzf --multi | xargs -I {} ${pkgs.git}/bin/git branch -D {}";
      pbe = "${pkgs.git}/bin/git branch --merged | grep -v -E \"main|master|staging|dev|$(git rev-parse --abbrev-ref HEAD)\" > /tmp/merged-branches && ${pkgs.neovim}/bin/nvim /tmp/merged-branches && xargs ${pkgs.git}/bin/git branch -d </tmp/merged-branches";
      n = "${pkgs.neovim}/bin/nvim";
      d7 = "nix shell nixpkgs#dotnet-sdk_7";
      wlogin = "${pkgs.azure-cli}/bin/az acr login -n nsolutionsacregistry";
      g = "${pkgs.nh}/bin/nh os switch";
      musb = "mkdir -p ~/usb && sudo mount \"/dev/$(lsblk --list | ${pkgs.fzf}/bin/fzf | ${pkgs.gawk}/bin/awk '{print $1}')\" ~/usb";
      neofetch = "fastfetch";
      generate-resume = "${pkgs.curl}/bin/curl -s https://gitconnected.com/v1/portfolio/kylejamesross | ${pkgs.nodejs_20}/bin/npx hackmyresume build /dev/stdin TO out/resume.all";
      generate-resume-into-clipboard = "${pkgs.curl}/bin/curl -s https://gitconnected.com/v1/portfolio/kylejamesross | ${pkgs.nodejs_20}/bin/npx hackmyresume build /dev/stdin TO genResume.txt && cat genResume.txt | wl-copy && rm genResume.txt";
    };
    plugins = [
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
    completionInit = ''
      autoload -Uz compinit && compinit
    '';
    initExtra = ''
      if [ -f "$HOME/.openai-api-key" ]; then
        export OPENAI_API_KEY=$(cat $HOME/.openai-api-key)
      fi

      if [ -f "$HOME/.github-token" ]; then
        export GH_TOKEN=$(cat $HOME/.github-token)
      fi

      PATH="$PATH:$HOME/.dotnet/tools"
    '';
  };
}
