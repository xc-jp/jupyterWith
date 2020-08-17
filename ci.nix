{ # haskell.nix
haskell-nix ? import (builtins.fetchTarball {
  url =
    "https://github.com/input-output-hk/haskell.nix/archive/8fac80f3ea2e5195fcab9ad5c77d189cf6934b97.tar.gz";
  sha256 = "1xii1k58bd4ywvc7kf91cipp5hm3ja53907baz7wz2x5k7hds2rf";
}) { },
# jupyter-with
jupyter-with ? import ./default.nix,
# pkgs
pkgs ? import haskell-nix.sources.nixpkgs-2003 {
  overlays = haskell-nix.nixpkgsArgs.overlays ++ jupyter-with.overlays;
  config = haskell-nix.nixpkgsArgs.config;
} }:
with pkgs.jupyterWith;
let
  jupyterEnvironment = jupyterlabWith {
    kernels = with kernels; [
      (cKernelWith { name = "test"; })
      (gophernotes { name = "test"; })
      (iHaskellWith { name = "test"; })
      (iJavascript { name = "test"; })
      (iPythonWith { name = "test"; })
      (iRubyWith { name = "test"; })
    ];
  };
in jupyterEnvironment
