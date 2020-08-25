{ lib, buildPythonPackage, fetchPypi, python, isPy27
, attrs
, functools32
, importlib-metadata
, pyrsistent
, setuptools_scm
}:

buildPythonPackage rec {
  # https://pypi.org/project/jsonschema/#history
  pname = "jsonschema";
  version = "3.2.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0ykr61yiiizgvm3bzipa3l73rvj49wmrybbfwhvpgk3pscl5pa68";
  };

  nativeBuildInputs = [ setuptools_scm ];
  propagatedBuildInputs = [ attrs importlib-metadata functools32 pyrsistent ];

  # zope namespace collides on py27
  doCheck = false;
  checkPhase = ''
    nosetests
  '';

  meta = with lib; {
    homepage = https://github.com/Julian/jsonschema;
    description = "An implementation of JSON Schema validation for Python";
    license = licenses.mit;
    maintainers = with maintainers; [ domenkozar ];
  };
}
