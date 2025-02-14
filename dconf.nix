{ config, pkgs, lib, ... }:{
  dconf = {
    enable = true;
    settings = {
      # Applications
      "org/gnome/shell".favorite-apps = [];
      "org/gnome/desktop/app-folders".folder-children = [];

      # Shell Extensions
      "org/gnome/shell".disable-user-extensions = false;
      "org/gnome/shell".disabled-extensions = [];
      "org/gnome/shell".enabled-extensions = [ "AlphabeticalAppGrid@stuarthayhurst" ];
    };
  };
}
