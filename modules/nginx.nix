{ config, pkgs}:
let

  indexFile = ../html/index.html;

  site1IndexFile = /var/www/site1/index.html;
  site2IndexFile = /var/www/site2/index.html;

  replacementText = "site-message";

  originalText = lib.readFile indexFile; # Dosyayı oku

  site1Text = lib.substitute originalText {
    search = replacementText;
    replace = "Hello from Site 1";
  }; # Metni değiştir

  site2Text = lib.substitute originalText {
    search = replacementText;
    replace = "Hello from Site 2";
  }; # Metni değiştir


in
{

lib.writeTextFile site1IndexFile site1Text;

lib.writeTextFile site2IndexFile site1Text;


services.nginx = {
    enable = true;
    recommendedGzipSettings = true;

    virtualHosts."example.com" = {
      locations."/" = {
        root = "/var/www/site1"; # Birinci site dosyalarının yolu
      };
    };

    virtualHosts."example.net" = {
      locations."/" = {
        root = "/var/www/site2"; # İkinci site dosyalarının yolu
      };
    };

    extraConfig = ''
      # Diğer özel ayarlamalar buraya eklenir
    '';
  };
}