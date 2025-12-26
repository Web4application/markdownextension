require("mini.deps").setup()
MiniDeps.add({
        source = "Kurama622/llm.nvim",
        depends = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
        cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
})

require("llm").setup({
        url = "https://models.inference.ai.azure.com/chat/completions",
        model = "gpt-5-mini",
        api_type = "openai"
})
