{
  description = "Flake utils demo";

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
        packages = {
          # install gems from gemset.nix
          # run `bundle exec jekyll build` and copy output dir
          # https://nixos.wiki/wiki/Packaging/Ruby
          default = pkgs.stdenv.mkDerivation {
            name = "davelab-site";
            src = self;
            version = "0.1a";
            inputs = [ ];
            buildPhase = '''';
          };
        };
        devShells = {
          default = pkgs.mkShell {
            packages = with pkgs; [
              ruby
              bundix
              imagemagick
              tidyp
              prettier
              vscode-langservers-extracted
            ];
            shellHook = ''
              export JEKYLL_NO_BUNDLER_REQUIRE=true
              alias -- jekyll-serve="bundle exec jekyll serve -H localhost"
              alias -- jekyll-build="JEKYLL_ENV=production jekyll build"

              echo "- 'bundle install' to install or update dependencies"
              echo "- 'jekyll-serve' to run dev server"
              echo "- 'jekyll-build' to build the production version"
            '';
          };
        };
      }
    );
}
