{
  lib,
  config,
  ...
}: {
  options.steam.enable = lib.mkEnableOption "Whether to enable steam";

  config = lib.mkIf config.steam.enable {
    programs.steam.enable = true;
    # programs.steam.gamescopeSession.enable = true;
    # mangohud enabled in home manager

    programs.gamemode.enable = true;
    # gamemoderun mangohud %command%
  };
}
