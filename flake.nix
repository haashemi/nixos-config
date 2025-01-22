{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      system = "x86_64-linux";

      consts = {
        username = "ali";
        hostName = "nixos";

        locale = "en_US.UTF-8";
        timeZone = "Asia/Tehran";
      };
    in
    {
      formatter = nixpkgs.legacyPackages.${system}.alejandra;

      # TODO: Find out the use case of these
      # nixosModules = import ./modules/nixos;
      # homeManagerModules = import ./modules/home-manager;

      nixosConfigurations = {
        "${consts.hostName}" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs outputs consts; };
          system = system;
          modules = [
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ali = import ./home-manager/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs outputs consts; };
            }
          ];
        };
      };
    };
}
