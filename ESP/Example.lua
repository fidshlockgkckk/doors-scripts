--[[
Hello, Fishlock here, and thank you for using my ESP Library. In this short file, you will be given an example of how to use this.
This ESP library is easy to understand, use and get started with. Also, The code is open source, so feel free to take a look at it!
If you have any problems, contact fishlock#2610 or mstudio#9016 on Discord.
--]]

local ESPModule = blah blah blah lmao
local ExamplePart = workspace.Part

--Highlight ESP
ESPModule:HighlightESP({
    Model = ExamplePart, --The part we want to use the ESP on
    Name = ExamplePart.Name, --The text the textlabel will display
    FillColor = Color3.fromRGB(255,255,255), --The fill color of the Highlight
    OutlineColor = Color3.fromRGB(155,155,155), --The outline color of the Highlight
    TextColor = Color3.fromRGB(0,0,0), --The text color
    FillTransparency = 0, --The fill transparency
    OutlineTransparency = .25 --And finally, The outline transparency.
})

--Adornment ESP
ESPModule:AdornmentESP({
	Model = ExamplePart,
	Name = ExamplePart.Name,
	Color = Color3.fromRGB(255,255,255),
	TextColor = Color3.fromRGB(0,0,0),
	Transparency = .5,
	Type = "Cylinder" --[[This part is important, as it shapes the adornment and I will display all adornment types usable in this library:
    Box,
    Cylinder,
    Sphere--]]
})

