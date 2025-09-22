{
  plugins = {
    # Syntax highlighting and tab completion
    lsp = {
      enable = true;
      servers.nixd.enable = true;
    };

    # Auto-format on save
    conform-nvim = {
      settings = {
        formatters_by_ft.nix = [ "nixfmt" ];
      };
    };
  };
}
