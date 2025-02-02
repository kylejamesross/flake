{pkgs, ...}: {
  stylix.targets.fish.enable = false;
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza -bal --icons --hyperlink --git --color auto";
      cat = "${pkgs.bat}/bin/bat";
      sb = "${pkgs.git}/bin/git branch | ${pkgs.fzf}/bin/fzf | xargs -I {} ${pkgs.git}/bin/git switch {}";
      pb = "${pkgs.git}/bin/git branch | ${pkgs.fzf}/bin/fzf --multi | xargs -I {} ${pkgs.git}/bin/git branch -D {}";
      pbe = "${pkgs.git}/bin/git branch --merged | grep -v -E \"main|master|staging|dev|$(git rev-parse --abbrev-ref HEAD)\" > /tmp/merged-branches && ${pkgs.neovim}/bin/nvim /tmp/merged-branches && xargs ${pkgs.git}/bin/git branch -d </tmp/merged-branches";
      g = "${pkgs.nh}/bin/nh os switch";
      musb = "mkdir -p ~/usb && sudo mount \"/dev/$(lsblk --list | ${pkgs.fzf}/bin/fzf | ${pkgs.gawk}/bin/awk '{print $1}')\" ~/usb";
      generate-resume = "${pkgs.curl}/bin/curl -s https://gitconnected.com/v1/portfolio/kylejamesross | ${pkgs.nodejs_22}/bin/npx hackmyresume build /dev/stdin TO out/resume.all";
      generate-resume-into-clipboard = "${pkgs.curl}/bin/curl -s https://gitconnected.com/v1/portfolio/kylejamesross | ${pkgs.nodejs_22}/bin/npx hackmyresume build /dev/stdin TO genResume.txt && cat genResume.txt | wl-copy && rm genResume.txt";
    };
    interactiveShellInit =
      /*
      fish
      */
      ''
        fish_vi_key_bindings

        set fish_greeting ""

        if test -f $HOME/.anthropic_api_key
            set -x ANTHROPIC_API_KEY (cat $HOME/.anthropic_api_key)
            set -x CLAUDE_API_KEY (cat $HOME/.anthropic_api_key)
        end

        if test -f $HOME/.openai-api-key
            set -x OPENAI_API_KEY (cat $HOME/.openai-api-key)
        end

        if test -f $HOME/.github-token
          set -x GH_TOKEN (cat $HOME/.github-token)
        end

        if test -f $HOME/.work_azure_devops_pull_request_token
          set -x AZURE_DEVOPS_EXT_PAT (cat $HOME/.work_azure_devops_pull_request_token)
        end

        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
  };
}
