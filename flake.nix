{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
  let
    allSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
      pkgs = import nixpkgs { inherit system; };
    });
  in
  {
    devShells = forAllSystems ({ pkgs }: {
      default = pkgs.mkShell {
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
    });
  };
}
