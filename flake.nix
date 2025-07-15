{
  description = "davelab Jekyll Build";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = rec {
          hello = pkgs.hello;
          default = hello;
        };
        apps = rec {
          hello = flake-utils.lib.mkApp { drv = self.packages.${system}.hello; };
          default = hello;
        };
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              (ruby.withPackages (
                ps: with ps; [
                  jekyll
                ]
              ))
            ];
          };
        };
      }
    );
}
