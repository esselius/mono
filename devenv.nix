{
  opencode = {
    enable = true;
    mcp.context7.enable = true;
  };
  neovim.enable = true;

  imports = [
    ./housekeeping/devenv.nix
    ./neovim/devenv.nix
    ./opencode/devenv.nix
    ./secrets/devenv.nix
    ./microvm/devenv.nix
  ];
}
