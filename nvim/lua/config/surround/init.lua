local present, surround = pcall(require, "surround")

if present then
	surround.setup({ mappings_style = "sandwich" })
end
