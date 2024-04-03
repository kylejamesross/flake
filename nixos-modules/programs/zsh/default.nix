{ pkgs, user, ...}:

{
    users.users.${user} = {
        shell = pkgs.zsh;
        ignoreShellProgramCheck = true; # Defined in home manager modules
    };
}
