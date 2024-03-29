{ config, pkgs, nixpkgs-unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../hosts/lenovo-l15/hardware-configuration.nix
      ./nginx-disabled.nix
    ];




 # specialisation = {
 #        nginx-disabled.configuration = {
 #                      inheritParentConfig = true; 
 #                      system.nixos.tags = [ "nginx-disabled" ];
 #                      services.nginx.enable = false;
 #                          };
 #  };



  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # https://nixos.wiki/wiki/Networking
  networking.hostName = "muratpc"; 

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = ["all"];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "tr_TR.UTF-8";
    LC_IDENTIFICATION = "tr_TR.UTF-8";
    LC_MEASUREMENT = "tr_TR.UTF-8";
    LC_MONETARY = "tr_TR.UTF-8";
    LC_NAME = "tr_TR.UTF-8";
    LC_NUMERIC = "tr_TR.UTF-8";
    LC_PAPER = "tr_TR.UTF-8";
    LC_TELEPHONE = "tr_TR.UTF-8";
    LC_TIME = "tr_TR.UTF-8";
  };

  # Grafik servisini enable ediyoruz
  # klavye ayarı yapılıyor
  services.xserver = {

    enable = true;

    # sddm Oturum Yöneticisini aktif ediyoruz
    displayManager.sddm = {
                              enable = true;
                              autoNumlock = true;
    };
    
    # kde plasma 5 aktif ediliyor     
    desktopManager.plasma5.enable = true;

    layout = "tr";
    xkbVariant = "";


  # Nixos u libvirt için guest olarak çalıştıldığında kullanılır
  # qemuGuest.enable = true;

  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;


  # Configure console keymap
  console.keyMap = "trq";

  # Define a user account. Don't forget to set a password with `passwd`.
  users.users.muratcabuk = {
    isNormalUser = true;
    description = "murat cabuk";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd"];

    # kişise özel paketler. Biz bu kısmı home manager ile yöneteceğiz
    packages = with pkgs; [];

    # kullanıcı default shell i zsh olarka ayarlanıyor
    shell = pkgs.zsh;
  };

  # https://nixos.wiki/wiki/Command_Shell
  # Sistemdeki bütün kullanıcılar için bash varsayılan shell olarak ayaralnıyor
  # tabiiki kendi kullanıcııda da olduğu gibi farklı shell'lere geçiş yapabilir
  users.defaultUserShell = pkgs.bash;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;


  environment.systemPackages = with pkgs; [
    nano
    wget
    curl
    git
    home-manager
    
    # kde plasma 5 paketleri
    kate
    kwin

    # virtualisation
    virt-manager

  ];

  ## https://wiki.archlinux.org/title/XDG_Base_Directory
  # environment.sessionVariables = {
  #   XDG_CACHE_HOME = "$HOME/.cache";
  #   XDG_CONFIG_DIRS = "/etc/xdg";
  #   XDG_CONFIG_HOME = "$HOME/.config";
  #   XDG_DATA_DIRS = "/usr/local/share/:/usr/share/";
  #   XDG_DATA_HOME = "$HOME/.local/share";
  #   XDG_STATE_HOME = "$HOME/.local/state";
  # };


  # https://nixos.wiki/wiki/Fonts
  # ihtiyacımız olabilcek fontlar yükleniyor.
  fonts.packages = with pkgs; [
                                  meslo-lgs-nf
                                  noto-fonts
                                  noto-fonts-cjk
                                  noto-fonts-emoji
                                  font-awesome
                                  powerline-fonts
                                  powerline-symbols
                                  (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
                              ];
    # zsh'ı sadece home-manager'da aktif etmek yetmiyor
    # burada da aktif etmek gerekiyor
    programs = {
      zsh.enable = true;
      
      # kvm-qemu (libvirt) için nixos 23.11 den oncesi için gerekli
      # dconf.enable = true;
      };



    # virtualisation / kvm-qemu
    virtualisation.libvirtd.enable = true;

    # virtualizatiob docker 
    virtualisation.docker = {
                        enable = true;
                        # eğer btrf kullanacaksanız
                        # storageDriver = "btrfs";

                        # Docker data dizinini değiştirmek isterseniz
                        #daemon.settings = {
                        #        data-root = "/some-place/to-store-the-docker-data";
                        #};
                        };

    networking.firewall.enable = false;

    system.stateVersion = "23.11";

}
