{ config, pkgs, ... }: let
  home = "/home/tressa";
  cache_home = ".cache";
  config_home = ".config";
  data_home = ".local/share";
  state_home = ".local/state";
  bin_home = ".local/bin";
in {

  home = {
    username = "tressa";
    homeDirectory = "${home}";
    packages = with pkgs; [ tree ];
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
      userEmail = "TDanvers@protonmail.ch";
      userName = "Tressa Danvers";
    };

    home-manager.enable = true;

    # Shell
    bash = {
      enable = true;
      enableCompletion = true;
      historyFile = "${state_home}/bash/history";
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
        ignoreAllDups = true;
        path = "${state_home}/zsh/history";
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
      };
      syntaxHighlighting.enable = true;
    };
  };
}
