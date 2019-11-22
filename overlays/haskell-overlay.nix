{pkg-def-extras}:

self: super:
let
  importCabal = args: import "${callCabalToNix args}";

  getSubdir = repo:
     if repo.subdir or "." == "." then "" else "/" + repo.subdir;

  fetchRepo = repo: (self.buildPackages.pkgs.fetchgit {
    url = repo.url;
    rev = repo.rev;
    sha256 = repo.sha256;
  }) + getSubdir repo;

  # Fetch public git repo and generate nix derivation
  fetchAndNix = { name, url, rev, subdir ? ".", sha256, cabal-file ? "${name}.cabal" }@repo:
    importCabal {
      src = fetchRepo repo;
      inherit name cabal-file;
    };

  inherit (self) haskell-nix;
  inherit (haskell-nix) mkPkgSet mkStackPkgSet stackage hackage callCabalToNix excludeBootPackages;

  pkg-set = mkStackPkgSet {
    stack-pkgs = {
      resolver = "lts-14.13";
      extras = hackage: {};
    };
    pkg-def-extras = pkg-def-extras {
      inherit haskell-nix;
    };
    modules = [{
      nonReinstallablePkgs =
          [ "rts" "ghc-heap" "ghc-prim" "integer-gmp" "integer-simple" "base"
            "deepseq" "array" "ghc-boot-th" "pretty" "template-haskell"
            "ghc-boot"
            "ghc" "Cabal" "Win32" "array" "binary" "bytestring" "containers"
            "directory" "filepath" "ghc-boot" "ghc-compact" "ghc-prim"
            "ghci" "haskeline"
            "hpc"
            "mtl" "parsec" "process" "text" "time" "transformers"
            "unix" "xhtml"
            "stm" "terminfo"
          ];
    }];
  };
in
{
  inherit pkg-set;
  ihaskellPackages = pkg-set.config.hsPkgs;
}
