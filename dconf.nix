{ config, pkgs, lib, ... }:{
  dconf = {
    enable = true;
    settings = {
      # Applications
      "org/gnome/desktop/app-folders/folders/Utilities".excluded-apps = [
        "org.freedesktop.GnomeAbrt.desktop" "nm-connection-editor.desktop" "org.gnome.baobab.desktop" 
        "org.gnome.Connections.desktop" "org.gnome.Console.desktop" "org.gnome.tweaks.desktop" 
        "org.gnome.DejaDup.desktop" "org.gnome.DiskUtility.desktop" "org.gnome.Evince.desktop" 
        "org.gnome.FileRoller.desktop" "org.gnome.font-viewer.desktop" "org.gnome.Loupe.desktop" 
        "org.freedesktop.MalcontentControl.desktop" "org.gnome.seahorse.Application.desktop" 
        "org.gnome.Usage.desktop"
      ];

      "org/gnome/desktop/app-folders".folder-children = [ "System" ];
      "org/gnome/desktop/app-folders/folders/System" = {
        apps = [
          "org.gnome.Console.desktop" "ca.desrt.dconf-editor.desktop" "org.gnome.Extensions.desktop" 
          "org.gnome.Settings.desktop" "org.gnome.tweaks.desktop"
        ];
        name = "System";
        translate = false;
      };

      # Shell Extensions
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [];
        enabled-extensions = [ "AlphabeticalAppGrid@stuarthayhurst" ];
        favorite-apps = [];
      };

      ## AlphabeticalAppGrid
      "org/gnome/shell/extensions/alphabetical-app-grid" = {
        folder-order-position = "start";
        sort-folder-contents = true;
      };
    };
  };
}
