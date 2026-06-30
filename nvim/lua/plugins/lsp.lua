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
            { "hrsh7th/cmp-nvim-lsp" },
        },
        config = function (_, opts)
            require("mason-lspconfig").setup(opts)
            vim.lsp.config("*", {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
            })
            local servers = { 
                lua_ls = "lua-language-server",
                nil_ls = "nil",
                bashls = "bash-language-server",
            }
            for name, bin in pairs(servers) do
                if vim.fn.executable(bin) == 1 then
                vim.lsp.enable(name)
                end
            end
        end
    },
}
