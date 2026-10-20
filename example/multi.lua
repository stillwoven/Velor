local Velor = loadstring(game:HttpGet("https://raw.githubusercontent.com/stillwoven/Velor/refs/heads/main/src/Velor.lua"))()

local Combat = Velor:CreateWindow({ Title = "Combat", Theme = "Velor", ToggleKey = Enum.KeyCode.RightShift })
local Combatz = Combat:AddSection("Elements")
Combatz:AddToggle({ Name = "Toggle", Default = true, Flag = "CombatToggle", Callback = print })
Combatz:AddSlider({ Name = "Slider", Min = 0, Max = 100, Default = 50, Flag = "CombatSlider", Callback = print })
Combatz:AddButton({ Name = "Button", Style = "Accent", Callback = print })

local Visuals = Velor:CreateWindow({ Title = "Visuals", Theme = "Ocean", ToggleKey = Enum.KeyCode.RightControl })
local Visualz = Visuals:AddSection("Elements")
Visualz:AddToggle({ Name = "Toggle", Flag = "VisualsToggle", Callback = print })
Visualz:AddColorPicker({ Name = "Color", Flag = "VisualsColor" })
Visualz:AddDropdown({ Name = "Dropdown", Options = { "One", "Two", "Three" }, Default = "One", Flag = "VisualsDropdown" })

local Misc = Velor:CreateWindow({ Title = "Misc", Theme = "Emerald", ToggleKey = Enum.KeyCode.RightAlt })
local Miscz = Misc:AddSection("Elements")
Miscz:AddStepper({ Name = "Stepper", Min = 1, Max = 10, Default = 3, Flag = "MiscStepper" })
Miscz:AddSegmented({ Name = "Segmented", Options = { "One", "Two", "Three" }, Default = "Two", Flag = "MiscSegmented" })
Miscz:AddButton({ Name = "Button", Callback = print })

Velor:AutoLoad()

--[[ 

MULTI WINDOW EXAMPLE

]]--
