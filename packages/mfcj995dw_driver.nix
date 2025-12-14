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
    url = "https://download.brother.com/welcome/dlf103811/mfcj995dwpdrv-${version}-0.i386.deb"
    hash = "";
  };
  unpackPhase = ''
    ar x $src
    tar xfvz data.tar.gz
  '';
  buildInputs = with pkgs; [
    cups
    perl
    stdenv.cc.libc
    ghostscript
    which
  ];
  dontBuild=true;
  
  patchPhase = ''
    INFDIR=opt/brother/Printers/mfcj995dw/inf
    LPDDIR=opt/brother/Printers/mfcj995dw/lpd

    substituteInPlace $LPDDIR/filter_BrGenML1 \
      --replace "BR_PRT_PATH =~" "BR_PRT_PATH = \"$out/opt/brother/Printers/mfcj995dw\"; #"

    ${myPatchElf "usr/bin/brprintconf_mfcj995dw"}
  '';

  installPhase = ''
    INFDIR=opt/brother/Printers/mfcj995dw/inf
    LPDDIR=opt/brother/Printers/mfcj995dw/lpd

    mkdir -p $out/$INFDIR
    cp -rp $INFDIR/* $out/$INFDIR
    mkdir -p $out/$LPDDIR
    cp -rp $LPDDIR/* $out/LPDDIR

    mkdir -p $out/bin
    cp -r usr/bin/brprintconf_mfcj995dw $out/bin""

    mkdir -p $out/share/cups/model/
    cp ./opt/brother/Printer/brother/mfcj995dw/cupswrapper/brother_mfcj995dw_printer_en.ppd $out/share/cups/model
  '';

  meta = {
    description = "Brother Mfcj995dw drivers";
    homepage = "http://www.brother.com";
  };
}
