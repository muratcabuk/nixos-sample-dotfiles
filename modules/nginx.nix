{ config, pkgs,lib, ...}:

let

  # writeTextDir fonksiyonu ile nix/store dizinine html/site1/index.html adında 
  # bir klasör açıp içinde index.html adında bir doya oluşturuyoruz.
  # aynen yazdığım gibi yanlışlık yok. index.html adında  bir klasörün altına index.html adında doys olulşturuyor.
  site1Root = pkgs.writeTextDir "html/site1/index.html" ''
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Document</title>
      </head>
      <body>
          Hello from Site 1
      </body>
      </html>'';


  # writeTextDir fonksiyonu ile nix/store dizinine html/site2/index.html adında 
  # bir klasör açıp içinde index.html adında bir doya oluşturuyoruz.
  # aynen yazdığım gibi yanlışlık yok. index.html adında  bir klasörün altına index.html adında doys olulşturuyor.
  site2Root = pkgs.writeTextDir "html/site2/index.html" ''
      <!DOCTYPE html>
      <html lang="en">
      <head>
          <meta charset="UTF-8">
          <meta name="viewport" content="width=device-width, initial-scale=1.0">
          <title>Document</title>
      </head>
      <body>
          Hello from Site 2
      </body>
      </html>'';

in

{   # domain olarak site1 ve site2 yi ekliyoruz hosts dosyamıza
    # https://nixos.wiki/wiki/Networking
    networking.extraHosts = ''
                              127.0.0.1 site1
                              127.0.0.1 site2
                            '';
    # nginx i enable ediyoruz ve statik sayfalarımızın dizinlerini gosteriyoruz.
     services.nginx = {
                    enable = true;
                    
                    recommendedGzipSettings = true;

                    virtualHosts."site1" = {
                                              locations."/" = {root = site1Root + "/html/site1";};
                                           };

                    virtualHosts."site2" = {
                                              locations."/" = {root = site2Root + "/html/site2";};
                                            };
                   };
}