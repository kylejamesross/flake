{pkgs}:
pkgs.stdenv.mkDerivation {
  pname = "tf";
  version = "14.139.0";

  src = pkgs.fetchurl {
    url = "https://github.com/microsoft/team-explorer-everywhere/releases/download/14.139.0/TEE-CLC-14.139.0.zip";
    sha256 = "sha256-4Vu1NTy0Whun4M8ErHge+Uf/CrSSJpU2rEiBpsGdG4w=";
  };

  nativeBuildInputs = [pkgs.unzip pkgs.makeWrapper];

  installPhase = ''
    install -D -m755 -d "$out/share/tf"
    cp -r ./* "$out/share/tf/"
    mkdir -p "$out/bin"
    makeWrapper "$out/share/tf/tf" "$out/bin/tf" \
      --prefix PATH : ${pkgs.jdk8}/bin
  '';

  meta = with pkgs.lib; {
    description = "Team Explorer Everywhere Command-line Client for TFS";
    homepage = "https://github.com/microsoft/team-explorer-everywhere";
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = [];
  };
}
