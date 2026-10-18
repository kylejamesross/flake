_: {
  perSystem = {pkgs, ...}: {
    formatter = pkgs.alejandra;

    checks = {
      alejandra = pkgs.runCommand "alejandra-check" {nativeBuildInputs = [pkgs.alejandra];} ''
        alejandra --check ${../.}
        touch $out
      '';

      deadnix = pkgs.runCommand "deadnix-check" {nativeBuildInputs = [pkgs.deadnix];} ''
        deadnix --fail ${../.}
        touch $out
      '';

      statix = pkgs.runCommand "statix-check" {nativeBuildInputs = [pkgs.statix];} ''
        statix check ${../.}
        touch $out
      '';
    };
  };
}
