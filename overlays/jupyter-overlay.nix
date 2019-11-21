self: pkgs:
let
  inherit (self.jupyterWith) kernelsString;

  # Python version setup.
  python3 = self.python3Packages;

  # Default configuration.
  defaultDirectory = "${python3.jupyterlab}/share/jupyter/lab";

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

  # JupyterLab with the appropriate kernel and directory setup.
  jupyterlabWith = { directory ? defaultDirectory, kernels ? [] }:
    let
      # PYTHONPATH setup for JupyterLab
      pythonPath = python3.makePythonPath [
        python3.ipykernel
        python3.jupyter_contrib_core
        python3.jupyter_nbextensions_configurator
        python3.tornado
      ];

      # JupyterLab executable wrapped with suitable environment variables.
      jupyterlab = python3.toPythonModule (
        python3.jupyterlab.overridePythonAttrs (oldAttrs: {
          makeWrapperArgs = [
            "--set JUPYTERLAB_DIR ${directory}"
            "--set JUPYTER_PATH ${kernelsString kernels}"
            "--set PYTHONPATH ${pythonPath}"
          ];
        })
      );

      env = pkgs.mkShell {
        name = "jupyterlab-shell";
        buildInputs =
          [ jupyterlab generateDirectory pkgs.nodejs-12_x ] ++ (map (k: k.runtimePackages) kernels);
        shellHook = ''
          export JUPYTER_PATH=${kernelsString kernels}
          export JUPYTERLAB=${jupyterlab}
        '';
      };
    in
      jupyterlab.override (oldAttrs: {
        passthru = oldAttrs.passthru or {} // { inherit env; };
      });
in {
  jupyterWith = {
    inherit jupyterlabWith;
    kernels = {
      iHaskellWith = self.callPackage ../kernels/ihaskell;
      juniperWith = self.callPackage ../kernels/juniper;
      iPythonWith = self.callPackage ../kernels/ipython;
      iRubyWith = self.callPackage ../kernels/iruby;
      cKernelWith = self.callPackage ../kernels/ckernel;
      # ansibleKernel = self.callPackage ../kernels/ansible-kernel;
      xeusCling = self.callPackage ../kernels/xeus-cling;
      iJavascript = self.callPackage ../kernels/ijavascript;
      gophernotes = self.callPackage ../kernels/gophernotes;
    };
    kernelsString = pkgs.lib.concatMapStringsSep ":" (k: "${k.spec}");
  };
}
