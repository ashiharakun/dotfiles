{
  description = "ashiharakun's nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, nix-darwin, home-manager, flake-parts, ... }:
    let
      userName = "ashiharakun";
      homeDirFor = system:
        if inputs.nixpkgs.lib.hasSuffix "darwin" system
        then "/Users/${userName}"
        else "/home/${userName}";
    in
    flake-parts.lib.mkFlake { inherit inputs; } ({ inputs, ... }: {
      systems = [ "aarch64-darwin" "x86_64-linux" "aarch64-linux" ];

      perSystem = { system, pkgs, ... }:
        let
          hookSettings = import ./git-hooks.nix;
          preCommitCheck = inputs.git-hooks.lib.${system}.run {
            src = ./.;
            hooks = hookSettings;
          };
        in
        {
          formatter = pkgs.nixpkgs-fmt;
          devShells.default = pkgs.mkShell {
            inherit (preCommitCheck) shellHook;
          };
          checks.pre-commit = preCommitCheck;
        };

      flake =
        let
          homeSystems = [ "aarch64-darwin" "x86_64-linux" "aarch64-linux" ];
          homes = inputs.nixpkgs.lib.genAttrs homeSystems (system:
            home-manager.lib.homeManagerConfiguration {
              pkgs = inputs.nixpkgs.legacyPackages.${system};
              extraSpecialArgs = { inherit self userName; };
              modules = [
                ./home-manager/hosts/ashiharakun.nix
                {
                  home.username = userName;
                  home.homeDirectory = homeDirFor system;
                }
              ];
            });
          defaultHome =
            if inputs.nixpkgs.lib.hasAttr builtins.currentSystem homes
            then homes.${builtins.currentSystem}
            else homes."x86_64-linux";
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
                  extraSpecialArgs = { inherit self userName; };
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.${userName} = import ./home-manager/hosts/ashiharakun.nix;
                };
              }
            ];
          };

          homeConfigurations =
            homes
            // {
              # convenience: `home-manager switch --flake .#${userName}`
              ${userName} = defaultHome;
            };
        };
    });
}
