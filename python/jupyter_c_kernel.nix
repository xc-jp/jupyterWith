{ lib
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "jupyter_c_kernel";
  version = "1.2.2";
  doCheck = false;

  src = fetchPypi {
    inherit pname version;
    sha256 = "e4b34235b42761cfc3ff08386675b2362e5a97fb926c135eee782661db08a140";
  };

  meta = with lib; {
    description = "Minimalistic C kernel for Jupyter";
    homepage = https://github.com/brendanrius/jupyter-c-kernel/;
    license = licenses.mit;
    maintainers = [];
  };
}
