{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    plasma-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";

    consts = {
      username = "ali";
      hostName = "nixos";

      locale = "en_US.UTF-8";
      timeZone = "Asia/Tehran";
    };

    pkgs = import nixpkgs {
      inherit system;

      config.allowUnfree = true;
      config.input-fonts.acceptLicense = true;
    };
  in {
    # Available through 'nix fmt'
    formatter.${system} = pkgs.alejandra;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#nixos'
    nixosConfigurations = {
      ${consts.hostName} = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = {inherit inputs outputs consts;};
        system = system;
        modules = [./nixos/configuration.nix];
      };
    };

    # Home Manager configuration entrypoint
    # Available through 'home-manager --flake .#username@hostname'
    homeConfigurations = {
      ${consts.username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit inputs outputs consts;};
        modules = [
          inputs.plasma-manager.homeManagerModules.plasma-manager
          ./home/home.nix
        ];
      };
    };
  };
}
