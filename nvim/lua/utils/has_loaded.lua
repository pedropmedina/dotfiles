local has_loaded = function(plugin_name)
	if not packer_plugins then
		return false
	end
	if not packer_plugins[plugin_name] then
		return false
	end
	if not packer_plugins[plugin_name].loaded then
		return false
	end
	return true
end

return has_loaded
