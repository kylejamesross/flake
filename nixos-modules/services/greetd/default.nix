{
  lib,
  config,
  pkgs,
  ...
}: {
  config = lib.mkIf config.my.gui.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd '${pkgs.hyprland}/bin/start-hyprland'";
        };
      };
    };
  };
}
