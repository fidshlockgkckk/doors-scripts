--[[
Hello, Fishlock here, and thank you for using my ESP Library. In this short file, you will be given an example of how to use this.
This ESP library is easy to understand, use and get started with. Also, The code is open source, so feel free to take a look at it!
If you have any problems, contact fishlock#2610 or mstudio#9016 on Discord.
--]]

local ESPLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/fishlockscripts/Doors/main/ESP/Source.lua"))()
local Billboard = ESPLib:CreateBillboard(Color3.fromRGB(0, 0, 0), "Billboard Example", workspace.Part)
--[[
    Billboard.Delete()
    Billboard.Deleted (boolean)

    Billboard.ChangeColor(TextColor (Color3))
    Billboard.ChangeText(Text (string)) 
--]]

-- Highlights
local Highlight = ESPLib:HighlightESP({
    Model = workspace.Part, -- Part
    Name = "Highlight ESP", -- Name
    FillColor = Color3.fromRGB(0, 0, 0), -- The inner color of the highlight
    OutlineColor = Color3.fromRGB(255, 255, 255), -- The outline color of the highlight
    TextColor = Color3.fromRGB(255, 255, 255), -- The text color
    FillTransparency = 0, -- The inner highlight transparency
    OutlineTransparency = 0, -- The outline transparency
})
--[[
    Highlight.Delete() 
    Highlight.Deleted (boolean)

    Highlight.ChangeColor(FillColor (Color3), OutlineColor (Color3), FillTransparency (number), OutlineTransparency (number), TextColor (Color3))
    Highlight.ChangeText(Text (string))
--]]

-- Adorments
local Adornment = ESPLib:AdornmentESP({
    Model = workspace.Part, -- Part
    Name = "Adornment ESP", -- Name
    Color = Color3.fromRGB(0, 0, 0), -- The adornment color
    TextColor = Color3.fromRGB(255, 255, 255), -- The text color
    Transparency = .3, --The adornment transparency
    Type = "Box", -- Box, Cylinder, Sphere
})
--[[
    Adornment.Delete() 
    Adornment.Deleted (boolean)

    Adornment.ChangeColor(Color (Color3), TextColor (Color3))
    Adornment.ChangeText(Text (string))
--]]

-- Outlines
local Outline = ESPLib:OutlineESP({
    Model = workspace.Part, -- Part
    Name = "Outline ESP", -- Name
    SurfaceColor = Color3.fromRGB(10, 10, 10), -- The outline's surface (inside) color
    BorderColor = Color3.fromRGB(0, 0, 0), -- The outline's border color
    TextColor = Color3.fromRGB(255, 255, 255), -- The text color
    OutlineThickness = .04, -- The outline's border thickness
    Transparency = .65,  -- The outline transparency
})
--[[
    Outline.Delete() 
    Outline.Deleted (boolean)

    Outline.ChangeColor(SurfaceColor (Color3), BorderColor (Color3), OutlineThickness (number), Transparency (number), TextColor (Color3))
    Outline.ChangeText(Text (string))
--]]

-- Tracers
local Tracer = ESPLib:TracerESP({
    Model = workspace.Part, -- Part
    Color = Color3.fromRGB(0, 0, 0), -- the line color
    Thickness = 2, -- the line thickness
    Transparency = 0.7, -- the line transparency
    From = "Center", -- Center, Bottom, Mouse
})
--[[
    Tracer.Delete() 
    Tracer.Deleted (boolean)

    Tracer.ChangeColor(Color (Color3), Thickness (number), Transparency (number))
--]]
