--[[ ___
_____ ___  ________  ___  ___  ___       ________  ________  ___  __    _______   ________  ________   
|\  _____\\  \|\   ____\|\  \|\  \|\  \     |\   __  \|\   ____\|\  \|\  \ |\  ___ \ |\   ____\|\   __  \  
\ \  \__/\ \  \ \  \___|\ \  \\\  \ \  \    \ \  \|\  \ \  \___|\ \  \/  /|\ \   __/|\ \  \___|\ \  \|\  \ 
 \ \   __\\ \  \ \_____  \ \   __  \ \  \    \ \  \\\  \ \  \    \ \   ___  \ \  \_|/_\ \_____  \ \   ____\
  \ \  \_| \ \  \|____|\  \ \  \ \  \ \  \____\ \  \\\  \ \  \____\ \  \\ \  \ \  \_|\ \|____|\  \ \  \___|
   \ \__\   \ \__\____\_\  \ \__\ \__\ \_______\ \_______\ \_______\ \__\\ \__\ \_______\____\_\  \ \__\   
    \|__|    \|__|\_________\|__|\|__|\|_______|\|_______|\|_______|\|__| \|__|\|_______|\_________\|__|   
                 \|_________|                                                           \|_________|    
                                    ESP Library by fishlock#2610 and mstudio45#9016
                                    
--]]

local CoreGUI = game:GetService("CoreGui");local CoreGui = CoreGUI
local ESPFolder_Name = "F_ESP_FOLDER"
local ESPMain_Name = "F_MAIN_FOLDER"
local ESPBillboards_Name = "F_BILLBOARDS_FOLDER"
local ESPAdornments_Name = "F_ADORNMENTS_FOLDER"
local ESPFolder = CoreGui:FindFirstChild(ESPFolder_Name)
if ESPFolder == nil then
    ESPFolder = Instance.new("Folder", CoreGui)
    ESPFolder.Name = ESPFolder_Name
end
local ESPMain = ESPFolder:FindFirstChild(ESPMain_Name)
if ESPMain == nil then
    ESPMain = Instance.new("Folder", ESPFolder)
    ESPMain.Name = ESPMain_Name
end
local ESPBillboards = ESPFolder:FindFirstChild(ESPBillboards_Name)
if ESPBillboards == nil then
    ESPBillboards = Instance.new("Folder", ESPFolder)
    ESPBillboards.Name = ESPBillboards_Name
end
local ESPAdornments = ESPFolder:FindFirstChild(ESPAdornments_Name)
if ESPAdornments == nil then
    ESPAdornments = Instance.new("Folder", ESPFolder)
    ESPAdornments.Name = ESPAdornments_Name
end

--// Variables \\--
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = Workspace.CurrentCamera
local WorldToViewportPoint = Camera.WorldToViewportPoint
local WorldToViewport = function(...) return WorldToViewportPoint(Camera, ...) end

--// Do not touch anything under this unless you know what you are doing. \\--
local Lib = {}
local ESP = {}

--// Functions \\--
function Lib:Validate(def, opt)
	opt = opt or {}
	for i, v in pairs(def) do
		if opt[i] == nil then
			opt[i] = v
		end
	end
	return opt
end

function Lib:ClearESP()
	for _, v in pairs(ESP) do
		if v then
			v.Delete()
		end
	end
end

function Lib:CreateBillboard(TextColor, Name, Model)
    local BillboardTable = {}
    local BillboardGui = Instance.new("BillboardGui", ESPBillboards)
    local Text = Instance.new("TextLabel", BillboardGui)

    BillboardGui.Size = UDim2.new(7,0,.85,0)
	BillboardGui.Enabled = true
	BillboardGui.AlwaysOnTop = true
	BillboardGui.Adornee = Model

	Text.AnchorPoint = Vector2.new(0.5, 0.5)
	Text.Size = UDim2.new(1, 0, 0, 20)
	Text.Position = UDim2.new(0.5, 0, 0.6, 0)
	Text.BackgroundTransparency = 1
	Text.TextColor3 = TextColor
	Text.Text = Name
	Instance.new("UIStroke", Text)
	
    BillboardTable.Deleted = false
    BillboardTable.Delete = function()
	if BillboardTable.Deleted == true then return end
		
        BillboardGui.Adornee = nil
		BillboardGui:Destroy()

        BillboardTable.Deleted = true
    end

    BillboardTable.ChangeColor = function(TextColor)
        if BillboardTable.Deleted == true then return end

        if typeof(TextColor) == "Color3" then Text.TextColor3 = TextColor end
    end

    BillboardTable.ChangeText = function(Text_)
       	--if BillboardTable.Deleted == true then return end
       	-- if typeof(Text_) == "string" then 
		Text.Text = Text_ 
		--end
    end
	
	table.insert(ESP, BillboardTable)
    return BillboardTable
