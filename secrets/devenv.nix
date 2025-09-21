{ pkgs, ... }:

{
  packages = with pkgs; [
    secretspec
    _1password-cli
  ];
}
