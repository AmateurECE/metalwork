{
  description = "Flake environment for STM32 Nucleo development boards";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: let
    system = "aarch64-linux";
  in rec {
    packages."${system}" = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in import ./mkdocstrings-handlers { inherit pkgs; };

    devShells."${system}".default = let
      inherit packages;
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
    in pkgs.callPackage (
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
  };
}
