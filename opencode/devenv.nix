{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

# Opencode devenv module
# Options:
#   enable: Enable the module (default: true)
#   configPath: Path to generated config file (default: ${config.devenv.dotfile}/opencode.json)
#   mcp.context7.enable: Enable context7 MCP integration (default: false)
#   mcp.context7.apiKey: API key override (default: from secrets)
#   extraPackages: Additional packages to install
let
  cfg = config.opencode;
  mcpCfg = cfg.mcp.context7;
  pkgs-unstable = import inputs.nixpkgs-unstable { system = pkgs.stdenv.system; };
in
{
  options.opencode = {
    enable = lib.mkEnableOption "Enable Opencode devenv module.";
    configPath = lib.mkOption {
      type = lib.types.str;
      default = "${config.devenv.dotfile}/opencode.json";
      description = "Path to generated Opencode config file.";
    };
    mcp = {
      context7 = {
        enable = lib.mkEnableOption "Enable context7 MCP integration.";
        apiKey = lib.mkOption {
          type = lib.types.str;
          default = config.secretspec.secrets.CONTEXT7_API_KEY;
          description = "Context7 API key (default: from secrets).";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable ({
    env = {
      OPENCODE_DISABLE_LSP_DOWNLOAD = "true";
      OPENCODE_CONFIG = cfg.configPath;
    };

    packages = with pkgs-unstable; [ opencode ];

    files."${cfg.configPath}".json = {
      "$schema" = "https://opencode.ai/config.json";
    }
    // lib.optionalAttrs mcpCfg.enable {
      mcp = {
        context7 = {
          type = "remote";
          url = "https://mcp.context7.com/mcp";
          headers.CONTEXT7_API_KEY = mcpCfg.apiKey;
        };
      };
    };
  });
}
