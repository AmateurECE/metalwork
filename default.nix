{ pkgs }: {
  pkgsBuildHost = {
    python311Packages = {
      mkdocstrings-cmake = pkgs.callPackage ./mkdocstrings-cmake { };
    };
  };
}
