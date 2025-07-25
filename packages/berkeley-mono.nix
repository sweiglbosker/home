{ pkgs }:

pkgs.stdenv.mkDerivation {
  pname = "berkeley-mono";
  version = "1.0";

  src = ../assets/berkeley-mono.tar.gz;

  unpackPhase = ''
    runHook preUnpack

    tar -xzf $src

    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    install -Dm644 BerkeleyMonoPatchedNerdFont-Regular.ttf BerkeleyMonoPatchedNerdFontPropo-Regular.ttf -t $out/share/fonts/truetype

    runHook postInstall
  '';
}
