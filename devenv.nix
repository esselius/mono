{ config, ... }:

{
  opencode = {
    enable = true;
    mcp.context7.enable = true;
  };
  neovim.enable = true;

  imports = [
    ./actions/devenv.nix
    ./housekeeping/devenv.nix
    ./neovim/devenv.nix
    ./opencode/devenv.nix
    ./secrets/devenv.nix
  ];

  actions = {
    enable = true;
    workflows.ci = {
      jobs.test.steps = [
        { uses = "actions/checkout@v4"; }
        { uses = "DeterminateSystems/determinate-nix-action@v3"; }
        { uses = "DeterminateSystems/magic-nix-cache-action@v13"; }
        { run = "nix profile add nixpkgs#devenv"; }
        { run = "devenv test"; }
      ];
    };
  };
}
