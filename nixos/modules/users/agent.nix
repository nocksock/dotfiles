{
  pkgs,
  config,
  ...
}: let
  keys = import ../globals/keys.nix;
in {
  users.users.agent = {
    isNormalUser = true;
    home = "/home/agent";
    createHome = true;
    extraGroups = ["agent"];
    openssh.authorizedKeys.keys = [keys.users.agent.publicKey];
    shell = pkgs.zsh;
  };

  age.secrets.anthropicApiKey = {
    file = ./agent.anthropicApiKey.age;
    owner = "agent";
  };

  age.secrets.agentSshKey = {
    file = ./agent.sshKey.age;
    mode = "0600";
    owner = "agent";
    group = "users";
  };

  age.secrets.ghToken = {
    file = ./agent.ghToken.age;
    owner = "agent";
  };

  programs.zsh.enable = true;

  programs.ssh.knownHosts = {
    github = {
      hostNames = ["github.com"];
      publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
    };
  };

  home-manager.users.agent = {pkgs, ...}: {
    home.packages = with pkgs; [
      atuin
      direnv
      ack
      coreutils
      entr
      nushell
      fd
      fzf
      gh
      jq
      neovim
      moreutils
      ripgrep
      starship
      ttyd
      nodejs_23
      nodePackages.claude
      stow
    ];

    home.sessionVariables = {
      GH_TOKEN = "$(cat ${config.age.secrets.ghToken.path})";
      ANTHROPIC_API_KEY = "$(cat ${config.age.secrets.anthropicApiKey.path})";
    };

    programs = {
      atuin = {
        enable = true;
        flags = ["--disable-up-arrow"];
      };

      direnv.enable = true;
      zsh.enable = true;
      zsh.initExtra = ''
        export VISUAL=vim
        export EDITOR="$VISUAL"
      '';

      starship.enable = true;
    };

    home.stateVersion = "24.11";
  };

  system.activationScripts.agentSshKey = ''
    mkdir -p /home/agent/.ssh
    cp ${config.age.secrets.agentSshKey.path} /home/agent/.ssh/id_ed25519
    chmod 600 /home/agent/.ssh/id_ed25519
    chown agent:users /home/agent/.ssh/id_ed25519
  '';
}
