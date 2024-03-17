{ config, pkgs,lib, ...}: 
 {
    specialisation = {
           nginx-disabled = {
                inheritParentConfig = true; 
                configuration = {
                         
                         system.nixos.tags = [ "nginx-disabled" ];
                         services.nginx.enable = lib.mkForce false;
                                 };
                            };
                      };
 }
