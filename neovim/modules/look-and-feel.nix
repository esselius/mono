{
  colorschemes.catppuccin.enable = true;

  globals.mapleader = " ";

  opts = {
    number = true;
    shiftwidth = 2;
    undofile = true;
  };

  plugins.auto-save.enable = true;

  # Auto-format on save
  plugins.conform-nvim = {
    enable = true;
    settings = {
      format_on_save.timeout_ms = 100;
    };
  };
}
