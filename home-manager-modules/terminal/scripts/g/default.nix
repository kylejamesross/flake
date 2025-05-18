{pkgs}:
pkgs.writeShellScriptBin "g" ''
  ${pkgs.nh}/bin/nh os switch
''
