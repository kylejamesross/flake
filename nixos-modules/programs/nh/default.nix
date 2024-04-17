{ unstable, user, ... }: 

{
  environment.sessionVariables = {
    FLAKE = "/home/${user}/flake";
  };

  environment.systemPackages = [
    unstable.nh
  ];

}
