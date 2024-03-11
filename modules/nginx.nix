{ config, pkgs,lib, ...}:

let

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

{
  # https://nixos.wiki/wiki/Networking
    networking.extraHosts = ''
                              127.0.0.1 site1
                              127.0.0.1 site2
                            '';

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