local sprite = app.sprite

for i, cel in ipairs(sprite.cels) do
	local image = cel.image:clone()
	
	for it in image:pixels() do
		local pixelValue = it()
		
		local r = app.pixelColor.rgbaR(pixelValue)
		local g = app.pixelColor.rgbaG(pixelValue)
		local b = app.pixelColor.rgbaB(pixelValue)
		local a = app.pixelColor.rgbaA(pixelValue)
		
		if a < 255 then
			it(app.pixelColor.rgba(r, g, b, 255))
			end
		end
	
	cel.image = image
	end