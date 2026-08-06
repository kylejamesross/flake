{
  lib,
  config,
  ...
}: {
  options.sunshine.enable = lib.mkEnableOption "Whether to enable sunshine";

  config = lib.mkIf config.sunshine.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
      settings = {
        output_name = "HDMI-A-1";
      };
    };
  };
}
