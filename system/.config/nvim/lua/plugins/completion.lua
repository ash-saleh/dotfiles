return {
  "saghen/blink.cmp",
  version = "1.*",  -- stable v1 releases with a prebuilt fuzzy matcher; see note
  -- Deliberately not lazy-loaded: blink tells language servers what it can do when it loads,
  -- so it has to be in place before they start
  opts = {
    keymap = { preset = "default" },

    appearance = {
      nerd_font_variant = "normal",  -- matches "JetBrainsMono Nerd Font"; use "mono" for the Mono variant
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 300 },  -- docs for the highlighted item
      menu = {
        draw = {
          -- icon, name, then the kind spelled out ("Function", "Module") until the icons are second nature
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
        },
      },
    },

    signature = { enabled = true },  -- parameter hints while you type a call's arguments

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },  -- Neovim API and plugin modules in config files
      },
      providers = {
        lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
      },
    },
  },
}
