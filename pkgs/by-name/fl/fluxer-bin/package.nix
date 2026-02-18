{
  stdenv,
  lib,
  fetchurl,
  appimageTools,
}:

let
  pname = "fluxer-bin";
  version = "0.0.8";

  sources = {
    x86_64-linux = fetchurl {
      url = "https://api.fluxer.app/dl/desktop/stable/linux/x64/fluxer-stable-${version}-x86_64.AppImage";
      hash = "sha256-GdoBK+Z/d2quEIY8INM4IQy5tzzIBBM+3CgJXQn0qAw=";
    };
    aarch64-linux = fetchurl {
      url = "https://api.fluxer.app/dl/desktop/stable/linux/arm64/fluxer-stable-${version}-arm64.AppImage";
      hash = "sha256-wxLNekbw3E0YPcC27COWtp8VphKmBB9bF2dp7lnjPf8=";
    };
  };
  src = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
in

appimageTools.wrapType2 {
  inherit pname version src;

  meta = with lib; {
    description = "Fluxer desktop client";
    homepage = "https://fluxer.app";
    license = licenses.agpl3Only;
    platforms = [ "x86_64-linux" "aarch64-linux" ];
    mainProgram = "fluxer-bin";
    maintainers = [ ];
  };
}
