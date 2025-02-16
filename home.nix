{ config, pkgs, ... }: let
  home = "/home/tressa";
  cache_home = ".cache";
  config_home = ".config";
  data_home = ".local/share";
  state_home = ".local/state";
  bin_home = ".local/bin";
in {
  imports = [ ./dconf.nix ];

  home = {
    username = "tressa";
    homeDirectory = "${home}";

    packages = with pkgs; [
      # CLI Utilities
      dconf2nix
      tree
      wget
      # GUI Applications
      epiphany
      floorp
      # GUI Utilities
      dconf-editor
      gnome-console
      gnome-tweaks
      # Theme
      adw-gtk3
      bibata-cursors
      morewaita-icon-theme
    ] ++ (with gnomeExtensions; [
      # Shell Extensions
      alphabetical-app-grid
      blur-my-shell
      dm-theme-changer
      just-perfection
      night-theme-switcher
      panel-corners
      rounded-corners
      rounded-window-corners-reborn
    ]);

    file = {};
    sessionVariables = {
      EDITOR = "nano";
      XDG_CACHE_HOME = "${home}/${cache_home}";
      XDG_CONFIG_HOME = "${home}/${config_home}";
      XDG_DATA_HOME = "${home}/${data_home}";
      XDG_STATE_HOME = "${home}/${state_home}";
    };
    sessionPath = [ "${home}/${bin_home}" ];
    stateVersion = "24.11";
  };

  programs = {
    fastfetch = {
      enable = true;
      settings = {
        modules = [
          "title" "separator"
          "break" "os" "host" "kernel" "uptime" "packages" "shell"
          "break" "cpu" "gpu" "memory" "swap" "disk" "localip" "locale"
          "break" "colors"
        ];
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
      settings.editor = "nano";
    };

    git = {
      enable = true;

      aliases = {
      };

      userEmail = "TDanvers@protonmail.ch";
      userName = "Tressa Danvers";
    };

    home-manager.enable = true;

    # Shell
    bash = {
      enable = true;
      enableCompletion = true;
      historyFile = "${home}/${state_home}/bash/history";
      initExtra = ''
        esc=$(printf "\e")
        Fgreen="$esc[32m"
        Fyellow="$esc[33m"
        Fblue="$esc[34m"
        f="$esc[39m"
        B="$esc[01m"
        b="$esc[22m"
        PS1=$B'[ '$Fgreen'\u'$f'@'$Fyellow'\h'$f' ]-[ '$Fblue'\w'$f' ]'$b'\n\$ '
        unset esc Fred Fyellow Fblue f B b
      '';
      shellAliases = {
        "ff" = ''clear; fastfetch'';
      };
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      dotDir = "${config_home}/zsh";
      enableCompletion = true;
      history = {
        extended = true;
        ignoreAllDups = true;
        ignoreSpace = false;
        path = "${home}/${state_home}/zsh/history";
        share = true;
        size = 10000;
      };
      initExtra = ''
        newl=$'\n'
        PS1='%B[ %F{green}%n%f@%F{yellow}%m%f ]-[ %F{blue}%1~%f ]%b'$newl'%# '
        unset newl;
      '';
      shellAliases = {
        "ff" = ''clear; fastfetch'';
        "git-stage"=''git add *; git commit -m "staged"'';
        "git-restage"=''git reset --soft HEAD~; git add *; git commit -m "staged"'';
        "git-deploy-staged"=''git reset --soft HEAD~; git add *; git commit -m'';
        "switch-nix-home"=''home-manager switch --flake ~/.config/home-manager#tressa'';
      };
      syntaxHighlighting.enable = true;
    };
  };

  targets.genericLinux.enable = true;
}
