{
  # Colors
  colorschemes.catppuccin.enable = true;

  globals.mapleader = " ";

  opts = {
    number = true;
    shiftwidth = 2;
    undofile = true;
  };

  plugins = {
    # File picker sidebar
    neo-tree.enable = true;
    web-devicons.enable = true; # neo-tree

    # Auto-save
    auto-save.enable = true;

    # Auto-format on save
    conform-nvim = {
      enable = true;
      settings = {
        format_on_save.timeout_ms = 100;
      };
    };
  };
}
