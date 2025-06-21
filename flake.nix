{
  inputs = {
    cargo2nix.url = "github:cargo2nix/cargo2nix/release-0.12";
    flake-utils.follows = "cargo2nix/flake-utils";
    nixpkgs.follows = "cargo2nix/nixpkgs";
  };

  outputs =
    inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ cargo2nix.overlays.default ];
        };

        rustPkgs = pkgs.rustBuilder.makePackageSet {
          # rustVersion = "1.75.0";
          rustVersion = "1.86.0";
          packageFun = import ./Cargo.nix;
        };

      in
      rec {
        packages = {
          # replace hello-world with your package name
          cargo2nix-test = (rustPkgs.workspace.cargo2nix-test { });
          default = packages.cargo2nix-test;
        };
      }
    );
}
