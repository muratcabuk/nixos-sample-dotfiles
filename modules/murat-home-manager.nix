{ config, pkgs, ... }:

{
  # buradaki kullanıcı nixos-configuration.nix dosyasında tanımlı olan kullanıcı ile aynı olmalı
  home.username = "muratcabuk";
  home.homeDirectory = "/home/muratcabuk";

  # Language ayaraları : https://nix-community.github.io/home-manager/options.xhtml#opt-home.language
  home.language.base = "en_US.UTF-8";

  home.keyboard = {
    layout = "tr";
  };

  # Kurulması gereken pakatler
  home.packages = with pkgs; [
    vim
    
    # zsh
    zsh
    oh-my-zsh
    zsh-powerlevel10k
    zsh-completions
    zsh-syntax-highlighting
    zsh-history-substring-search

    powershell
  ];

  # Uygulamaların Konfigürasyonu
    programs.home-manager.enable = true;
    programs.chromium = { 
                          enable = true;
                          extensions = ["aapbdbdomjkkjkaonfhkkikfgjllcleb"];
                        };

    # Yukarıda kurulan paketlerin ayarlanması
    # zsh ayarlarının yapılması
    programs.zsh = {

                      history.size = 10000;
                      historySubstringSearch.enable = true;
                      enable = true;
                      enableCompletion = true;
                      enableAutosuggestions = true;
                      dotDir = ".config/zsh";
                      plugins = [
                                   # zaten kurulu olan powerlevel10k paketinin ayarlamassını yapıyoruz
                                  {
                                    name = "powerlevel10k";
                                    src = pkgs.zsh-powerlevel10k;
                                    file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
                                  }
                                  
                                  # Elimizdeki konfigurasyon dosyasını sisteme kopyalıyoruz.
                                  # üst dinizdek config klasöründeki .pk10k.zsh dosyasını kopyalıyoruz
                                  {
                                    name = "powerlevel10k-config";
                                    src = ../config;
                                    file = ".p10k.zsh";
                                  }
                                  
                                  # manual olarka paket kuruyoruz
                                  {
                                    name = "zsh-syntax-highlighting";
                                    src = pkgs.fetchFromGitHub {
                                    owner = "zsh-users";
                                    repo = "zsh-syntax-highlighting";
                                    rev = "0.7.1";
                                    sha256 = "03r6hpb5fy4yaakqm3lbf4xcvd408r44jgpv4lnzl9asp4sb9qc0";
                                            };
                                  }

                                ];
                      oh-my-zsh = {
                                    enable = true;
                                    package = pkgs.oh-my-zsh;
                                    plugins = [ "git" "sudo"];
                                    
                                
                                  };
                                     # zsh içine alias tanımlıyoruz
                      shellAliases = {
                                        ll = "ls -l";
                                        nixupdate = "sudo nixos-rebuild switch --flake .#muratpc --impure";
                                      };
                      
                    };

  # Servislerin Konfigürasyonu
  services.kdeconnect = {
      enable = true;
      indicator = true;
    };




  # bu değeri de ilk kuruulumdaki gibi bırakıyoruz. 
  # daha önce flake.nix dosyası için söylediklerimiz burası için de geçerli
  home.stateVersion = "23.11";

}