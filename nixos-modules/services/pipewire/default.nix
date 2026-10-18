{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.my.gui.enable {
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
