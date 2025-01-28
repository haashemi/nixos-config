{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    impurity.url = "github:outfoxxed/impurity.nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    impurity,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # nh os switch .
    # sudo nixos-rebuild switch --flake .
    nixosConfigurations = {
      g15 = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [./hosts/g15/configuration.nix];
      };
    };

    # IMPURITY_PATH=$(pwd) nh home switch . -- --impure
    # IMPURITY_PATH=$(pwd) home-manager switch --flake . --impure
    homeConfigurations = {
      "ali@g15" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          {
            imports = [impurity.nixosModules.impurity];
            impurity.enable = true;
            impurity.configRoot = self;
          }

          ./hosts/g15/home/ali.nix
        ];
      };
    };
  };
}
