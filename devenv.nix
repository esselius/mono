{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:

{
  opencode = {
    enable = true;
    mcp.context7.enable = true;
  };
}
