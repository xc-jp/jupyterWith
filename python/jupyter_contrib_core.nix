{ buildPythonPackage
, fetchPypi
, traitlets
, notebook
, tornado
}:

buildPythonPackage rec {
  # https://pypi.org/project/jupyter_contrib_core/#history
  pname = "jupyter_contrib_core";
  version = "0.3.3";
  src = fetchPypi {
    inherit pname version;
    sha256 = "e65bc0e932ff31801003cef160a4665f2812efe26a53801925a634735e9a5794";
  };
  doCheck = false;
  propagatedBuildInputs = [ traitlets notebook tornado ];
}
