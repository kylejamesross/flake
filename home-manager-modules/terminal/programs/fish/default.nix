{pkgs, ...}: {
  stylix.targets.fish.enable = false;
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "${pkgs.eza}/bin/eza -bal --icons --hyperlink --git --color auto";
      cat = "${pkgs.bat}/bin/bat";
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
