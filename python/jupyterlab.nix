{ lib
, buildPythonPackage
, fetchPypi
, jupyterlab_server
, notebook
, pythonOlder
}:

buildPythonPackage rec {
  # https://jupyterlab.readthedocs.io/en/stable/getting_started/changelog.html
  # https://pypi.org/project/jupyterlab/#history
  pname = "jupyterlab";
  version = "2.2.6";
  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1zv3j8m8z8kycqy3n9cyz3khvmqicmy57v35w40024nds8ib0m35";
  };

  propagatedBuildInputs = [ jupyterlab_server notebook ];

  makeWrapperArgs = [
    "--set" "JUPYTERLAB_DIR" "$out/share/jupyter/lab"
  ];

  # Depends on npm
  doCheck = false;

  meta = with lib; {
    description = "Jupyter lab environment notebook server extension.";
    license = with licenses; [ bsd3 ];
    homepage = "https://jupyter.org/";
    maintainers = with maintainers; [ zimbatm costrouc ];
  };
}
