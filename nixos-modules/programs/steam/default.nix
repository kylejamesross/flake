
{ pkgs, user, ... }:

{
    programs.steam.enable = true;
    # programs.steam.gamescopeSession.enable = true;

    environment.systemPackages = with pkgs; [
        protonup
        mangohud
    ];

    environment.sessionVariables = {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${user}/.steam/root/compatibilitytools.d";
    };

    programs.gamemode.enable = true;
    # gamemoderun mangohud %command%
}
