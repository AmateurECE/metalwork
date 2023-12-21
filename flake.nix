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
      in import ./. { inherit pkgs; }
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
          {
            mkShell,
            openocd, cmake, conan, gcc,
            mkdocs, python311Packages, packages
          }:
          mkShell {
            nativeBuildInputs = [
              openocd cmake conan
              mkdocs python311Packages.mkdocstrings
              python311Packages.mkdocs-material
              packages."${system}".python311Packages.mkdocstrings-cmake
            ];
            depsBuildBuild = [ gcc ];
          }
        ) { inherit packages; };
      }
    );
  };
}
