return {
    {
        "j-hui/fidget.nvim",
        tag = "legacy",
        event = "LspAttach",
        opts = {
        },
     },
    {
        "williamboman/mason-lspconfig.nvim",
        opts= {},
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            { "neovim/nvim-lspconfig" },
        },
    },
}
