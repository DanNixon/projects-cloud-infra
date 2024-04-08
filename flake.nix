{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = [
      "x86_64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
      "aarch64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    devShells = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      default = pkgs.mkShell {
        packages = with pkgs; [
          # Deployment tools
          kapp

          # Manifest rendering tools
          kubernetes-helm

          # Secret management
          sops
          vals

          # Code formatting tools
          alejandra
          treefmt
          mdl

          # Application tools
          influxdb2-cli
        ];

        shellHook = ''
          export KAPP_NAMESPACE="kapp"
          export SOPS_PGP_FP="84E956241243C35EA286B410EA06B7ABA96D6BB8"
        '';
      };
    });
  };
}
