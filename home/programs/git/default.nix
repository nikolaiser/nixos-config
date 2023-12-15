{ pkgs, ... }:
let
  gitConfig = {
    core = {
      editor = "nvim";
      pager = "diff-so-fancy | less --tabs=4 -RFX";
    };
    init.defaultBranch = "main";
    push.autoSetupRemote = true;
  };

  rg = "${pkgs.ripgrep}/bin/rg";
in
{
  home.packages = with pkgs.gitAndTools; [
    diff-so-fancy # git diff with colors
    hub # github command-line client
    tig # diff and commit view
  ];

  programs.git =
    {
      enable = true;
      aliases = {
        amend = "commit --amend -m";
        br = "branch";
        co = "checkout";
        st = "status";
        ls = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate";
        ll = "log --pretty=format:\"%C(yellow)%h%Cred%d\\\\ %Creset%s%Cblue\\\\ [%cn]\" --decorate --numstat";
        cm = "commit -m";
        ca = "commit -am";
        dc = "diff --cached";
      };
      extraConfig = gitConfig;
      ignores = [
        "*.bloop"
        "*.bsp"
        "*.metals"
        "*.metals.sbt"
        "*metals.sbt"
        "*.direnv"
        #"*.envrc" # there is lorri, nix-direnv & simple direnv; let people decide
        "*hie.yaml" # ghcide files
        "*.mill-version" # used by metals
        "*.jvmopts" # should be local to every project
      ];
      userEmail = "nickolayser@gmail.com";
      userName = "nikolaiser";
    }
    // (pkgs.sxm.git or { });

  programs.scmpuff = {
    enable = true;
    enableFishIntegration = true;
    enableAliases = true;
  };
}
