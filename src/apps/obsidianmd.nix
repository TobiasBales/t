{ stdenv, fetchurl, undmg }:

stdenv.mkDerivation {
  pname = "obsidianmd";
  version = "0.6.5";

  src = fetchurl {
    url = "https://github.com/obsidianmd/obsidian-releases/releases/download/v0.6.5/Obsidian-0.6.5.dmg";
    sha256 = "06s7y5a7myivjjbgcy8vmnzbwfw1ps3s7ma8rmcpvz0yq1ixsl7z";
  };

  buildInputs = [ undmg ];
  installPhase = ''
    mkdir -p "$out/Applications/Obsidian.app"
    cp -R . "$out/Applications/Obsidian.app"
    chmod +x "$out/Applications/Obsidian.app/Contents/MacOS/Obsidian"
  '';

  meta = {
    description = "Obsidian is a powerful knowledge base that works on top of a local folder of plain text Markdown files. ";
    homepage = "https://obsidian.md/";
    license = stdenv.lib.licenses.unfree;
    platforms = stdenv.lib.platforms.darwin;
  };
}

