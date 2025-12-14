{
  description = "NixOS Flake Configuration (flake-parts edition)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    wallpapers = {
      url = "github:kylejamesross/wallpapers";
      flake = false;
    };
    stylix.url = "github:danth/stylix/release-25.11";
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/release-25.11";
    telescope-git-file-history-nvim = {
      url = "github:isak102/telescope-git-file-history.nvim";
      flake = false;
    };
    yazi-compress-plugin = {
      url = "github:KKV9/compress.yazi";
      flake = false;
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports = [
        ./flake-parts/nixos-configs.nix
        ./flake-parts/home-manager.nix
        ./flake-parts/packages.nix
      ];
    };
}
