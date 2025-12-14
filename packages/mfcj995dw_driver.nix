# TODO: this is broken. should follow like https://github.com/NixOS/nixpkgs/blob/nixos-25.11/pkgs/by-name/mf/mfcj880dwlpr/package.nix#L121 instead
{ pkgs, lib, ... }:
let
  myPatchElf = file: ''
    patchelf --set-interpreter \
      ${pkgs.stdenv.cc.libc}/lib/ld-linux${lib.optionalString pkgs.stdenv.hostPlatform.is64bit "-x86-64"}.so.2 \
      ${file}
  '';
in
pkgs.stdenv.mkDerivation rec {
  pname = "mfcj995dw";
  version = "1.0.5-0";
  src = pkgs.fetchurl {
    url = "https://download.brother.com/welcome/dlf103811/mfcj995dwpdrv-1.0.5-0.i386.deb";
    hash = "sha256-QT/UZYMiIkdRQn0uWsHJytdQtNnEqWqICTby0FSNE74=";
  };
  unpackPhase = ''
    ar x $src
    tar xfvz data.tar.gz
  '';
  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];
  buildInputs = with pkgs; [
    zlib
    cups
    perl
    coreutils
    gnused
    gnugrep
    stdenv.cc.libc
    ghostscript
    which
  ];
  dontBuild=true;
  
  patchPhase = ''
    INFDIR=opt/brother/Printers/mfcj995dw/inf
    LPDDIR=opt/brother/Printers/mfcj995dw/lpd
    CUPSDIR=opt/brother/Printers/mfcj995dw/cupswrapper
    WRAPPER=$CUPSDIR/brother_lpdwrapper_mfcj995dw

    substituteInPlace $WRAPPER \
      --replace "basedir =~" "basedir = \"$out/opt/brother/Printers/mfcj995dw\"; #" \
      --replace "PRINTER =~" "PRINTER = \"mfcj995dw\"; #" \

    # substituteInPlace $LPDDIR/brmfcj995dwfilter \
    #   --replace "/opt/brother/Printers/" "BR_PRT_PATH = \"$out/opt/brother/Printers/"; #"

    ${myPatchElf "usr/bin/brprintconf_mfcj995dw"}
    ${myPatchElf "$LPDDIR/brmfcj995dwfilter"}
  '';

  installPhase = ''
    INFDIR=opt/brother/Printers/mfcj995dw/inf
    LPDDIR=opt/brother/Printers/mfcj995dw/lpd
    CUPSDIR=opt/brother/Printers/mfcj995dw/cupswrapper
    CUPSFILTER_DIR=$out/lib/cups/filter
    CUPSPPD_DIR=$out/share/cups/model

    mkdir -p $out/$INFDIR
    cp -rp $INFDIR/* $out/$INFDIR
    mkdir -p $out/$LPDDIR
    cp -rp $LPDDIR/* $out/$LPDDIR
    mkdir -p $out/$CUPSDIR
    cp -rp $CUPSDIR/* $out/$CUPSDIR
    mkdir -p $CUPSFILTER_DIR

    makeWrapper \
      $out/$CUPSDIR/brother_lpdwrapper_mfcj995dw \
      $CUPSFILTER_DIR/brother_lpdwrapper_mfcj995dw \
      --prefix PATH : ${pkgs.coreutils}/bin \
      --prefix PATH : ${pkgs.gnused}/bin \
      --prefix PATH : ${pkgs.gnugrep}/bin \

    mkdir -p $out/bin
    cp -r usr/bin/brprintconf_mfcj995dw $out/bin""

    mkdir -p $out/share/cups/model/
    cp ./opt/brother/Printers/mfcj995dw/cupswrapper/brother_mfcj995dw_printer_en.ppd $out/share/cups/model
  '';

  meta = {
    description = "Brother Mfcj995dw drivers";
    homepage = "http://www.brother.com";
  };
}
