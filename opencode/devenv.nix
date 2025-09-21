{ pkgs, inputs, config, ... }:

let
  pkgs-unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };
  opencode-config = "${config.devenv.dotfile}/opencode.json";
in
{
  env = {
    OPENCODE_DISABLE_LSP_DOWNLOAD = "true";
    OPENCODE_CONFIG = opencode-config;
  };

  packages = with pkgs-unstable; [
    opencode
  ];

  files.${opencode-config}.json = {
    "$schema" = "https://opencode.ai/config.json";
    "mcp" = {
      context7 = {
        type = "remote";
        url = "https://mcp.context7.com/mcp";
        headers.CONTEXT7_API_KEY = config.secretspec.secrets.CONTEXT7_API_KEY;
      };
    };
  };
}
