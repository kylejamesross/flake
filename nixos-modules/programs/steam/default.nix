{
  lib,
  config,
  ...
}: {
  options.my.steam.enable = lib.mkEnableOption "Whether to enable steam";

  config = lib.mkIf config.my.steam.enable {
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
      gamemode.enable = true;
    };
  };
}
