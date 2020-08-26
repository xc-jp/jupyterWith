{ pkgs }:

{
  generateDirectory = pkgs.writeScriptBin "generate-directory" ''
    if [ $# -eq 0 ]
      then
        echo "Usage: generate-directory [EXTENSION]"
      else
        DIRECTORY="./jupyterlab"
        echo "Generating directory '$DIRECTORY' with extensions:"
        for EXT in "$@"; do echo "- $EXT"; done
        ${pkgs.python3Packages.jupyterlab}/bin/jupyter-labextension install "$@" --app-dir="$DIRECTORY"
        chmod -R +w "$DIRECTORY"/*
        rm -rf "$DIRECTORY"/staging
    fi
  '';

  # Creates a JUPYTERLAB_DIR with the given extensions.
  # This operation is impure, so it requires `--option sandbox false`.
  #
  # The `extensions` list elements can be “the name of a valid JupyterLab
  # extension npm package on npm,” or “can be a local directory containing
  # the extension, a gzipped tarball, or a URL to a gzipped tarball.”
  # See
  # https://jupyterlab.readthedocs.io/en/stable/user/extensions.html#installing-extensions
  mkDirectoryWith = { extensions }:
    let extStr = pkgs.lib.concatStringsSep " " extensions; in

    pkgs.stdenv.mkDerivation {
      name = "jupyterlab-extended";
      phases = "installPhase";
      buildInputs = with pkgs; [ python3Packages.jupyterlab nodejs  ];
      installPhase = ''
        export HOME=$TMP
        mkdir -p appdir/staging
        cp ${jupyter}/lib/python3.[7-9]/site-packages/jupyterlab/staging/yarn.lock appdir/staging
        chmod +w appdir/staging/yarn.lock
        jupyter labextension install ${extStr} --app-dir=appdir --debug
        rm -rf appdir/staging/node_modules
        mkdir -p $out
        cp -r appdir/* $out
      '';
    };

  # https://jupyterlab.readthedocs.io/en/stable/user/extensions.html#jupyterlab-build-process
  # From a jupyter labextension source directory, run the `npm run build`
  # step. Produces an output which can be passed to
  # `jupyter labextension install`, which means the output can be passed
  # as one of the `extensions` arguments to `mkDirectoryWith`.
  mkBuildExtension = srcPath: pkgs.stdenv.mkDerivation {
    name = "labextension-source";
    src = srcPath;
    buildInputs = [ pkgs.nodejs ];
    buildPhase = ''
      export HOME=$TMP
      npm install
      npm run build
      '';
    installPhase = ''
      mkdir -p $out/
      cp -r * $out/
      '';
  };
}
