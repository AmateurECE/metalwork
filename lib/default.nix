{ }: {
  mkConanConfig = { stdenv, lib, writeText, pkgsBuildHost, ... }:
    let
      global = writeText "global.conf" ''
        tools.cmake.cmaketoolchain:user_toolchain=["<%= out %>/arm-none-eabi-newlib.cmake"]
        tools.build.cross_building:can_run=False
      '';
    in stdenv.mkDerivation {
      name = "conan-config";

      # Build Platform is reachable as stdenv.buildPlatform
      # Target Platform is reachable as stdenv.targetPlatform
      src = lib.fileset.toSource {
        root = ./.;
        fileset = lib.fileset.unions [
          ./settings.yml
          ./remotes.json
          ./profile.toml
          ./arm-none-eabi-newlib.cmake
        ];
      };

      nativeBuildInputs = with pkgsBuildHost; [ ruby ];

      buildPhase = ''
        install -Dm644 settings.yml -t $out/conan
        install -Dm644 remotes.json -t $out/conan
        erb out=$out ${global} > $out/conan/global.conf
        install -Dm644 profile.toml $out/conan/profiles/default

        install -Dm644 arm-none-eabi-newlib.cmake -t $out
      '';
    };
}
