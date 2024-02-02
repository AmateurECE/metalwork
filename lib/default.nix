{ stdenv, lib }: {
  mkConanConfig = { system }:
    stdenv.mkDerivation rec {
      name = "conan-config";

      # Build Platform is reachable as stdenv.buildPlatform
      # Target Platform is reachable as stdenv.targetPlatform
      src = lib.fileset.toSource {
        root = ./.;
        fileset = lib.fileset.unions [
          ./settings.yml
          ./remotes.json
          ./profile.toml
        ];
      };

      buildPhase = ''
        install -Dm644 settings.yml -t $out
        install -Dm644 remotes.json -t $out
        install -Dm644 profile.toml $out/profiles/default
      '';
    };
}
