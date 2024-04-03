{ pkgs, osConfig, ... }:

{
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        dotDir = ".config/zsh";
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
        history.size = 100000;
        shellAliases = {
            ls = "eza -bhal --icons --hyperlink --git --color auto";
            cat = "bat";
            pb = "git branch --merged | grep -v -E \"main|master|staging|dev|$(git rev-parse --abbrev-ref HEAD)\" > /tmp/merged-branches && vim /tmp/merged-branches && xargs git branch -d </tmp/merged-branches";
            n = "nvim";
            d7 = "nix shell nixpkgs#dotnet-sdk_7";
            fonts = "fc-list";
            wlogin = "az acr login -n nsolutionsacregistry";
            tsu = "sudo tailscale up --accept-routes";
            tsd = "sudo tailscale down";
            access-token = "az account get-access-token | jaq .accessToken | sed 's/\"//g' | wl-copy";
            g = "${osConfig.nixos-rebuild-command}";
        };
        plugins = [
            {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }
            {
                name = "powerlevel10k-config";
                src = ./p10k;
                file = ".p10k.zsh";
            }
            {
                name = "zsh-vi-mode";
                src = pkgs.zsh-vi-mode;
                file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
            }
        ];
        completionInit = '' 
                autoload -Uz compinit && compinit 
                eval "$(zoxide init zsh)"
        '';
        initExtra = ''
            if [ -f "$HOME/.feed-access-token" ]; then
              export FEED_ACCESSTOKEN=$(cat $HOME/.feed-access-token)
              export ENV DOTNET_SYSTEM_NET_HTTP_USESOCKETSHTTPHANDLER=0
              export VSS_NUGET_EXTERNAL_FEED_ENDPOINTS="{\"endpointCredentials\": [{\"endpoint\":\"https://pkgs.dev.azure.com/nueradev/NuAgile/_packaging/NudeSolutions/nuget/v3/index.json\", \"username\":\"docker\", \"password\":\"$(cat $HOME/.feed-access-token)\"},{\"endpoint\":\"https://pkgs.dev.azure.com/nueradev/ProjectVicious/_packaging/NudeGet/nuget/v3/index.json\", \"username\":\"docker\", \"password\":\"$(cat $HOME/.feed-access-token)\"}]}"
            fi

            if [ -f "$HOME/.openai-api-key" ]; then
              export OPENAI_API_KEY=$(cat $HOME/.openai-api-key)
            fi

            PATH="$PATH:$HOME/.local/bin"
            PATH="$PATH:/usr/share/dotnet"
            PATH="$PATH:$HOME/.dotnet/tools"
        '';
    };
}
