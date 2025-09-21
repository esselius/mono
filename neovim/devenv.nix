{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  cfg = config.neovim;
  nixvimPkgs = cfg.nixvimInput.legacyPackages.${pkgs.stdenv.system};
  nixvimModule = import cfg.modulePath;
  nixvimPackage = nixvimPkgs.makeNixvimWithModule {
    module = nixvimModule;
  };
in
{
  options.neovim = {
    enable = lib.mkEnableOption "Enable Neovim devenv module.";
    modulePath = lib.mkOption {
      type = lib.types.path;
      default = ./nixvim-module.nix;
      description = "Path to the Nixvim module configuration.";
    };
    nixvimInput = lib.mkOption {
      type = lib.types.anything;
      default = inputs.nixvim;
      description = "Override the nixvim input (default: inputs.nixvim).";
    };
  };

  config = lib.mkIf cfg.enable {
    packages = [ nixvimPackage ];
  };
}
