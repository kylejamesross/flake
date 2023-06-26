if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [ -f "$HOME/.feed-access-token" ]; then
  export FEED_ACCESSTOKEN=$(cat $HOME/.feed-access-token)
  export ENV DOTNET_SYSTEM_NET_HTTP_USESOCKETSHTTPHANDLER=0
  export VSS_NUGET_EXTERNAL_FEED_ENDPOINTS="{\"endpointCredentials\": [{\"endpoint\":\"https://pkgs.dev.azure.com/nueradev/NuAgile/_packaging/NudeSolutions/nuget/v3/index.json\", \"username\":\"docker\", \"password\":\"$(cat $HOME/.feed-access-token)\"},{\"endpoint\":\"https://pkgs.dev.azure.com/nueradev/ProjectVicious/_packaging/NudeGet/nuget/v3/index.json\", \"username\":\"docker\", \"password\":\"$(cat $HOME/.feed-access-token)\"}]}"
fi

if [ -f "$HOME/.openai-api-key" ]; then
  export OPENAI_API_KEY=$(cat $HOME/.openai-api-key)
fi

PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:$HOME/.dotfiles/bin"
PATH="$PATH:/usr/share/dotnet"
PATH="$PATH:$HOME/.dotnet/tools"

# advanced completions
autoload -Uz compinit && compinit
