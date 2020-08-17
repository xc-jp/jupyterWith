self: super:
let inherit (self.haskell-nix) mkStackPkgSet;
in {
  ihaskell-pkg-def-extras = [
    (hackage: {
      ihaskell-aeson = hackage.ihaskell-aeson."0.3.0.1".revisions.default;
      ihaskell-blaze = hackage.ihaskell-blaze."0.3.0.1".revisions.default;
      ihaskell-charts = hackage.ihaskell-charts."0.3.0.1".revisions.default;
      ihaskell-diagrams = hackage.ihaskell-diagrams."0.3.2.1".revisions.default;
      ihaskell-gnuplot = hackage.ihaskell-gnuplot."0.1.0.1".revisions.default;
      ihaskell-graphviz = hackage.ihaskell-graphviz."0.1.0.0".revisions.default;
      ihaskell-hatex = hackage.ihaskell-hatex."0.2.1.1".revisions.default;
      ihaskell-juicypixels =
        hackage.ihaskell-juicypixels."1.1.0.1".revisions.default;
      ihaskell-magic = hackage.ihaskell-magic."0.3.0.1".revisions.default;
      ihaskell-plot = hackage.ihaskell-plot."0.3.0.1".revisions.default;
      ihaskell-rlangqq = hackage.ihaskell-rlangqq."0.3.0.0".revisions.default;
      ihaskell-widgets = hackage.ihaskell-widgets."0.2.3.3".revisions.default;
      ihaskell-hvega = hackage.ihaskell-hvega."0.2.0.2".revisions.default;
    })
  ];
  ihaskellPackages = (mkStackPkgSet {
    stack-pkgs = {
      resolver = "lts-14.13";
      extras = hackage: { };
    };
    pkg-def-extras = self.ihaskell-pkg-def-extras;
  }).config.hsPkgs;
}
