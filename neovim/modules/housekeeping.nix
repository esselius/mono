{
  # Editorconfig support
  editorconfig.enable = true;

  plugins = {
    # LSP
    lsp.enable = true;

    # Auto-format on save
    conform-nvim = {
      enable = true;
      settings = {
        format_on_save.timeout_ms = 100;
      };
    };
  };
}
