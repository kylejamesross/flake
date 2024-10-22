{
  pkgs,
  user,
  ...
}: {
  users.users.${user} = {
    shell = pkgs.fish;
    ignoreShellProgramCheck = true; # Defined in home manager modules
  };
}
