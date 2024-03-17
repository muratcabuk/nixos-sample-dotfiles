{ config, pkgs,...}:
        specialisation = {
                nginx-disabled.configuration = {
                              inheritParentConfig = true; 
                              system.nixos.tags = [ "nginx-disabled" ];
                              services.nginx.enable = false;
                                  };
          }         