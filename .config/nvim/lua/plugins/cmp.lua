return {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = "InsertEnter",
  dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path"},
  -- Not all LSP servers add brackets when completing a function.
  -- To better deal with this, LazyVim adds a custom option to cmp,
  -- that you can configure. For example:
  --
  -- ```lua
  -- opts = {
  --   auto_brackets = { "python" }
  -- }
  -- ```
  opts = function()
    vim.api.nvim_set_hl(0, "CmpGhostText", {
      link = "Comment",
      default = true
    })
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")()
    local auto_select = true
    return {
      auto_brackets = {}, -- configure any filetype to auto add brackets
      completion = {
        completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect")
      },
      preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
      mapping = {
        ["<M-k>"] = cmp.mapping.select_prev_item(),
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<M-j>"] = cmp.mapping.select_next_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),

        ["<Tab>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        }
      },
      sources = cmp.config.sources({{
        name = "nvim_lsp"
      }, {
        name = "path"
      }}, {{
        name = "buffer"
      }}),
      formatting = {
        format = function(entry, item)
          local widths = {
            abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
            menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30
          }

          for key, width in pairs(widths) do
            if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
                item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
            end
          end

          return item
        end
      },
      experimental = {
        -- only show ghost text when we show ai completions
        ghost_text = vim.g.ai_cmp and {
          hl_group = "CmpGhostText"
        } or false
      },
      sorting = defaults.sorting
    }
  end
}
