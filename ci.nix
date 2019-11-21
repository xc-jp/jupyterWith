{ pkgs ? import ./pkgs.nix {}
}:
with pkgs.jupyterWith;
let
  jupyterEnvironment = jupyterlabWith {
      kernels = with kernels; [
#        ( ansibleKernel {
#            name = "test";
#        })

        ( cKernelWith {
            name = "test";
        })

        ( gophernotes {
            name = "test";
        })

        ( iHaskellWith {
            name = "test";
        })

        ( iJavascript {
            name = "test";
        })

        ( iPythonWith {
            name = "test";
        })

        ( iRubyWith {
            name = "test";
        })

        ( juniperWith {
            name = "test";
        })
      ];
  };
in jupyterEnvironment
