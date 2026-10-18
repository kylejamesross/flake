{
  lib,
  config,
  ...
}: {
  options.my.keyd.enable = lib.mkEnableOption "Whether to enable keyd";

  config = lib.mkIf config.my.keyd.enable {
    services.keyd = {
      enable = true;
      keyboards.default = {
        settings = {
          main = {
            capslock = "overload(control, esc)";
          };
        };
      };
    };
  };
}
