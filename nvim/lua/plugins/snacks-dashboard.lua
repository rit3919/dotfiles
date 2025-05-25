return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      pane_gap = 4,
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
      preset = {
        -- The 'items' argument are the default keymaps
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        -- Used by 'header' section.
        header = [[
           _ __ (_)  ___   _   _ (_)  ___ ___  
          ( '__)| |/' _ `\( ) ( )| |/' _ ` _ `\
          | |   | || ( ) || \_/ || || ( ) ( ) |
          (_)   (_)(_) (_)`\___/'(_)(_) (_) (_)
                                               
        ]],
    },
        sections = {
            { section = "header" },
            { section = "keys", gap = 1, padding = 1 },
            { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
            { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 2 },
            { section = "startup" },
        },
    },
},
}
