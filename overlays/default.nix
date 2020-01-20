let
  inherit (import ../lib/null.nix) removeNulls;
in
{packages}:
[ (import ./python-overlay.nix)
  (import ./haskell-overlay.nix (removeNulls { inherit packages; }))
  (import ./jupyter-overlay.nix)
]
