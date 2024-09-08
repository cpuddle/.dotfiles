{
    description = "MY NIXOS-CONFIG";

    inputs = {
	nixpkgs.url = "nixpkgs/nixos-unstable";
	nur.url = "github:nix-community/NUR";

	hypr-contrib.url = "github:hyprwm/contrib";
	hyprpicker.url = "github:hyprwm/hyprpicker";

	alejandra.url = "github:kamadorueda/alejandra/3.0.0";

	nix-gaming.url = "github:fufexan/nix-gaming";
	
	home-manager = {
	    url = "github:nix-community/home-manager/master/";
	    inputs.nixpkgs.follows = "nixpkgs"; 
	};

	hyprland = {
     	    type = "git";
	    url = "https://github.com/hyprwm/Hyprland";
	    submodules = true;
	};
    };

    outputs = { self, nixpkgs, home-manager, ... } @ inputs:
	let
	    lib = nixpkgs.lib;
	    system = "x86_64-linux";
	    pkgs = nixpkgs.legacyPackages.${system};
	in {

	    nixosConfigurations = {
		collinpc = lib.nixosSystem {
		    inherit system;
		    modules = [ ./configuration.nix ];
		    specialArgs = { inherit inputs; };
		};
	    };

	    homeConfigurations = {
		collin = home-manager.lib.homeManagerConfiguration {
		    inherit pkgs;
		    modules = [ ./home.nix ];
		};
	    };
	};
}
