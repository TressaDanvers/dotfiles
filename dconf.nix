{ config, pkgs, lib, ... }:{
  dconf = {
    enable = true;
    settings = {
      # Applications
      "org/gnome/shell".favorite-apps = [];
      "org/gnome/desktop/app-folders/folders/Utilities".excluded-apps = [
        "org.freedesktop.GnomeAbrt.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" 
        "org.gnome.Connections.desktop" "org.gnome.Console.desktop" "org.gnome.tweaks.desktop" 
        "org.gnome.DejaDup.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Evince.desktop" 
        "org.gnome.FileRoller.desktop" "org.gnome.font-viewer.desktop" "org.gnome.Loupe.desktop" 
        "org.freedesktop.MalcontentControl.desktop" "org.gnome.seahorse.Application.desktop" 
        "org.gnome.Usage.desktop"
      ];

      # Shell Extensions
      "org/gnome/shell".disable-user-extensions = false;
      "org/gnome/shell".disabled-extensions = [];
      "org/gnome/shell".enabled-extensions = [ "AlphabeticalAppGrid@stuarthayhurst" ];

      ## AlphabeticalAppGrid
      "org/gnome/shell/extensions/alphabetical-app-grid" = {
        folder-order-position = "start";
        sort-folder-contents = true;
      };
    };
  };
}
