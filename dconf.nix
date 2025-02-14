{ config, pkgs, lib, ... }:{
  dconf = {
    enable = true;
    settings = {
      # Desktop
      "org/gnome/desktop/app-folders".folder-children = [];
    };
  };
}
