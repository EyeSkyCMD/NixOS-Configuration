{
  description = "NixOS with Hyprland + Caelestia shell";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";
    nvf.url = "github:NotAShelf/nvf";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvf,
    ...
  } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
      ];
    };

    homeConfigurations."eyesky" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
      extraSpecialArgs = {inherit inputs;};
      modules = [
        ./home.nix
        inputs.spicetify-nix.homeManagerModules.spicetify
        inputs.caelestia-shell.homeManagerModules.default
      ];
    };
  };
}