end

function Lib:HighlightESP(options)
	options = Lib:Validate({
		Model = nil,
		Name = nil,
		FillColor = nil,
		OutlineColor = nil,
		TextColor = nil,
		FillTransparency = nil,
		OutlineTransparency = nil,
	}, options or {})
	
    local HighlightTable = {}
	local Highlight = Instance.new("Highlight", ESPMain)
	local BillboardGui = Lib:CreateBillboard(options["TextColor"], options["Name"], options["Model"])
	
	Highlight.FillColor = options["FillColor"]
	Highlight.OutlineColor = options["OutlineColor"]
	Highlight.FillTransparency = options["FillTransparency"]
	Highlight.OutlineTransparency = options["OutlineTransparency"]
	
	Highlight.Adornee = options["Model"]
	BillboardGui.Adornee = options["Model"]
	
    HighlightTable.Deleted = false
    HighlightTable.Delete = function()
        Highlight.Adornee = nil
        Highlight:Destroy()

        BillboardGui.Delete()

        table.remove(ESP, table.find(ESP, HighlightTable))
        HighlightTable.Deleted = true
    end

    HighlightTable.ChangeColor = function(FillColor, OutlineColor, FillTransparency, OutlineTransparency, TextColor)
        if HighlightTable.Deleted == true then return end

        if typeof(FillColor) == "Color3" then Highlight.FillColor = FillColor end
        if typeof(OutlineColor) == "Color3" then Highlight.OutlineColor = OutlineColor end
        if typeof(FillTransparency) == "number" then Highlight.FillTransparency = FillTransparency end
        if typeof(OutlineTransparency) == "number" then Highlight.OutlineTransparency = OutlineTransparency end
        if typeof(TextColor) == "Color3" then BillboardGui.ChangeColor(TextColor) end
    end

    HighlightTable.ChangeText = function(Text_)
        if HighlightTable.Deleted == true then return end

        if typeof(Text_) == "string" then BillboardGui.ChangeText(Text_) end
    end

    table.insert(ESP, HighlightTable)
    return HighlightTable
end

function Lib:AdornmentESP(options)
	options = Lib:Validate({
		Model = nil,
		Name = nil,
		Color = nil,
		TextColor = nil,
		Transparency = nil,
		Type = "Box",
	}, options or {})

    local AdornmentTable = {}
	local Adornment
	local BillboardGui = Lib:CreateBillboard(options["TextColor"], options["Name"], options["Model"])
	
	if options["Type"] == "Box" then
		Adornment = Instance.new("BoxHandleAdornment", ESPAdornments)
		Adornment.Size = options["Model"].Size
	elseif options["Type"] == "Cylinder" then
		Adornment = Instance.new("CylinderHandleAdornment", ESPAdornments)
		Adornment.Height = options["Model"].Size.Y * 2
		Adornment.Radius = options["Model"].Size.X * 1.085
		Adornment.CFrame = CFrame.new() * CFrame.Angles(math.rad(90), 0, 0)
	elseif options["Type"] == "Sphere" then
		Adornment = Instance.new("SphereHandleAdornment", ESPAdornments)
		Adornment.Radius = options["Model"].Size.X * 1.085
		Adornment.CFrame = CFrame.new() * CFrame.Angles(math.rad(90), 0, 0)
    end
	
	Adornment.Color3 = options["Color"]
	Adornment.Transparency = options["Transparency"]
	Adornment.AlwaysOnTop = true
	Adornment.ZIndex = 10
	
	Adornment.Adornee = options["Model"]
	BillboardGui.Adornee = options["Model"]

    AdornmentTable.Deleted = false;
    AdornmentTable.Delete = function()
        Adornment.Adornee = nil
        Adornment:Destroy()

        BillboardGui.Delete()

        table.remove(ESP, table.find(ESP, AdornmentTable))
        AdornmentTable.Deleted = true
    end

    AdornmentTable.ChangeColor = function(Color, TextColor)
        if AdornmentTable.Deleted == true then return end

        if typeof(Color) == "Color3" then Adornment.Color3 = Color end
        if typeof(TextColor) == "Color3" then BillboardGui.ChangeColor(TextColor) end
    end

    AdornmentTable.ChangeText = function(Text_)
        if AdornmentTable.Deleted == true then return end

        if typeof(Text_) == "string" then BillboardGui.ChangeText(Text_) end
    end

    table.insert(ESP, AdornmentTable)
    return AdornmentTable
end

