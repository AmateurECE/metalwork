{ stdenv, lib }: {
  mkConanConfig = { system }:
    stdenv.mkDerivation {
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

      buildPhase = ''
        install -Dm644 settings.yml -t $out/conan
        install -Dm644 remotes.json -t $out/conan
        install -Dm644 profile.toml $out/conan/profiles/default

        install -Dm644 arm-none-eabi-newlib.cmake -t $out
        echo "tools.cmake.cmaketoolchain:user_toolchain=[\"$out/arm-none-eabi-newlib.cmake\"]" > $out/conan/global.conf
      '';
    };
}
