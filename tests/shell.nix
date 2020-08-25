# Test derivation for xc-jp/jupyterWith
#
# https://github.com/xc-jp/jupyterWith#getting-started
#
# Usage
#
#    nix-shell shell.nix -A env
#    jupyter lab
#

{nixpkgs ? builtins.fetchTarball {
  url = "https://github.com/NixOS/nixpkgs/archive/2cd2e7267e5b9a960c2997756cb30e86f0958a6b.tar.gz";
  sha256 = "0ir3rk776wldyjz6l6y5c5fs8lqk95gsik6w45wxgk6zdpsvhrn5";
}}:

let

  haskell-nix = import (builtins.fetchTarball {
    url = "https://github.com/input-output-hk/haskell.nix/archive/8fac80f3ea2e5195fcab9ad5c77d189cf6934b97.tar.gz";
    sha256 = "1xii1k58bd4ywvc7kf91cipp5hm3ja53907baz7wz2x5k7hds2rf";
  }) { };

  jupyter-with = import ../.;

  pkgs = import nixpkgs {
    overlays = haskell-nix.nixpkgsArgs.overlays ++ jupyter-with.overlays;
  };

  iPython = pkgs.jupyterWith.kernels.iPythonWith {
    name = "python";
    packages = p: with p; [ ];
  };

  iHaskell = pkgs.jupyterWith.kernels.iHaskellWith {
    name = "haskell";
    packages = p: with p; [ hvega formatting ];
  };

  jupyterEnvironment = pkgs.jupyterWith.jupyterlabWith {
    kernels = [ iPython iHaskell ];
  };
in
  jupyterEnvironment
