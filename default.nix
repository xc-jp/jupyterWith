{ haskell-nix ? import (builtins.fetchTarball https://github.com/input-output-hk/haskell.nix/archive/8e248b37185186adf2c2ccb6520b1bdce9c44b0a.tar.gz)
, packages ? null
}:
let
  inherit (haskell-nix) overlays config;
in
{
  inherit config;
  overlays = overlays ++ (import ./overlays {
    inherit packages;
  });
}
