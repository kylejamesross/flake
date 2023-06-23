#
# Bar
#

{ config, lib, pkgs, host, user, ...}:

{
  home-manager.users.${user} = {
    programs.waybar = {
      enable = true;
      systemd ={
        enable = true;
        target = "sway-session.target";
      };
    };
  };
}
