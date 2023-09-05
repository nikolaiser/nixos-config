{
  lib,
  pkgs,
  config,
  ...
}:
with lib; let
  cfg = config.programs.tms;
  package = pkgs.rustPlatform.buildRustPackage rec {
    pname = "tms";
    version = "0.2.3";

    src = pkgs.fetchFromGitHub {
      owner = "jrmoulton";
      repo = "tmux-sessionizer";
      rev = "v${version}";
      hash = "sha256-TTt4pEWlt1cL9SBM6C5dX88MqhBqr4Qt8INnWny8WL4=";
    };

    cargoHash = "sha256-QvjUAD/8dQJfxK/SxpoyO87WSfY3VbS6NfuOjdVakqs=";

    nativeBuildInputs = with pkgs; [
      pkg-config
    ];

    buildInputs = with pkgs; [
      libgit2
      openssl
      zlib
    ];

    meta = with lib; {
      description = "A cli tool for opening git repos as tmux sessions";
      homepage = "https://github.com/jrmoulton/tmux-sessionizer";
      license = licenses.mit;
      maintainers = with maintainers; [];
    };
  };
in {
  options.programs.tms = {
    enable = mkEnableOption "Tmux Sessionizer";
  };

  config = mkIf cfg.enable {
    home.packages = [package];

    xdg.configFile."tms/default-config.toml" = {
      text = "search_paths = ['/home/nikolaiser/Documents']";
    };
  };
}
