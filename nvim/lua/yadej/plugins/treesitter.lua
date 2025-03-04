return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  enabled = true,
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "vim",
        "vimdoc",
        "c",
        "cpp",
        "rust",
        "lua",
        "ruby",
        "html",
        "bash",
        "markdown",
        "markdown_inline",
      },
      indent = { enable = true },
      highlight = {
        enable = true,
        use_languagetree = true,
        -- disable = { "markdown" },
      },
    })
  end,
}
