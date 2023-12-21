{ lib
, python311Packages
, nix-gitignore
}:

with python311Packages;

buildPythonPackage rec {
  pname = "mkdocstrings-cmake";
  version = "0.1.0";
  format = "pyproject";

  src = nix-gitignore.gitignoreSource [ ] ./.;

  disable = pythonOlder "3.8";

  nativeBuildInputs = [
    pdm-backend
  ];

  propagatedBuildInputs = [
    mkdocstrings
  ];

  pythonImportsCheck = [
    "mkdocstrings_handlers"
  ];

  meta = with lib; {
    description = "CMake handler for mkdocstrings";
    homepage = "https://github.com/AmateurECE/metalwork";
  };
}
