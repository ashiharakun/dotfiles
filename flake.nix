{
  description = "ashiharakun's nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-nixos.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs-nixos";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      home-manager,
      flake-parts,
      nixpkgs-nixos,
      treefmt-nix,
      ...
    }:
    let
      userName = "ashiharakun";
      homeDirFor =
        system:
        if inputs.nixpkgs.lib.hasSuffix "darwin" system then "/Users/${userName}" else "/home/${userName}";
    in
    flake-parts.lib.mkFlake { inherit inputs; } (
      { inputs, ... }: {
        systems = [
          "aarch64-darwin"
          "x86_64-linux"
          "aarch64-linux"
        ];

        perSystem = { system, pkgs, ... }: {
          formatter = treefmt-nix.lib.mkWrapper pkgs {
            projectRootFile = "flake.nix";
            programs = {
              nixfmt.enable = true;
            };
          };
        };

        flake =
          let
            unstablePkgsFor =
              system:
              import inputs.nixpkgs-unstable {
                inherit system;
                config.allowUnfree = true;
              };
            homeSystems = [
              "aarch64-darwin"
              "x86_64-linux"
              "aarch64-linux"
            ];
            homes = inputs.nixpkgs.lib.genAttrs homeSystems (
              system:
              home-manager.lib.homeManagerConfiguration {
                pkgs = inputs.nixpkgs.legacyPackages.${system};
                extraSpecialArgs = {
                  inherit self userName;
                  pkgs-unstable = unstablePkgsFor system;
                };
                modules = [
                  ./home-manager/hosts/ashiharakun.nix
                  {
                    home.username = userName;
                    home.homeDirectory = homeDirFor system;
                  }
                ];
              }
            );
            defaultHome =
              if inputs.nixpkgs.lib.hasAttr builtins.currentSystem homes then
                homes.${builtins.currentSystem}
              else
                homes."x86_64-linux";
          in
          {
            # Build darwin flake using:
            # $ darwin-rebuild build --flake .#mm1p
            darwinConfigurations."mm1p" = nix-darwin.lib.darwinSystem {
              specialArgs = { inherit self userName; };
              modules = [
                ./nix-darwin/mm1p.nix
                home-manager.darwinModules.home-manager
                {
                  home-manager = {
                    extraSpecialArgs = {
                      inherit self userName;
                      pkgs-unstable = unstablePkgsFor "aarch64-darwin";
                    };
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.${userName} = import ./home-manager/hosts/ashiharakun.nix;
                  };
                }
              ];
            };

            nixosConfigurations."paseri" = nixpkgs-nixos.lib.nixosSystem {
              specialArgs = { inherit self userName; };
              modules = [
                ./nixos/hosts/paseri/configuration.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    extraSpecialArgs = {
                      inherit self userName;
                      pkgs-unstable = unstablePkgsFor "aarch64-linux";
                    };
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.${userName} = import ./home-manager/hosts/ashiharakun.nix;
                  };
                }
              ];
            };

            nixosConfigurations."basil" = nixpkgs-nixos.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = { inherit self userName; };
              modules = [
                inputs.nixos-wsl.nixosModules.default
                ./nixos/hosts/basil/configuration.nix
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    extraSpecialArgs = {
                      inherit self userName;
                      pkgs-unstable = unstablePkgsFor "x86_64-linux";
                    };
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.${userName} = import ./home-manager/hosts/ashiharakun.nix;
                  };
                }
              ];
            };

            homeConfigurations = homes // {
              # convenience: `home-manager switch --flake .#${userName}`
              ${userName} = defaultHome;
            };
          };
      }
    );
}
