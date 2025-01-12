{
  description = "Dev env for this project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        # pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            # pkgs.stylua
            # pkgs-unstable.gleam
          ];
        };
      }
    );
}
