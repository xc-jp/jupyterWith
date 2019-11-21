{ jupyter-with ? import ./default.nix {}
, pkgs ? import <nixpkgs> jupyter-with
}: pkgs
