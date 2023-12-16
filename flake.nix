{
  description = "Flake environment for STM32 Nucleo development boards";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: let
    system = "aarch64-linux";
  in {
    devShells."${system}".default = let
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
      { mkShell, clang, openocd, mkdocs, cmake, conan, gcc }:
      mkShell {
        nativeBuildInputs = [ clang openocd mkdocs cmake conan ];
        depsBuildBuild = [ gcc ];
      }
    ) {};
  };
}
