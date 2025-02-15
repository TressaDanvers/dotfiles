{ config, pkgs, lib, ... }:
with lib.hm.gvariant; let
  home = "/home/tressa";
  d = mkDictionaryEntry;
in {
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

      # Backgrounds
      "org/gnome/desktop/background" = {
        picture-uri = "file://${home}/.local/share/backgrounds/wallpaper-light.jpg";
        picture-uri-dark = "file://${home}/.local/share/backgrounds/wallpaper-dark.jpg";
      };

      # Shell Extensions
      "org/gnome/shell" = {
        disable-user-extensions = false;
        disabled-extensions = [];
        enabled-extensions = [
          "AlphabeticalAppGrid@stuarthayhurst" "dm-theme-changer@lynixx01.github.com"
          "nightthemeswitcher@romainvigier.fr" "rounded-window-corners@fxgn"
          "panel-corners@aunetx" "Rounded_Corners@lennart-k"
        ];
        favorite-apps = [];
      };

      ## AlphabeticalAppGrid
      "org/gnome/shell/extensions/alphabetical-app-grid" = {
        folder-order-position = "start";
        sort-folder-contents = true;
        logging-enabled = false;
      };

      ## DMThemeChanger
      "org/gnome/shell/extensions/dmthemechanger" = {
        first-time-install = false;

        optimize-darklight-switch-transition = true;
        darklight-transition-duration = 1000;
        darklight-toggle-clickdelay = 2000;

        cursor-theme-dark = "Bibata-Modern-Classic";
        cursor-theme-light = "Bibata-Modern-Ice";
        gtk3-theme-dark = "adw-gtk3-dark";
        gtk3-theme-light = "adw-gtk3";
        icon-theme-dark = "MoreWaita";
        icon-theme-light = "MoreWaita";
      };

      ## NightThemeSwitcher
      "org/gnome/shell/extensions/nightthemeswitcher/time" = {
        fullscreen-transition = true;
        manual-schedule = true;
        nighttime-binding = [ "" ];
        sunrise = 6.0;
        sunset = 20.0;
      };
      "org/gnome/shell/extensions/nightthemeswitcher/commands" = {
        enabled = false;
        sunrise = "";
        sunset = "";
      };

      # PanelCorners
      "org/gnome/shell/extensions/panel-corners" = {
        panel-corners = true;
        panel-corner-opacity = 1.0;
        panel-corner-background-color = "rgb(0,0,0)";
        panel-corner-radius = 12;
        screen-corners = true;
        screen-corner-opacity = 1.0;
        screen-corner-background-color = "rgb(0,0,0)";
        screen-corner-radius = 12;
        force-extension-values = true;
        debug = false;
      };

      # RoundedCorners
      "org/gnome/shell/extensions/lennart-k/rounded_corners".corner-radius = 12;

      # RoundedWindowCornersReborn
      "org/gnome/shell/extensions/rounded-window-corners-reborn" = {
        skip-libadwaita-app = false;
        skip-libhandy-app = false;
        border-width = 0;
        border-color = mkTuple [0.0 0.0 0.0 0.0];
        focused-shadow = [
          (d [ "verticalOffset" 4 ])
          (d [ "horizontalOffset" 0 ])
          (d [ "blurOffset" 28 ])
          (d [ "spreadRadius" 4 ])
          (d [ "opacity" 60 ])
        ];
        unfocused-shadow = [
          (d [ "verticalOffset" 2 ])
          (d [ "horizontalOffset" 0 ])
          (d [ "blurOffset" 12 ])
          (d [ "spreadRadius" (-1) ])
          (d [ "opacity" 65 ])
        ];
        global-rounded-corner-settings = [
          (d [ "padding" (mkVariant [
             (d [ "left" (mkUint32 1) ])
             (d [ "right" 1 ])
             (d [ "top" 1 ])
             (d [ "bottom" 1 ])
          ]) ])
          (d [ "keepRoundedCorners" (mkVariant [
            (d [ "maximized" true ])
            (d [ "fullscreen" true ])
          ]) ])
          (d [ "borderRadius" (mkVariant (mkUint32 12)) ])
          (d [ "smoothing" (mkVariant 0.0) ])
          (d [ "enabled" (mkVariant true) ])
        ];
        tweak-kitty-terminal = false;
        enable-preferences-entry = false;
        debug-mode = false;
        blacklist = [];
        custom-rounded-corner-settings = [];
      };
    };
  };
}