function Lib:OutlineESP(options)
	options = Lib:Validate({
		Model = nil, 
		Name = nil,
        SurfaceColor = nil,
		BorderColor = nil,
		TextColor = nil,
        OutlineThickness = .04,
		Transparency = .65,
	}, options or {})

    local OutlineTable = {}
	local Outline = Instance.new("SelectionBox", ESPAdornments)
	local BillboardGui = Lib:CreateBillboard(options["TextColor"], options["Name"], options["Model"])
	
    Outline.SurfaceColor3 = options["SurfaceColor"]
	Outline.Color3 = options["BorderColor"]
    Outline.LineThickness = options["OutlineThickness"]
    Outline.SurfaceTransparency = options["Transparency"]
	
	Outline.Adornee = options["Model"]
	BillboardGui.Adornee = options["Model"]

    OutlineTable.Deleted = false;
    OutlineTable.Delete = function()
        Outline.Adornee = nil
        Outline:Destroy()

        BillboardGui.Delete()

        table.remove(ESP, table.find(ESP, OutlineTable))
        OutlineTable.Deleted = true
    end

    OutlineTable.ChangeColor = function(SurfaceColor, BorderColor, OutlineThickness, Transparency, TextColor)
        if OutlineTable.Deleted == true then return end

        if typeof(SurfaceColor) == "Color3" then Outline.SurfaceColor3 = SurfaceColor end
        if typeof(BorderColor) == "Color3" then Outline.Color3 = BorderColor end
        if typeof(OutlineThickness) == "number" then Outline.LineThickness = OutlineThickness end
        if typeof(Transparency) == "number" then Outline.SurfaceTransparency = Transparency end
        if typeof(TextColor) == "Color3" then BillboardGui.ChangeColor(TextColor) end
    end

    OutlineTable.ChangeText = function(Text_)
        if OutlineTable.Deleted == true then return end

        if typeof(Text_) == "string" then BillboardGui.ChangeText(Text_) end
    end

    table.insert(ESP, OutlineTable)
    return OutlineTable
end

function Lib:TracerESP(options)
	options = Lib:Validate({
		Model = nil,
		Color = nil,
		Thickness = nil,
        Transparency = nil,
        From = "Center",
	}, options or {})
    
    local TracerTable = { Handler = nil, Vis = false }
    if Drawing then
        local Tracer = Drawing.new("Line")

        Tracer.Visible = false
        Tracer.Color = options["Color"]
        Tracer.Thickness = options["Thickness"]
        Tracer.Transparency = options["Transparency"]

        TracerTable.Handler = RunService.RenderStepped:Connect(function()
            if options["Model"] ~= nil and TracerTable.Vis == true then
                local ScreenPosition, Visible = WorldToViewport(options["Model"].Position);
                local OPos = Camera.CFrame:pointToObjectSpace(options["Model"].Position);
                if ScreenPosition.Z < 0 then
                    local AT = math.atan2(OPos.Y, OPos.X) + math.pi;
                    OPos = CFrame.Angles(0, 0, AT):vectorToWorldSpace((CFrame.Angles(0, math.rad(89.9), 0):vectorToWorldSpace(Vector3.new(0, 0, -1))));
                end
                local Position = WorldToViewport(Camera.CFrame:pointToWorldSpace(OPos));

                if Visible then
                    local TracerPosition = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)

                    if options["From"] == "Mouse" then
                        TracerPosition = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                    elseif options["From"] == "Center" then
                        TracerPosition = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                    elseif options["From"] == "Bottom" then
                        TracerPosition = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    end

                    Tracer.Visible = true
                    Tracer.From = TracerPosition
                    Tracer.To = Vector2.new(Position.X, Position.Y)
                else
                    Tracer.Visible = false
                end
            else
                Tracer.Visible = false
            end
        end)

        TracerTable.Deleted = false;
        TracerTable.Delete = function()
            if TracerTable.Handler then
                TracerTable.Handler:Disconnect()
            end

            pcall(function() Tracer.Visible = false end)
            Tracer:Remove()

            table.remove(ESP, table.find(ESP, TracerTable))
            TracerTable.Deleted = true
        end

        TracerTable.ChangeColor = function(Color, Thickness, Transparency)
            if TracerTable.Deleted == true then return end

            if Tracer then
                if typeof(Color) == "Color3" then Tracer.Color = Color end
                if typeof(Thickness) == "number" then Tracer.Thickness = Thickness end 
                if typeof(Transparency) == "number" then Tracer.Transparency = Transparency end
            end
        end
        
        TracerTable.SetVisible = function(Vis)
            if TracerTable.Deleted == true or Tracer == nil then return end
    
            if typeof(Vis) == "boolean" then TracerTable.Vis = Vis end
        end
    else
        TracerTable.Deleted = true;
        TracerTable.Delete = function()end
        TracerTable.ChangeColor = function()end
	TracerTable.SetVisible = function()end
    end

    table.insert(ESP, TracerTable)
    return TracerTable
end

return Lib
