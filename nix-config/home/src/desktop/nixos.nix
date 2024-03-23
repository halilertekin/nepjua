{
  inputs,
  lib,
  config,
  pkgs,
  colors,
  ...
}: {
  imports = [
    ./gnome
    ./browser.nix
  ];

  home.file = {
    ".config/autostart/1password.desktop".source = "${pkgs._1password-gui.outPath}/share/applications/1password.desktop";
    ".config/autostart/copyq.desktop".source = "${pkgs.copyq.outPath}/share/applications/com.github.hluk.copyq.desktop";
    ".config/autostart/guake.desktop".source = "${pkgs.guake.outPath}/share/applications/guake.desktop";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    vlc
    copyq
    parsec-bin
    obs-studio
    bottles
    qbittorrent
    discord
    slack
    obsidian
    zoom-us
    spotify
  ];

  services.spotifyd = {
    enable = true;
  };

  home.sessionVariables = {
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:$HOME/share/flatpak/exports/share";
  };
}
