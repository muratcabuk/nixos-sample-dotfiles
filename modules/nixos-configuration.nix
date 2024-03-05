{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../hosts/lenovo-l15/hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

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
    displayManager.sddm = {
                              enable = true;
                              autoNumlock = true;
                          };       
    desktopManager.plasma5.enable = true;

    layout = "tr";
    xkbVariant = "";
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;


  # Configure console keymap
  console.keyMap = "trq";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.muratcabuk = {
    isNormalUser = true;
    description = "murat cabuk";
    extraGroups = [ "networkmanager" "wheel" "docker"];
    packages = with pkgs; [];
    # kullanıcı default shell i zsh olarka ayarlanıyor
    shell = pkgs.zsh;
  };

  # https://nixos.wiki/wiki/Command_Shell
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
    kate
    home-manager
    font-awesome
  ];


  # https://nixos.wiki/wiki/Fonts
  fonts.packages = with pkgs; [
                                  noto-fonts
                                  noto-fonts-cjk
                                  noto-fonts-emoji
                                  font-awesome
                                  powerline-fonts
                                  powerline-symbols
                                  (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
                              ];

    programs = {
      zsh.enable = true;
      };


    networking.firewall.enable = false;

    system.stateVersion = "23.11"; # Did you read the comment?

}
