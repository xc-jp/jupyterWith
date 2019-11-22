{pkg-def-extras}:
[ (import ./python-overlay.nix)
  (import ./haskell-overlay.nix {
    inherit pkg-def-extras;
  })
  (import ./jupyter-overlay.nix)
]
