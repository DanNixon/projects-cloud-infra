{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in rec {
        devShell = pkgs.mkShell {
          packages = (with pkgs; [
            kapp

            kubernetes-helm

            sops
            vals

            influxdb2-cli
          ])
          ++ pkgs.lib.optionals pkgs.stdenv.isDarwin (with pkgs; [ libiconv ]);

          shellHook = ''
            export SOPS_PGP_FP="84E956241243C35EA286B410EA06B7ABA96D6BB8"
            export KAPP_NAMESPACE="kapp"
          '';
        };
      }
    );
}
