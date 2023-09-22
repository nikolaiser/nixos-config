{
  description = "nikolaiser's nixos config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-flake = {
      #url = git+file:///home/nikolaiser/Documents/nvim-config;
      url = github:nikolaiser/nvim-config;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
    in
    {
      homeConfigurations = import ./outputs/home-conf.nix { inherit inputs system; };
      nixosConfigurations = import ./outputs/nixos-conf.nix { inherit inputs system; };
    };
}
