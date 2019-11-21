self: super: {
  python3 = super.python3.override (old: {
    packageOverrides = pself: psuper: {
      jupyterlab = pself.callPackage ../python/jupyterlab.nix {};
      jupyterlab_server = pself.callPackage ../python/jupyterlab_server.nix {};
      pyjson5 = pself.callPackage ../python/pyjson5.nix {};
      jsonschema = pself.callPackage ../python/jsonschema.nix {};
      notebook = pself.callPackage ../python/notebook.nix {};
      jupyter_c_kernel = pself.callPackage ../python/jupyter_c_kernel.nix {};
      jupyter_contrib_core = pself.callPackage ../python/jupyter_contrib_core.nix {};
      jupyter_nbextensions_configurator = pself.callPackage ../python/jupyter_nbextensions_configurator.nix {};
    };
  });
}
