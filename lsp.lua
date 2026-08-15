
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)

	local lsp_formatting_group = vim.api.nvim_create_augroup("LspFormatting", {})
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({
			group = lsp_formatting_group,
			buffer = bufnr,
		})
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = lsp_formatting_group,
			buffer = bufnr,
			callback = function()
      vim.lsp.buf.format()
		end,
	})
	end
end

vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = true,
})

cap = require("cmp_nvim_lsp").default_capabilities()

-- golang
vim.lsp.config("gopls", {
	on_attach = on_attach,
  flags = {
		debounce_text_changes = 150,
  },
	capabilities = cap,
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
				unusedwrite = true,
				nilness = true,
			}
		}
	}
})
vim.lsp.enable("gopls")

-- Node.js / TypeScript LSP setup

vim.lsp.config("ts_ls", {
	name = "tsserver",
  cmd = { "typescript-language-server", "--stdio" },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  capabilities = default_capabilities,
})

vim.lsp.enable("ts_ls")

-- Haskell setup
vim.lsp.config('hls', {
	cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { 'haskell', 'lhaskell', 'cabal', 'hs' },
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
	capabilities = cap,
	settings = {
		haskell = {
			plugin = {
				class = {
					codeLensOn = false,
				},
        importLens = {
          codeLensOn = false,
        },
        refineImports = { 
          codeLensOn = false,
        },
        tactics = { 
          codeLensOn = false,
        },
        moduleName = { 
          globalOn = false,
        },
        eval = { 
          globalOn = false,
        },
        ['ghcide-type-lenses'] = { 
          globalOn = false,
        },
      },
		},
	} })
vim.lsp.enable("hls")

vim.lsp.config('rust_analyzer', {
    on_attach = on_attach,
    capabilities = cap,
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
		
    single_file_support = true,

})
vim.g.rust_recommended_style = 0

vim.lsp.enable("rust_analyzer")


