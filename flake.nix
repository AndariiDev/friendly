{
  description = "A friendly traceback formatter for Python.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages.friendly-traceback = pkgs.python3Packages.buildPythonPackage rec {
          pname = "friendly-traceback";
          version = "0.7.53";           
          
          src = pkgs.fetchFromGitHub {
            owner = "friendly-traceback";
            repo = "friendly";
            rev = "fe5d3a2";
            sha256 = "sha256-7NNfrZnfEgPICMa8acY1rBhE2IE6Em+J2fANR0Ez208=";
          };

          pyproject = true;
          python-build-system = "setuptools";

          propagatedBuildInputs = with pkgs.python3Packages; [
            setuptools
            wheel
            rich
            colorama
            pygments
            # friendly-traceback
            # friendly-styles
            platformdirs
          ];

       };

        defaultPackage = self.packages.${system}.friendly-traceback;
      }
    );
}
