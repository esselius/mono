{ pkgs, ... }:
{
  extraPlugins = [
    pkgs.vimPlugins.opencode-nvim
  ];

  plugins.snacks.enable = true;

  keymaps = [
    {
      key = "<leader>ot";
      action = "<cmd>lua require('opencode').toggle()<CR>";
    }
    {
      key = "<leader>oa";
      action = "<cmd>lua require('opencode').ask()<CR>";
      mode = "n";
    }
    {
      key = "<leader>oa";
      action = "<cmd>lua require('opencode').ask('@selection: ')<CR>";
      mode = "v";
    }
    {
      key = "<leader>oe";
      action = "<cmd>lua require('opencode').select_prompt()<CR>";
      mode = [
        "n"
        "v"
      ];
    }
    {
      key = "<leader>on";
      action = "<cmd>lua require('opencode').command('session_new')<CR>";
    }
  ];
}
