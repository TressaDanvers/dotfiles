{ config, pkgs, lib, ... }:{
  dconf = {
    enable = true;
    settings = {
      # Applications
      "org/gnome/shell".favorite-apps = [];
      "org/gnome/desktop/app-folders".folder-children = [];
    };
  };
}
