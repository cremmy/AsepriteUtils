--
-- Global state
--
nameFormat = "%p %c"
counter = 0

--
-- Initialization
--
function init(plugin)
	print("Init")

	-- we can use "plugin.preferences" as a table with fields for
	-- our plugin (these fields are saved between sessions)
	if plugin.preferences.format == nil then
		plugin.preferences.format = "%p %c"
		end
	nameFormat = plugin.preferences.format

	plugin:newCommand{
		id = "Batch rename",
		title = "Batch rename",
		group = "layer_popup_properties",
		onclick = function()
			layerBatchRename(app.range.layers)
			end
		}
	end

function exit(plugin)
	print("Exit")
	end

--
-- Main plugin code
--
counter = 0

function layerBatchRename(layers)
	-- Clear state
	counter = 0
	
	-- status = "Format: " .. nameFormat .. "\n"
	-- status = status .. "Names: "

	-- Collect and rename layers
	local layers = collectSublayers(layers)	
	for _, layer in ipairs(layers) do
		-- status = status .. " - " .. layer.name .. " => "
		layerRename(layer, nameFormat)
		-- status = status .. layer.name .. "\n"
		end
		
	-- app.alert(status)
	end

function layerRename(layer, nameFormat)
	-- Replace %c with counter value
	local newName = nameFormat
	newName, matches = string.gsub(newName, "%%c", counter)
	if matches > 0 then
		counter = counter + 1
		end
	
	-- Replace %p with parent layer name
	local parentName = ""
	if layer.parent ~= nil then
		parentName = layer.parent.name
		end
	newName, matches = string.gsub(newName, "%%p", parentName)
	
	layer.name = newName
	end

--
-- Helpers
--
table.merge = function(a, b)
	if a == nil or b == nil then
		return
		end

	for _, v in ipairs(b) do
		table.insert(a, v)
		end
	end

function collectSublayers(layers)
	local ret = {}

	for _, layer in ipairs(layers) do
		if not layer.isGroup then
			table.insert(ret, layer)
		else
			table.merge(ret, collectSublayers(layer.layers))
			end
		end
					
	return ret
	end