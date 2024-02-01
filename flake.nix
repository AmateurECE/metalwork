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
    packages = forAllSystems (system:
      let pkgs = import nixpkgs {
        inherit system;
      };
      in (outputs:
        outputs // {
          conan-config = outputs.lib.mkConanConfig { inherit system; };
        }
      ) (import ./. { inherit pkgs; })
    );

    devShells = forAllSystems(system:
      let pkgs = import nixpkgs {
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
              packages."${system}".conan-config
            ];

            buildInputs = with pkgs.pkgsBuildTarget; [ gcc ];
          })
        ) {};
      }
    );
  };
}
