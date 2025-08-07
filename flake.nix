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
          version = "0.7.53"; # <--- You'll need to update this to the latest version.
          
          # This is where you specify the source code.
          # We'll use a fetchFromGitHub to get the source.
          src = pkgs.fetchFromGitHub {
            owner = "friendly-traceback";
            repo = "friendly";
            # You'll need to find the specific commit hash for the version you're packaging.
            rev = "fe5d3a2";
            # The sha256 can be calculated using 'nix-prefetch-url --unpack <URL>' or by running a build and seeing the error.
            sha256 = "sha256-0hm9jihn2vc02mp58lghg3p8fa47sm4z2ighjahd5b5w2kf8dnd6"; # <--- Replace with the correct hash.
          };

          # This is for any dependencies that need to be built from Nixpkgs.
          propagatedBuildInputs = with pkgs.python3Packages; [
            # Add any dependencies here, e.g.,
            setuptools
            wheel
            # packaging
            # etc.
          ];

          # Check if the project has tests and how to run them.
          # You might not need this for a first pass, but it's good practice.
          # doCheck = false;
        };

        defaultPackage = self.packages.${system}.friendly-traceback;
      }
    );
}
