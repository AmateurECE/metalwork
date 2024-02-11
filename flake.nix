{
  description = "Flake environment for STM32 Nucleo development boards";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: let
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
    ];
  in rec {
    lib = import ./lib {};

    packages = forAllSystems (system:
      let pkgs = import nixpkgs {
        inherit system;
      };
      in import ./. { inherit pkgs; }
    );

    devShells = forAllSystems(system:
      let
        pkgs = import nixpkgs {
          inherit system;
          crossSystem = {
            config = "arm-none-eabi";
            libc = "newlib";
            gcc = {
              cpu = "cortex-m4";
              fpu = "fpv4-sp-d16";
            };
          };
        };
        conan-config = lib.mkConanConfig pkgs;
      in {
        default = pkgs.callPackage (
          {}: pkgs.mkShell ({
            # https://ryantm.github.io/nixpkgs/stdenv/cross-compilation/
            nativeBuildInputs =
              with pkgs.pkgsBuildHost;
              with python311Packages;
              with packages."${system}".pkgsBuildHost.python311Packages;
            [
              openocd
              cmake
              conan
              mkdocs
              mkdocstrings
              mkdocs-material
              mkdocstrings-cmake
              conan-config
            ];

            buildInputs = with pkgs.pkgsBuildTarget; [ gcc ];

            shellHook = ''
              conan config install ${conan-config}/conan
            '';
          })
        ) {};
      }
    );
  };
}
