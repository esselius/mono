{
  plugins = {
    # Syntax highlighting and tab completion
    lsp = {
      servers = {
        nixd = {
          enable = true;
          settings = {
            nixpkgs.expr = "import <nixpkgs> {}";
          };
        };
        statix.enable = true;
      };
    };

    # Auto-format on save
    conform-nvim = {
      settings = {
        formatters_by_ft.nix = [ "nixfmt" ];
      };
    };
  };
}
