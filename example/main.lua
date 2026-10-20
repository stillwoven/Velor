local Velor = loadstring(game:HttpGet("https://raw.githubusercontent.com/stillwoven/Velor/refs/heads/main/src/Velor.lua"))()

local Window = Velor:CreateWindow({
    Title = "Vélor",
    Subtitle = "Example",
    Theme = "Velor",
    Corner = "Soft",
    ToggleKey = Enum.KeyCode.RightShift,
    -- Transition = "Drop",
    -- Font = "Montserrat",
    -- FontName = "MyFont",
    -- FontBold = false,
    -- Width = 280,
    -- Size = Vector2.new(280, 420),
    -- MaxHeight = 420,
    -- MinWidth = 220,
    -- MinHeight = 130,
    -- Resizable = true,
    -- Reflective = true,
    -- ReflectStrength = 1,
    -- Animated = true,
    -- Mobile = false,
    -- Hidden = false,
    -- Swipebar = { Edge = "Bottom", Along = 0.5 },
})

local Elements = Window:AddSection("Elements")
Elements:AddButton({ Name = "Button", Style = "Accent", Callback = print })
Elements:AddToggle({ Name = "Toggle", Default = true, Flag = "Toggle", Callback = print })
Elements:AddSlider({ Name = "Slider", Min = 0, Max = 100, Step = 5, Default = 50, Flag = "Slider", Callback = print })
Elements:AddStepper({ Name = "Stepper", Min = 1, Max = 10, Default = 3, Flag = "Stepper" })
local Progress = Elements:AddProgress({ Name = "ProgressBar", Default = 60 })
Elements:AddSegmented({ Name = "Segmented", Options = { "One", "Two", "Three" }, Default = "Two", Flag = "Segmented" })
Elements:AddInput({ Name = "Input", Placeholder = "Input", Flag = "Input" })
Elements:AddKeybind({ Name = "Keybind", Default = Enum.KeyCode.F, Flag = "Keybind", OnPress = print })
Elements:AddColorPicker({ Name = "Color", Default = Color3.fromRGB(214, 186, 132), Flag = "Color" })

local Lists = Window:AddSection("Dropdowns")
Lists:AddDropdown({ Name = "Dropdown", Options = { "One", "Two", "Three" }, Default = "One", Search = true, Flag = "Dropdown" })
Lists:AddDropdown({ Name = "Multi", Multi = true, Max = 2, Options = { "One", "Two", "Three", "Four" }, Flag = "Multi" })

local Feedback = Window:AddSection("Feedback")
Feedback:AddButton({ Name = "Notify", Callback = function()
    Window:Notify({ Title = "Notify", Content = "Content", Type = "Info" })
end })
Feedback:AddButton({ Name = "Confirm", Callback = function()
    Window:Confirm("Confirm", "Content", print)
end })
Feedback:AddButton({ Name = "Prompt", Callback = function()
    Window:Prompt("Prompt", "Content", print, { Placeholder = "Input" })
end })
Feedback:AddCallout({ Type = "Info", Title = "Callout", Content = "Content" })
Feedback:AddParagraph({ Title = "Paragraph", Content = "Content" })
Feedback:AddLabel("Label")
Feedback:AddDivider()

local Media = Window:AddSection("Media", { Collapsed = true })
Media:AddImage("https://picsum.photos/seed/velor/640/360.jpg", "Horizontal")
Media:AddCollage({
    "https://picsum.photos/seed/a/400/400.jpg", "https://picsum.photos/seed/b/400/400.jpg",
    "https://picsum.photos/seed/c/400/400.jpg", "https://picsum.photos/seed/d/400/400.jpg",
}, "Square")

Window:AddInterfaceSection({ Collapsed = true })
Window:AddConfigSection({ Collapsed = true })

Velor:AutoLoad()
