local present, pairs = pcall(require, "nvim-autopairs")

if present then
	pairs.setup({})
end
