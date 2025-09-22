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

    # status line
    airline.enable = true;
    # buffer tabs
    bufferline.enable = true;
    # syntax highlighting
    treesitter.enable = true;

    # show line author/commit
    gitblame.enable = true;
    # indicate changed lines
    gitgutter.enable = true;
  };
}
