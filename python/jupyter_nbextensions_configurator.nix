{ buildPythonPackage
, fetchPypi
, jupyter_contrib_core
, pyyaml
}:

buildPythonPackage rec {
  # https://pypi.org/project/jupyter_nbextensions_configurator/#history
  pname = "jupyter_nbextensions_configurator";
  version = "0.4.1";
  src = fetchPypi {
    inherit pname version;
    sha256 = "e5e86b5d9d898e1ffb30ebb08e4ad8696999f798fef3ff3262d7b999076e4e83";
  };
  propagatedBuildInputs = [ jupyter_contrib_core pyyaml ];
  doCheck = false;
}
