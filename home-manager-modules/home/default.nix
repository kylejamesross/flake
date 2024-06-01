{ user, ... }:

{
    home = {
        username = "${user}";
        homeDirectory = "/home/${user}";
        stateVersion = "22.05";
    };

    programs.home-manager.enable = true;
    stylix.targets.waybar.enable = false;
}
