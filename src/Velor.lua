local Library = {
    Version = "1.0.0",
    CustomFonts = {},
    Windows = {},
    Flags = {},
    FlagObjects = {},
    Roots = {},
    Defaults = { Theme = "Velor", Corner = "Soft" },
}

local genv = (getgenv and getgenv()) or _G
if genv.__VelorUI then
    pcall(function() genv.__VelorUI:Destroy() end)
end
genv.__VelorUI = Library

local cloneref = cloneref or function(o) return o end
local function Service(name) return cloneref(game:GetService(name)) end

local Players = Service("Players")
local TweenService = Service("TweenService")
local UserInputService = Service("UserInputService")
local RunService = Service("RunService")
local HttpService = Service("HttpService")
local CoreGui = Service("CoreGui")
local TextService = Service("TextService")

local LocalPlayer = Players.LocalPlayer

local function RGB(r, g, b) return Color3.fromRGB(r, g, b) end

local Semantic = {
    Success = RGB(74, 222, 128),
    Warning = RGB(251, 191, 36),
    Danger = RGB(248, 113, 113),
}

local Themes = {
    Velor = {
        Background = RGB(10, 10, 12), Surface = RGB(17, 17, 20), Elevated = RGB(25, 25, 29),
        Hover = RGB(35, 35, 40), Stroke = RGB(52, 50, 48), Accent = RGB(214, 186, 132), Accent2 = RGB(244, 226, 182),
        OnAccent = RGB(26, 19, 8), Text = RGB(245, 243, 239), SubText = RGB(163, 159, 153),
        Muted = RGB(104, 101, 97),
    },
    Midnight = {
        Background = RGB(11, 11, 15), Surface = RGB(18, 18, 24), Elevated = RGB(25, 25, 33),
        Hover = RGB(33, 33, 43), Stroke = RGB(46, 46, 62), Accent = RGB(139, 108, 255), Accent2 = RGB(70, 170, 255),
        OnAccent = RGB(255, 255, 255), Text = RGB(238, 238, 246), SubText = RGB(148, 148, 168),
        Muted = RGB(92, 92, 110),
    },
    Obsidian = {
        Background = RGB(12, 12, 13), Surface = RGB(20, 20, 22), Elevated = RGB(28, 28, 31),
        Hover = RGB(37, 37, 41), Stroke = RGB(52, 52, 58), Accent = RGB(232, 232, 238), Accent2 = RGB(130, 130, 146),
        OnAccent = RGB(14, 14, 16), Text = RGB(240, 240, 242), SubText = RGB(152, 152, 160),
        Muted = RGB(98, 98, 106),
    },
    Ocean = {
        Background = RGB(8, 12, 18), Surface = RGB(14, 20, 29), Elevated = RGB(20, 28, 40),
        Hover = RGB(28, 38, 53), Stroke = RGB(40, 56, 78), Accent = RGB(66, 153, 255), Accent2 = RGB(45, 212, 200),
        OnAccent = RGB(255, 255, 255), Text = RGB(232, 240, 250), SubText = RGB(136, 154, 178),
        Muted = RGB(84, 100, 122),
    },
    Emerald = {
        Background = RGB(8, 14, 13), Surface = RGB(13, 22, 20), Elevated = RGB(19, 31, 28),
        Hover = RGB(26, 42, 38), Stroke = RGB(38, 62, 55), Accent = RGB(45, 212, 150), Accent2 = RGB(34, 190, 235),
        OnAccent = RGB(6, 24, 18), Text = RGB(230, 246, 240), SubText = RGB(132, 164, 154),
        Muted = RGB(80, 108, 100),
    },
    Rose = {
        Background = RGB(15, 9, 12), Surface = RGB(24, 14, 19), Elevated = RGB(33, 20, 26),
        Hover = RGB(44, 27, 35), Stroke = RGB(66, 40, 52), Accent = RGB(251, 113, 155), Accent2 = RGB(190, 130, 252),
        OnAccent = RGB(36, 8, 18), Text = RGB(250, 234, 240), SubText = RGB(176, 138, 152),
        Muted = RGB(116, 86, 98),
    },
    Ember = {
        Background = RGB(14, 11, 8), Surface = RGB(23, 18, 12), Elevated = RGB(32, 25, 17),
        Hover = RGB(43, 34, 23), Stroke = RGB(64, 50, 34), Accent = RGB(251, 176, 64), Accent2 = RGB(250, 98, 78),
        OnAccent = RGB(30, 18, 4), Text = RGB(250, 242, 230), SubText = RGB(172, 156, 134),
        Muted = RGB(112, 98, 80),
    },
    Frost = {
        Background = RGB(10, 14, 20), Surface = RGB(17, 23, 32), Elevated = RGB(24, 32, 44),
        Hover = RGB(33, 43, 58), Stroke = RGB(52, 66, 86), Accent = RGB(150, 205, 255), Accent2 = RGB(205, 228, 255),
        OnAccent = RGB(10, 20, 34), Text = RGB(236, 243, 252), SubText = RGB(144, 160, 182),
        Muted = RGB(92, 106, 126),
    },
    Noir = {
        Background = RGB(10, 9, 8), Surface = RGB(18, 16, 14), Elevated = RGB(27, 24, 21),
        Hover = RGB(37, 33, 28), Stroke = RGB(58, 51, 42), Accent = RGB(226, 190, 120), Accent2 = RGB(255, 228, 178),
        OnAccent = RGB(28, 20, 8), Text = RGB(246, 240, 230), SubText = RGB(168, 158, 142),
        Muted = RGB(106, 98, 86),
    },
    Platinum = {
        Background = RGB(13, 14, 16), Surface = RGB(21, 23, 26), Elevated = RGB(30, 32, 36),
        Hover = RGB(40, 43, 48), Stroke = RGB(60, 64, 72), Accent = RGB(196, 206, 224), Accent2 = RGB(150, 164, 190),
        OnAccent = RGB(14, 16, 22), Text = RGB(242, 244, 248), SubText = RGB(152, 160, 174),
        Muted = RGB(98, 104, 116),
    },
    Aurora = {
        Background = RGB(9, 11, 17), Surface = RGB(15, 18, 27), Elevated = RGB(22, 26, 38),
        Hover = RGB(30, 35, 50), Stroke = RGB(46, 54, 76), Accent = RGB(94, 234, 212), Accent2 = RGB(167, 139, 250),
        OnAccent = RGB(6, 22, 24), Text = RGB(234, 242, 248), SubText = RGB(142, 156, 176),
        Muted = RGB(90, 102, 122),
    },
}
for _, theme in pairs(Themes) do
    for key, value in pairs(Semantic) do theme[key] = value end
end

local Corners = { Rounded = 12, Soft = 7, Sharp = 2, Square = 0 }

Library.Themes = Themes
Library.Corners = Corners

function Library:AddTheme(name, colors)
    colors = colors or {}
    local theme = {}
    for key, value in pairs(Themes.Midnight) do theme[key] = value end
    for key, value in pairs(colors) do theme[key] = value end
    if colors.Accent and not colors.Accent2 then
        local h, s, v = colors.Accent:ToHSV()
        theme.Accent2 = Color3.fromHSV((h + 0.1) % 1, s, v)
    end
    Themes[name] = theme
    return theme
end

local function KP(t, c) return ColorSequenceKeypoint.new(t, c) end

local Builders = {

    Flow = function(T) return ColorSequence.new({ KP(0, T.Accent), KP(0.5, T.Accent2), KP(1, T.Accent) }) end,
    Soft = function(T) return ColorSequence.new(T.Accent, T.Accent2) end,

    Metal = function(T)
        local function steel(v) return Color3.fromRGB(v, v, v + 6):Lerp(T.Accent, 0.1) end
        return ColorSequence.new({
            KP(0, steel(238)), KP(0.16, steel(118)), KP(0.34, steel(214)), KP(0.52, steel(66)),
            KP(0.7, steel(196)), KP(0.86, steel(104)), KP(1, steel(238)),
        })
    end,

    Pane = function(T)
        return ColorSequence.new(T.Surface:Lerp(Color3.new(1, 1, 1), 0.07), T.Surface)
    end,

    Rim = function(T)
        return ColorSequence.new({
            KP(0, T.Accent), KP(0.22, T.Accent2), KP(0.5, T.Stroke), KP(0.78, T.Stroke), KP(1, T.Accent),
        })
    end,
}

local function LerpTheme(a, b, t)
    local out = {}
    for _, key in ipairs({ "Accent", "Accent2", "Stroke", "Surface", "Elevated", "Background", "Hover" }) do out[key] = a[key]:Lerp(b[key], t) end
    return out
end

local function RandomName()
    return (HttpService:GenerateGUID(false):gsub("%-", ""))
end

local function Mount(gui)
    local protect = (syn and syn.protect_gui) or protect_gui or protectgui
    if protect then pcall(protect, gui) end
    local ok = pcall(function()
        gui.Parent = (gethui and gethui()) or CoreGui
    end)
    if not ok or not gui.Parent then
        gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end
end

local function Http(url)
    local req = (syn and syn.request) or (http and http.request) or http_request or request or (fluxus and fluxus.request)
    if req then
        local ok, res = pcall(req, { Url = url, Method = "GET" })
        if ok and type(res) == "table" then
            local code = res.StatusCode or res.Status_Code
            if res.Body and res.Success ~= false and (code == nil or code == 200) then return res.Body end
            return nil, "HTTP " .. tostring(code)
        end
    end
    local ok, body = pcall(function() return game:HttpGet(url) end)
    if ok and type(body) == "string" and body ~= "" then return body end
    return nil, "no executor http function available"
end
Library.Http = Http

local function AssetOf(path)
    local fn = getcustomasset or getsynasset
    if not fn then return nil end
    local ok, id = pcall(fn, path)
    return ok and id or nil
end

local function Hash(text)
    local h = 5381
    for i = 1, #text do h = (h * 33 + text:byte(i)) % 4294967296 end
    return string.format("%x", h)
end

local function EnsureFolder(path)
    if makefolder and isfolder and not isfolder(path) then pcall(makefolder, path) end
end

local FontSys = { Tracked = setmetatable({}, { __mode = "k" }), Active = false }
local FontPresets = {
    Gotham = "GothamSSm", ["Builder Sans"] = "BuilderSans", Montserrat = "Montserrat", Ubuntu = "Ubuntu",
    Nunito = "Nunito", Roboto = "Roboto", ["Source Sans"] = "SourceSansPro", Arimo = "Arimo", ["Roboto Mono"] = "RobotoMono",
}
local BoldFonts = { [Enum.Font.GothamBold] = true, [Enum.Font.GothamBlack] = true, [Enum.Font.SourceSansBold] = true }

local function FontFace(bold)
    if FontSys.Family then
        return Font.new(FontSys.Family, bold and Enum.FontWeight.Bold or Enum.FontWeight.Regular)
    elseif FontSys.Preset then
        return Font.fromName(FontSys.Preset, bold and Enum.FontWeight.Bold or Enum.FontWeight.Medium)
    end
end

local function FontPaint(inst)
    local bold = FontSys.Tracked[inst] == true
    if FontSys.Active then
        local ok, face = pcall(FontFace, bold)
        if ok and face then pcall(function() inst.FontFace = face end) end
    else
        pcall(function() inst.Font = bold and Enum.Font.GothamBold or Enum.Font.GothamMedium end)
    end
end

function FontSys.Track(inst)
    if inst.Font ~= Enum.Font.Unknown then FontSys.Tracked[inst] = BoldFonts[inst.Font] == true end
    if FontSys.Active then FontPaint(inst) end
end

function FontSys.Refresh()
    for inst in pairs(FontSys.Tracked) do FontPaint(inst) end
end

function Library:LoadFont(name, source, bold)
    name = tostring(name or "Custom")
    if not (writefile and (getcustomasset or getsynasset)) then
        return nil, "this executor has no writefile / getcustomasset"
    end
    local safe = name:gsub("[^%w_%-]", "_")
    EnsureFolder("Velor"); EnsureFolder("Velor/fonts")
    local function resolve(src, tag)
        src = tostring(src)
        if src:match("^https?://") then
            local ext = src:lower():match("%.(otf)[%?#]?") or "ttf"
            local path = ("Velor/fonts/%s_%s_%s.%s"):format(safe, tag, Hash(src), ext)
            if not (isfile and isfile(path)) then
                local body, err = Http(src)
                if not body then return nil, "download failed: " .. tostring(err) end
                writefile(path, body)
            end
            return path
        end
        if isfile and isfile(src) then return src end
        return nil, "file not found: " .. src
    end
    local regular, err = resolve(source, "r")
    if not regular then return nil, err end
    local heavy = regular
    if bold then heavy, err = resolve(bold, "b"); if not heavy then return nil, err end end
    local regularId, heavyId = AssetOf(regular), AssetOf(heavy)
    if not regularId then return nil, "getcustomasset failed" end
    local jsonPath = ("Velor/fonts/%s_%s.json"):format(safe, Hash(tostring(source) .. tostring(bold)))
    writefile(jsonPath, HttpService:JSONEncode({ name = name, faces = {
        { name = "Regular", weight = 400, style = "normal", assetId = regularId },
        { name = "Bold", weight = 700, style = "normal", assetId = heavyId or regularId },
    } }))
    local family = AssetOf(jsonPath)
    if not family then return nil, "could not register font family" end
    self.CustomFonts[name] = family
    return family
end

function Library:SetFont(font, opts)
    opts = opts or {}
    font = font or "Default"
    if font == "Default" then
        FontSys.Active, FontSys.Family, FontSys.Preset, FontSys.Name = false, nil, nil, "Default"
    elseif FontPresets[font] then
        FontSys.Active, FontSys.Family, FontSys.Preset, FontSys.Name = true, nil, FontPresets[font], font
    elseif self.CustomFonts[font] then
        FontSys.Active, FontSys.Family, FontSys.Preset, FontSys.Name = true, self.CustomFonts[font], nil, font
    else
        local name = opts.Name or tostring(font):match("([^/\\]+)%.%a+[%?#]?.*$") or "Custom"
        local family, err = self:LoadFont(name, font, opts.Bold)
        if not family then return false, err end
        FontSys.Active, FontSys.Family, FontSys.Preset, FontSys.Name = true, family, nil, name
    end
    FontSys.Refresh()
    return true
end

function Library:GetFont() return FontSys.Name or "Default" end

function Library:GetFonts()
    local list = { "Default" }
    for name in pairs(FontPresets) do list[#list + 1] = name end
    for name in pairs(self.CustomFonts) do list[#list + 1] = name end
    table.sort(list, function(a, b)
        if a == "Default" then return true elseif b == "Default" then return false end
        return a < b
    end)
    return list
end

local TEXT_CLASSES = { TextLabel = true, TextButton = true, TextBox = true }
local TRANSPARENT_CLASSES = {
    TextLabel = true, TextButton = true, TextBox = true,
    ImageLabel = true, ImageButton = true, ScrollingFrame = true,
}

local function Create(class, props, children)
    local inst = Instance.new(class)
    if inst:IsA("GuiObject") then
        inst.BorderSizePixel = 0
        if TRANSPARENT_CLASSES[class] then inst.BackgroundTransparency = 1 end
        if inst:IsA("GuiButton") then inst.AutoButtonColor = false end
    end
    if TEXT_CLASSES[class] then
        inst.Text = ""
        inst.Font = Enum.Font.GothamMedium
        inst.TextSize = 14
        inst.TextColor3 = Color3.new(1, 1, 1)
        if class == "TextBox" then inst.ClearTextOnFocus = false end
    end
    local parent, fit, grow
    if props then
        for key, value in pairs(props) do
            if key == "Parent" then parent = value
            elseif key == "Fit" then fit = value
            elseif key == "Grow" then grow = value
            else inst[key] = value end
        end

        if fit == nil and props.TextTruncate == Enum.TextTruncate.AtEnd and not props.TextWrapped then fit = true end
    end
    if children then
        for _, child in ipairs(children) do child.Parent = inst end
    end
    if TEXT_CLASSES[class] then FontSys.Track(inst) end
    if fit and TEXT_CLASSES[class] and class ~= "TextBox" then
        local max = inst.TextSize
        inst.TextTruncate = Enum.TextTruncate.None
        inst.TextScaled = true
        Create("UITextSizeConstraint", { MaxTextSize = max, MinTextSize = 7, Parent = inst })

        local busy = false
        local function measure(size, width)
            local ok, bounds = pcall(function()
                local params = Instance.new("GetTextBoundsParams")
                params.Text, params.Font, params.Size, params.Width = inst.Text, inst.FontFace, size, width
                return TextService:GetTextBoundsAsync(params)
            end)
            return ok and bounds or nil
        end
        local function refit()
            if busy or inst.RichText then return end
            local width = inst.AbsoluteSize.X
            if width < 8 or inst.Text == "" then return end
            busy = true
            local bounds = measure(max, 100000)
            if bounds and bounds.X > 0 then
                local ratio = math.min(1, width / bounds.X)
                local wrap = max * ratio < math.min(10, max)
                if wrap and grow then
                    local size = math.max(10, max - 1)
                    if inst.TextScaled then inst.TextScaled = false end
                    if inst.TextSize ~= size then inst.TextSize = size end
                    if not inst.TextWrapped then inst.TextWrapped = true end
                    local tall = measure(size, width)
                    grow(tall and math.ceil(tall.Y) or nil)
                else
                    if not inst.TextScaled then inst.TextScaled = true end
                    if inst.TextWrapped then inst.TextWrapped = false end
                    if grow then grow(nil) end
                end
            end
            busy = false
        end
        inst:GetPropertyChangedSignal("Text"):Connect(refit)
        inst:GetPropertyChangedSignal("AbsoluteSize"):Connect(refit)
        inst:GetPropertyChangedSignal("FontFace"):Connect(refit)
        task.defer(refit)
    end
    if parent then inst.Parent = parent end
    return inst
end

local Motion = { Out = Enum.EasingStyle.Exponential, In = Enum.EasingStyle.Quart, Smooth = Enum.EasingStyle.Sine }
Library.Motion = Motion

local function Tween(inst, props, time, style, direction)
    direction = direction or Enum.EasingDirection.Out
    if style == nil or style == Enum.EasingStyle.Back or style == Enum.EasingStyle.Quint then
        style = direction == Enum.EasingDirection.In and Motion.In or Motion.Out
    end
    local tween = TweenService:Create(inst, TweenInfo.new(time or 0.28, style, direction), props)
    tween:Play()
    return tween
end

local function Apply(inst, props, instant, time, style, direction)
    if instant then
        for key, value in pairs(props) do inst[key] = value end
        return nil
    end
    return Tween(inst, props, time, style, direction)
end

local function Pad(parent, left, top, right, bottom)
    return Create("UIPadding", {
        PaddingLeft = UDim.new(0, left), PaddingTop = UDim.new(0, top),
        PaddingRight = UDim.new(0, right or left), PaddingBottom = UDim.new(0, bottom or top),
        Parent = parent,
    })
end

local function IsPointerDown(input)
    return input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch
end

local function IsPointerMove(input)
    return input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
end

local reporting = false
local function Fire(label, name, fn, ...)
    if not fn then return end
    local ok, err = pcall(fn, ...)
    if ok then return end
    warn("[Velor] " .. label .. " error in '" .. tostring(name) .. "': " .. tostring(err))
    if reporting then return end
    reporting = true
    local message = tostring(err):gsub("^[^\n]-:%d+:%s*", "")
    pcall(function()
        local window = Library.Windows[#Library.Windows]
        local opts = { Title = "Error in " .. tostring(name), Content = message, Type = "Error", Duration = 6 }
        if window then window:Notify(opts) else Library:Notify(opts) end
    end)
    reporting = false
end

local function Decimals(step)
    local d, s = 0, step
    while math.abs(s - math.floor(s + 0.5)) > 1e-9 and d < 5 do s = s * 10; d = d + 1 end
    return d
end

local function NewSpring(x, freq, damping)
    return { x = x, v = 0, g = x, w = freq or 12, z = damping or 1 }
end

local function StepSpring(sp, dt)
    local n = math.max(1, math.ceil(dt / (1 / 120)))
    local h = dt / n
    local k, c = sp.w * sp.w, 2 * sp.z * sp.w
    for _ = 1, n do
        sp.v = sp.v + (-k * (sp.x - sp.g) - c * sp.v) * h
        sp.x = sp.x + sp.v * h
    end
end

local function SpringRest(sp)
    return math.abs(sp.x - sp.g) < 0.0006 and math.abs(sp.v) < 0.004
end

local function Smooth(t)
    t = math.clamp(t, 0, 1)
    return t * t * t * (t * (t * 6 - 15) + 10)
end

local Bar

local Root = {}
Root.__index = Root

function Root.new(opts)
    opts = opts or {}
    local self = setmetatable({}, Root)

    local defaults = Library.Defaults
    self.ThemeName = Themes[opts.Theme] and opts.Theme or (Themes[defaults.Theme] and defaults.Theme or "Midnight")
    self.Theme = Themes[self.ThemeName]
    self.CornerName = Corners[opts.Corner] and opts.Corner or defaults.Corner
    self.Animated = opts.Animated ~= false

    self.Alpha = { Main = 0, Section = 0.35, Popup = 0 }

    self.Mobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    if opts.Mobile ~= nil then self.Mobile = opts.Mobile end
    if self.Mobile then
        self.Metrics = { Row = 44, Field = 32, Item = 38, Text = 14, Title = 46, Pad = 12, Width = 276, Header = 36, Knob = 44 }
    else
        self.Metrics = { Row = 34, Field = 25, Item = 28, Text = 13, Title = 40, Pad = 10, Width = 280, Header = 28, Knob = 40 }
    end

    self.Bound = {}
    self.Rounds = {}
    self.Flows = {}
    self.Anim = {}
    self.Connections = {}
    self.Elements = {}
    self.OpenDropdown = nil
    self.Time = 0
    self.Animating = true

    self.Gui = Create("ScreenGui", {
        Name = RandomName(), ResetOnSpawn = false, IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, DisplayOrder = 1000,
    })
    Mount(self.Gui)

    self.Catcher = Create("TextButton", {
        Name = "Catcher", Size = UDim2.fromScale(1, 1), Visible = false, ZIndex = 50, Parent = self.Gui,
    })
    self.Overlay = Create("Frame", {
        Name = "Overlay", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 60, Parent = self.Gui,
    })

    self:Connect(self.Catcher.InputBegan, function(input)
        if IsPointerDown(input) then self:CloseDropdown() end
    end)
    self:Connect(UserInputService.InputBegan, function(input)
        if input.KeyCode == Enum.KeyCode.Escape then self:CloseDropdown() end
    end)

    self:Connect(RunService.RenderStepped, function(dt)
        if not self.Animating then return end

        self.Acc = (self.Acc or 0) + dt
        if self.Acc < 0.025 then return end
        dt, self.Acc = self.Acc, 0
        self.Time = self.Time + dt
        local t = self.Time
        for entry in pairs(self.Anim) do
            if entry.On then
                local gradient = entry.G
                if entry.Spin then gradient.Rotation = (entry.Base + t * entry.Spin) % 360 end
                if entry.Sweep then
                    local v = math.sin(t * entry.Sweep + entry.Phase) * entry.Range
                    gradient.Offset = (entry.Axis == "Y") and Vector2.new(0, v) or Vector2.new(v, 0)
                end
            end
        end
        local blend = self.Blend
        if blend then
            blend.t = blend.t + dt / 0.4
            local a = math.min(1, blend.t)
            local theme = LerpTheme(blend.from, blend.to, a * a * (3 - 2 * a))
            for gradient, kind in pairs(self.Flows) do gradient.Color = Builders[kind](theme) end
            if a >= 1 then self.Blend = nil end
        end
    end)

    Library.Roots[#Library.Roots + 1] = self
    return self
end

function Root:Connect(signal, fn)
    local connection = signal:Connect(fn)
    self.Connections[#self.Connections + 1] = connection
    return connection
end

function Root:CloseDropdown()
    if self.OpenDropdown then self.OpenDropdown:Close() end
end

function Root:Bind(inst, map)
    local entry = self.Bound[inst]
    if not entry then
        entry = {}
        self.Bound[inst] = entry
        inst.Destroying:Connect(function() self.Bound[inst] = nil end)
    end
    for prop, key in pairs(map) do
        entry[prop] = key
        inst[prop] = self.Theme[key]
    end
    return inst
end

function Root:Round(inst, mult)
    mult = mult or 1
    local corner = Create("UICorner", {
        CornerRadius = UDim.new(0, math.max(0, math.floor(Corners[self.CornerName] * mult + 0.5))),
        Parent = inst,
    })
    self.Rounds[corner] = mult
    corner.Destroying:Connect(function() self.Rounds[corner] = nil end)
    return corner
end

function Root:Stroke(inst, key, thickness, transparency)
    local stroke = Create("UIStroke", {
        Thickness = thickness or 1, Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = inst,
    })
    self:Bind(stroke, { Color = key })
    return stroke
end

function Root:Animate(gradient, o)
    if not self.Animated then return { On = false } end
    local entry = {
        G = gradient, Spin = o.Spin, Sweep = o.Sweep, Range = o.Range or 1, Phase = o.Phase or 0,
        Axis = o.Axis or "X", Base = o.Base or gradient.Rotation, On = o.On ~= false,
    }
    self.Anim[entry] = true
    gradient.Destroying:Connect(function() self.Anim[entry] = nil end)
    return entry
end

function Root:Gradient(parent, kind, props, anim)
    local gradient = Create("UIGradient", { Color = Builders[kind](self.Theme), Parent = parent })
    if props then
        for key, value in pairs(props) do gradient[key] = value end
    end
    self.Flows[gradient] = kind
    gradient.Destroying:Connect(function() self.Flows[gradient] = nil end)
    local entry = anim and self:Animate(gradient, anim) or nil
    return gradient, entry
end

function Root:Shadow(parent, transparency, spread)
    spread = spread or 24
    return Create("ImageLabel", {
        Name = "Shadow", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 3),
        Size = UDim2.new(1, spread * 2, 1, spread * 2), Image = "rbxassetid://6014261993",
        ImageColor3 = Color3.new(0, 0, 0), ImageTransparency = transparency or 0.5,
        ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(49, 49, 450, 450),
        ZIndex = 0, Parent = parent,
    })
end

function Root:SetTheme(name, instant)
    local theme = Themes[name]
    if not theme then return false end
    local old = self.Theme
    self.ThemeName, self.Theme = name, theme
    for inst, map in pairs(self.Bound) do
        local props = {}
        for prop, key in pairs(map) do props[prop] = theme[key] end
        Apply(inst, props, instant, 0.35)
    end
    if instant or not (self.Animating and self.Animated) then
        self.Blend = nil
        for gradient, kind in pairs(self.Flows) do gradient.Color = Builders[kind](theme) end
    else
        self.Blend = { from = old, to = theme, t = 0 }
    end
    for _, element in ipairs(self.Elements) do
        if element._Restyle then element:_Restyle(instant) end
    end
    return true
end

function Root:SetCorner(name, instant)
    if not Corners[name] then return false end
    self.CornerName = name
    for corner, mult in pairs(self.Rounds) do
        Apply(corner, { CornerRadius = UDim.new(0, math.max(0, math.floor(Corners[name] * mult + 0.5))) }, instant, 0.3)
    end
    return true
end

function Root:Notify(opts)
    if type(opts) == "string" then opts = { Content = opts } end
    opts = opts or {}
    local M = self.Metrics
    local kind = opts.Type or "Info"
    local duration = opts.Duration or 4
    local sticky = duration <= 0
    local semantic = ({ Success = "Success", Warning = "Warning", Error = "Danger", Danger = "Danger" })[kind]
    local isInfo = semantic == nil
    local key = semantic or "Accent"
    local function ramp(...)
        local points, args = {}, { ... }
        for i = 1, #args, 2 do points[#points + 1] = NumberSequenceKeypoint.new(args[i], args[i + 1]) end
        return NumberSequence.new(points)
    end

    if not self.Toasts then
        local width = self.Mobile and 252 or 296
        self.ToastList = {}
        self.Toasts = Create("Frame", {
            Name = "Toasts", BackgroundTransparency = 1, ZIndex = 70, AutomaticSize = Enum.AutomaticSize.Y,
            AnchorPoint = self.Mobile and Vector2.new(0.5, 0) or Vector2.new(1, 0),
            Position = self.Mobile and UDim2.new(0.5, 0, 0, 12) or UDim2.new(1, -16, 0, 16),
            Size = UDim2.fromOffset(width, 0), Parent = self.Gui,
        }, {
            Create("UIListLayout", {
                Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = self.Mobile and Enum.HorizontalAlignment.Center or Enum.HorizontalAlignment.Right,
            }),
        })
    end
    self.ToastCount = (self.ToastCount or 0) + 1

    local slot = Create("Frame", {
        Name = "Slot", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), LayoutOrder = self.ToastCount,
        Parent = self.Toasts,
    })

    local shell = Create("Frame", {
        Name = "Shell", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        Position = UDim2.fromOffset(40, 0), Parent = slot,
    })
    local toast = Create("CanvasGroup", {
        Name = "Toast", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, GroupTransparency = 1,
        Parent = shell,
    })

    self:Bind(toast, { BackgroundColor3 = "Surface" })
    toast.BackgroundTransparency = 0.03
    Create("UISizeConstraint", { MinSize = Vector2.new(0, 54), Parent = toast })
    local scale = Create("UIScale", { Scale = 0.96, Parent = shell })
    self:Round(shell, 0.8)
    self:Round(toast, 0.8)
    local stroke = self:Stroke(shell, key, 1, 1)
    local STROKE_ON = 0.5

    local wash = Create("Frame", { Name = "Wash", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 0, Parent = toast })
    if isInfo then
        self:Gradient(wash, "Soft", { Rotation = 0, Transparency = ramp(0, 0.8, 0.65, 1, 1, 1) })
    else
        self:Bind(wash, { BackgroundColor3 = semantic })
        Create("UIGradient", { Rotation = 0, Transparency = ramp(0, 0.8, 0.65, 1, 1, 1), Parent = wash })
    end

    Create("Frame", { Name = "Sheen", Size = UDim2.new(1, 0, 0.6, 0), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 0, Parent = toast }, {
        Create("UIGradient", { Rotation = 90, Transparency = ramp(0, 0.93, 1, 1) }),
    })
    Create("Frame", { Name = "Highlight", Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 1, Parent = toast }, {
        Create("UIGradient", { Transparency = ramp(0, 1, 0.5, 0.7, 1, 1) }),
    })

    local tile = Create("Frame", {
        Name = "Icon", Position = UDim2.fromOffset(14, 13), Size = UDim2.fromOffset(28, 28), BackgroundTransparency = 0.8, ZIndex = 2, Parent = toast,
    }, { Create("UICorner", { CornerRadius = UDim.new(0, 9) }) })
    self:Bind(tile, { BackgroundColor3 = key })
    if kind == "Success" then
        Bar(self, tile, 11.5, 15.5, 6, 2.4, 45, key)
        Bar(self, tile, 16.5, 13.5, 12, 2.4, -50, key)
    elseif kind == "Error" or kind == "Danger" then
        Bar(self, tile, 14, 14, 12, 2.4, 45, key)
        Bar(self, tile, 14, 14, 12, 2.4, -45, key)
    elseif kind == "Warning" then
        Bar(self, tile, 14, 11.5, 9, 2.6, 90, key)
        Bar(self, tile, 14, 19, 2.8, 2.8, 0, key)
    else
        Bar(self, tile, 14, 9, 2.8, 2.8, 0, key)
        Bar(self, tile, 14, 16.5, 9, 2.6, 90, key)
    end

    local body = Create("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, ZIndex = 2, Parent = toast,
    }, { Create("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }) })
    Create("UIPadding", {
        PaddingLeft = UDim.new(0, 54), PaddingRight = UDim.new(0, 34), PaddingTop = UDim.new(0, opts.Title and 12 or 17),
        PaddingBottom = UDim.new(0, sticky and 14 or 19), Parent = body,
    })
    if opts.Title then
        local t = Create("TextLabel", {
            Text = opts.Title, Font = Enum.Font.GothamBold, TextSize = M.Text, TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1, Parent = body,
        })
        self:Bind(t, { TextColor3 = "Text" })
    end
    local c = Create("TextLabel", {
        Text = opts.Content or "", TextSize = M.Text - 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 2, Parent = body,
    })
    self:Bind(c, { TextColor3 = opts.Title and "SubText" or "Text" })

    local close = Create("TextButton", {
        Name = "Close", AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 8), Size = UDim2.fromOffset(20, 20),
        BackgroundTransparency = 1, ZIndex = 8, Parent = toast,
    })
    self:Bind(close, { BackgroundColor3 = "Hover" })
    self:Round(close, 0.5)
    Bar(self, close, 10, 10, 8, 1.8, 45, "Muted")
    Bar(self, close, 10, 10, 8, 1.8, -45, "Muted")
    close.MouseEnter:Connect(function() Tween(close, { BackgroundTransparency = 0.3 }, 0.15) end)
    close.MouseLeave:Connect(function() Tween(close, { BackgroundTransparency = 1 }, 0.2) end)

    local track = Create("Frame", {
        AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 14, 1, -8), Size = UDim2.new(1, -28, 0, 2), ZIndex = 3,
        Visible = not sticky, BackgroundTransparency = 0.2, Parent = toast,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    self:Bind(track, { BackgroundColor3 = "Elevated" })
    local fill = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 4, Parent = track },
        { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    if isInfo then self:Gradient(fill, "Flow", nil, { Sweep = 1.4, Range = 0.5 }) else self:Bind(fill, { BackgroundColor3 = semantic }) end

    local closed, hovered = false, false
    local toasts = self.ToastList
    local function dismiss()
        if closed then return end
        closed = true
        for i, entry in ipairs(toasts) do if entry.Slot == slot then table.remove(toasts, i) break end end

        Tween(stroke, { Transparency = 1 }, 0.16, Enum.EasingStyle.Quad)
        Tween(toast, { GroupTransparency = 1 }, 0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        Tween(shell, { Position = UDim2.fromOffset(40, 0) }, 0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        Tween(scale, { Scale = 0.96 }, 0.3)
        task.delay(0.2, function()
            if slot.Parent then Tween(slot, { Size = UDim2.new(1, 0, 0, 0) }, 0.36, Enum.EasingStyle.Quint) end
        end)
        task.delay(0.6, function() slot:Destroy() end)
    end
    close.Activated:Connect(dismiss)

    local hit = Create("TextButton", { Size = UDim2.fromScale(1, 1), ZIndex = 6, Parent = toast })
    hit.MouseEnter:Connect(function()
        hovered = true
        if closed then return end
        Tween(stroke, { Transparency = 0.1 }, 0.2)
    end)
    hit.MouseLeave:Connect(function()
        hovered = false
        if closed then return end
        Tween(stroke, { Transparency = STROKE_ON }, 0.25)
    end)
    hit.Activated:Connect(function()
        Fire("toast", opts.Title or "toast", opts.Callback)
        dismiss()
    end)

    toasts[#toasts + 1] = { Slot = slot, Dismiss = dismiss }
    if #toasts > 5 then toasts[1].Dismiss() end

    task.spawn(function()

        local height = 0
        for _ = 1, 12 do
            RunService.RenderStepped:Wait()
            height = shell.AbsoluteSize.Y / math.max(scale.Scale, 0.01)
            if height > 4 then break end
        end
        if closed or not slot.Parent then return end
        height = math.max(height, 40)
        Tween(slot, { Size = UDim2.new(1, 0, 0, height) }, 0.45, Enum.EasingStyle.Quint)
        Tween(toast, { GroupTransparency = 0 }, 0.45, Enum.EasingStyle.Quint)
        Tween(stroke, { Transparency = STROKE_ON }, 0.45, Enum.EasingStyle.Quint)
        Tween(shell, { Position = UDim2.fromOffset(0, 0) }, 0.55, Enum.EasingStyle.Quint)
        Tween(scale, { Scale = 1 }, 0.55, Enum.EasingStyle.Quint)
        if sticky then return end

        local elapsed = 0
        while not closed and elapsed < duration do
            local dt = RunService.RenderStepped:Wait()
            if not hovered then elapsed = elapsed + dt end
            if fill.Parent then fill.Size = UDim2.fromScale(math.max(0, 1 - elapsed / duration), 1) end
        end
        dismiss()
    end)
end

function Root:Destroy()
    for _, connection in ipairs(self.Connections) do pcall(function() connection:Disconnect() end) end
    self.Connections = {}
    for _, element in ipairs(self.Elements) do
        if element.Flag and Library.FlagObjects[element.Flag] == element then
            Library.FlagObjects[element.Flag] = nil
            Library.Flags[element.Flag] = nil
        end
        if element._Cleanup then pcall(element._Cleanup, element) end
    end
    if self.Gui then self.Gui:Destroy() end
    for i, root in ipairs(Library.Roots) do
        if root == self then table.remove(Library.Roots, i) break end
    end
end

local function Register(root, element, flag)
    root.Elements[#root.Elements + 1] = element
    element.Flag = flag
    if flag then
        Library.FlagObjects[flag] = element
        Library.Flags[flag] = element:Get()
    end
end

local function Unregister(root, element)
    for i, e in ipairs(root.Elements) do
        if e == element then table.remove(root.Elements, i) break end
    end
    if element.Flag and Library.FlagObjects[element.Flag] == element then
        Library.FlagObjects[element.Flag] = nil
        Library.Flags[element.Flag] = nil
    end
end

function Bar(root, parent, x, y, length, thickness, rotation, colorKey)
    local bar = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(x, y),
        Size = UDim2.fromOffset(length, thickness), Rotation = rotation, Parent = parent,
    })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = bar })
    root:Bind(bar, { BackgroundColor3 = colorKey })
    return bar
end

local function MakeRow(root, parent, name, height, order, labelWidth)
    local M = root.Metrics
    local row = Create("Frame", {
        Name = "Row_" .. name, BackgroundTransparency = 1, LayoutOrder = order or 0,
        Size = UDim2.new(1, 0, 0, height or M.Row), Parent = parent,
    })
    local base = height or M.Row
    local label = Create("TextLabel", {
        Text = name, TextSize = M.Text, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd, AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 2, 0.5, 0), Size = UDim2.new(labelWidth or 0.42, -8, 1, 0), Parent = row,
        Grow = function(h)
            local target = h and math.max(base, h + 14) or base
            if row.Size.Y.Offset ~= target then row.Size = UDim2.new(1, 0, 0, target) end
        end,
    })
    root:Bind(label, { TextColor3 = "Text" })

    local plate = Create("Frame", {
        Name = "Plate", Size = UDim2.new(1, 8, 1, -2), Position = UDim2.fromOffset(-4, 1), ZIndex = 0,
        BackgroundTransparency = 1, Parent = row,
    })
    root:Bind(plate, { BackgroundColor3 = "Hover" })
    root:Round(plate, 0.6)
    row.MouseEnter:Connect(function() Tween(plate, { BackgroundTransparency = 0.72 }, 0.18) end)
    row.MouseLeave:Connect(function() Tween(plate, { BackgroundTransparency = 1 }, 0.25) end)
    return row, label
end

local function MakeRim(root, parent, mult)
    local rim = Create("Frame", {
        Name = "Rim", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 3, Parent = parent,
    })
    root:Round(rim, mult or 0.6)
    local stroke = Create("UIStroke", {
        Thickness = 1.5, Transparency = 1, Color = Color3.new(1, 1, 1),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = rim,
    })
    local _, entry = root:Gradient(stroke, "Rim", nil, { Spin = 150, On = false })
    local control = {}
    function control.Set(state)
        control.State = state
        if state then entry.On = true end
        Tween(stroke, { Transparency = state and 0.05 or 1 }, 0.25)
        if not state then
            task.delay(0.3, function()
                if not control.State then entry.On = false end
            end)
        end
    end
    return control
end

local function AccentFill(root, button, text, size, mult)
    button.BackgroundTransparency = 1
    button.Text = ""
    local fill = Create("Frame", {
        Name = "Fill", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 1, Parent = button,
    })
    root:Round(fill, mult or 0.6)
    root:Gradient(fill, "Flow", nil, { Sweep = 1.1, Range = 0.6 })
    local label = Create("TextLabel", {
        Name = "Label", Text = text, Font = Enum.Font.GothamBold, TextSize = size, Size = UDim2.fromScale(1, 1), ZIndex = 3,
        Fit = true, Parent = button,
    })
    root:Bind(label, { TextColor3 = "OnAccent" })
    return label
end

function Root:Dialog(opts)
    if type(opts) == "string" then opts = { Content = opts } end
    opts = opts or {}
    local M = self.Metrics
    local kind = opts.Type or "Info"
    local semantic = ({ Success = "Success", Warning = "Warning", Error = "Danger", Danger = "Danger" })[kind]
    local key = semantic or "Accent"
    local buttons = opts.Buttons
    if type(buttons) ~= "table" or #buttons == 0 then buttons = { { Name = "OK", Style = "Accent" } } end
    local dismissible = opts.Dismissible ~= false
    local view = self.Gui.AbsoluteSize
    if view.X < 10 then view = Vector2.new(1280, 720) end
    local width = math.min(opts.Width or (self.Mobile and 280 or 330), view.X - 24)

    self.DialogStack = self.DialogStack or {}
    local dialog = { Closed = false }

    local layer = Create("Frame", { Name = "Dialog", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 80, Parent = self.Gui })
    local scrim = Create("TextButton", {
        Name = "Scrim", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1, ZIndex = 1, Parent = layer,
    })
    local shell = Create("Frame", {
        Name = "Shell", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(width, 0), AutomaticSize = Enum.AutomaticSize.Y, ZIndex = 2, Parent = layer,
    })
    local scale = Create("UIScale", { Scale = 0.93, Parent = shell })
    self:Round(shell, 1)
    local stroke = self:Stroke(shell, key, 1, 1)
    local card = Create("CanvasGroup", {
        Name = "Card", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, GroupTransparency = 1,
        Active = true, Parent = shell,
    })

    self:Bind(card, { BackgroundColor3 = "Surface" })
    card.BackgroundTransparency = 0
    self:Round(card, 1)
    Create("Frame", { Name = "Sheen", Size = UDim2.new(1, 0, 0.5, 0), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 0, Parent = card }, {
        Create("UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.93), NumberSequenceKeypoint.new(1, 1) }) }),
    })
    local wash = Create("Frame", { Name = "Wash", Size = UDim2.new(1, 0, 0, 90), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 0, Parent = card })
    if semantic then
        self:Bind(wash, { BackgroundColor3 = semantic })
        Create("UIGradient", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.82), NumberSequenceKeypoint.new(1, 1) }), Parent = wash })
    else
        self:Gradient(wash, "Soft", { Rotation = 90, Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.84), NumberSequenceKeypoint.new(1, 1) }) })
    end

    local content = Create("Frame", {
        Name = "Content", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, ZIndex = 2, Parent = card,
    }, { Create("UIListLayout", { Padding = UDim.new(0, 14), SortOrder = Enum.SortOrder.LayoutOrder }) })
    Pad(content, 18, 18, 18, 16)

    local head = Create("Frame", { Name = "Head", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1, Parent = content })
    local tile = Create("Frame", {
        Position = UDim2.fromOffset(0, 0), Size = UDim2.fromOffset(34, 34), BackgroundTransparency = 0.8, Parent = head,
    }, { Create("UICorner", { CornerRadius = UDim.new(0, 11) }) })
    self:Bind(tile, { BackgroundColor3 = key })
    if kind == "Success" then
        Bar(self, tile, 14, 19, 7, 2.6, 45, key)
        Bar(self, tile, 20, 16.5, 14, 2.6, -50, key)
    elseif kind == "Error" or kind == "Danger" then
        Bar(self, tile, 17, 17, 14, 2.6, 45, key)
        Bar(self, tile, 17, 17, 14, 2.6, -45, key)
    elseif kind == "Warning" then
        Bar(self, tile, 17, 14, 11, 3, 90, key)
        Bar(self, tile, 17, 23, 3.2, 3.2, 0, key)
    else
        Bar(self, tile, 17, 11, 3.2, 3.2, 0, key)
        Bar(self, tile, 17, 20, 11, 3, 90, key)
    end
    local text = Create("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = head,
    }, { Create("UIListLayout", { Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder }) })
    Create("UIPadding", { PaddingLeft = UDim.new(0, 46), PaddingTop = UDim.new(0, 1), Parent = text })
    Create("UISizeConstraint", { MinSize = Vector2.new(0, 34), Parent = head })
    if opts.Title then
        local t = Create("TextLabel", {
            Text = tostring(opts.Title), Font = Enum.Font.GothamBold, TextSize = M.Text + 2, TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1, Parent = text,
        })
        self:Bind(t, { TextColor3 = "Text" })
    end
    local body = Create("TextLabel", {
        Text = tostring(opts.Content or ""), TextSize = M.Text - 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 2,
        RichText = opts.RichText == true, Parent = text,
    })
    self:Bind(body, { TextColor3 = opts.Title and "SubText" or "Text" })

    local box
    if opts.Input then
        local io = type(opts.Input) == "table" and opts.Input or {}
        local field = Create("Frame", { Name = "Input", Size = UDim2.new(1, 0, 0, M.Field + 8), LayoutOrder = 2, Parent = content })
        self:Bind(field, { BackgroundColor3 = "Elevated" })
        self:Round(field, 0.6)
        local fieldStroke = self:Stroke(field, "Stroke", 1, 0.1)
        box = Create("TextBox", {
            Text = tostring(io.Default or ""), PlaceholderText = io.Placeholder or "Type here...", TextSize = M.Text,
            TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -24, 1, 0),
            ClearTextOnFocus = false, Parent = field,
        })
        self:Bind(box, { TextColor3 = "Text", PlaceholderColor3 = "Muted" })
        box.Focused:Connect(function() Tween(fieldStroke, { Color = self.Theme.Accent }, 0.2) end)
        box.FocusLost:Connect(function() Tween(fieldStroke, { Color = self.Theme.Stroke }, 0.25) end)
    end

    local n = #buttons
    local stacked = n > 3
    local row = Create("Frame", {
        Name = "Buttons", BackgroundTransparency = 1, LayoutOrder = 3, Size = UDim2.new(1, 0, 0, stacked and 0 or (M.Field + 8)),
        AutomaticSize = stacked and Enum.AutomaticSize.Y or Enum.AutomaticSize.None, Parent = content,
    }, { Create("UIListLayout", {
        Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = stacked and Enum.FillDirection.Vertical or Enum.FillDirection.Horizontal,
    }) })

    local primary
    local function close(silent)
        if dialog.Closed then return end
        dialog.Closed = true
        for i, d in ipairs(self.DialogStack) do if d == dialog then table.remove(self.DialogStack, i) break end end
        if dialog.Esc then dialog.Esc:Disconnect() end
        Tween(scrim, { BackgroundTransparency = 1 }, 0.22, Enum.EasingStyle.Quad)
        Tween(stroke, { Transparency = 1 }, 0.12, Enum.EasingStyle.Quad)
        Tween(card, { GroupTransparency = 1 }, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        Tween(scale, { Scale = 0.95 }, 0.26)
        task.delay(0.34, function() layer:Destroy() end)
        if not silent then Fire("dialog", opts.Title or "dialog", opts.OnClose) end
    end
    dialog.Close = function(_, silent) close(silent) end

    for i, spec in ipairs(buttons) do
        if type(spec) == "string" then spec = { Name = spec } end
        local style = spec.Style or (i == n and n > 1 and "Accent") or (n == 1 and "Accent") or "Default"
        local btn = Create("TextButton", {
            Name = "Button_" .. tostring(spec.Name), LayoutOrder = i, ClipsDescendants = true,
            Size = stacked and UDim2.new(1, 0, 0, M.Field + 8) or UDim2.new(1 / n, -(8 * (n - 1)) / n, 1, 0), Parent = row,
        })
        self:Round(btn, 0.6)
        local press = Create("UIScale", { Scale = 1, Parent = btn })
        if style == "Accent" then
            AccentFill(self, btn, tostring(spec.Name or "OK"), M.Text)
            primary = primary or spec
        elseif style == "Danger" then
            btn.BackgroundTransparency = 0
            self:Bind(btn, { BackgroundColor3 = "Danger" })
            local label = Create("TextLabel", {
                Text = tostring(spec.Name or "OK"), Font = Enum.Font.GothamBold, TextSize = M.Text, Size = UDim2.fromScale(1, 1),
                TextColor3 = Color3.fromRGB(44, 10, 10), Fit = true, ZIndex = 3, Parent = btn,
            })
            primary = primary or spec
        else
            btn.BackgroundTransparency = 0
            self:Bind(btn, { BackgroundColor3 = "Elevated" })
            local btnStroke = self:Stroke(btn, "Stroke", 1, 0.1)
            local label = Create("TextLabel", {
                Text = tostring(spec.Name or "OK"), TextSize = M.Text, Size = UDim2.fromScale(1, 1), Fit = true, ZIndex = 3, Parent = btn,
            })
            self:Bind(label, { TextColor3 = "Text" })
            btn.MouseEnter:Connect(function()
                Tween(btn, { BackgroundColor3 = self.Theme.Hover }, 0.15)
                Tween(btnStroke, { Color = self.Theme.Accent }, 0.2)
            end)
            btn.MouseLeave:Connect(function()
                Tween(btn, { BackgroundColor3 = self.Theme.Elevated }, 0.2)
                Tween(btnStroke, { Color = self.Theme.Stroke }, 0.2)
            end)
        end
        btn.MouseButton1Down:Connect(function() Tween(press, { Scale = 0.96 }, 0.08) end)
        btn.MouseButton1Up:Connect(function() Tween(press, { Scale = 1 }, 0.22) end)
        btn.MouseLeave:Connect(function() Tween(press, { Scale = 1 }, 0.2) end)
        spec._Fire = function()
            Fire("dialog button", spec.Name, spec.Callback, box and box.Text or nil)
            if not spec.Keep then close(true) end
        end
        btn.Activated:Connect(spec._Fire)
    end

    if box then box.FocusLost:Connect(function(enter) if enter and primary and primary._Fire then primary._Fire() end end) end
    if dismissible then
        scrim.Activated:Connect(function() close() end)
    end
    dialog.Esc = self:Connect(UserInputService.InputBegan, function(input)
        if input.KeyCode == Enum.KeyCode.Escape and dismissible and self.DialogStack[#self.DialogStack] == dialog then close() end
    end)
    self.DialogStack[#self.DialogStack + 1] = dialog

    function dialog:SetContent(value) body.Text = tostring(value) end
    function dialog:GetInput() return box and box.Text or nil end

    Tween(scrim, { BackgroundTransparency = 0.5 }, 0.28, Enum.EasingStyle.Quad)
    Tween(card, { GroupTransparency = 0 }, 0.32, Enum.EasingStyle.Quint)
    Tween(stroke, { Transparency = 0.45 }, 0.4, Enum.EasingStyle.Quint)
    Tween(scale, { Scale = 1 }, 0.5, Enum.EasingStyle.Quint)
    if box then task.delay(0.2, function() if not dialog.Closed and box.Parent then pcall(function() box:CaptureFocus() end) end end) end
    return dialog
end

local Dropdown = {}
Dropdown.__index = Dropdown

local function Normalize(option)
    if type(option) == "table" then
        local text = option.Text or option.Name or tostring(option.Value)
        local value = option.Value
        if value == nil then value = text end
        return { Text = tostring(text), Value = value, Disabled = option.Disabled == true }
    end
    return { Text = tostring(option), Value = option, Disabled = false }
end

function Dropdown.new(root, parent, opts, clip)
    opts = opts or {}
    local self = setmetatable({}, Dropdown)
    local M, T = root.Metrics, root.Theme

    self.Root, self.Clip = root, clip
    self.Name = tostring(opts.Name or "Dropdown")
    self.Multi = opts.Multi == true
    self.Callback = opts.Callback
    self.Placeholder = opts.Placeholder or "Select..."
    self.MaxVisible = opts.MaxVisible or 5
    self.Max = opts.Max
    self.Search = opts.Search
    self.SearchThreshold = opts.SearchThreshold or 7
    if opts.AllowNone ~= nil then self.AllowNone = opts.AllowNone else self.AllowNone = self.Multi end
    self.Options, self.Selected, self.Items, self.Listeners = {}, {}, {}, {}
    self.IsOpen, self.Disabled, self.Tick = false, false, 0

    self.Row, self.Label = MakeRow(root, parent, self.Name, M.Row, opts.LayoutOrder)

    local field = Create("TextButton", {
        Name = "Field", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0.58, 0, 0, M.Field), BackgroundTransparency = 0, Parent = self.Row,
    })
    Create("UISizeConstraint", { MinSize = Vector2.new(116, 0), Parent = field })
    root:Bind(field, { BackgroundColor3 = "Elevated" })
    root:Round(field, 0.6)
    self.FieldStroke = root:Stroke(field, "Stroke", 1, 0.1)
    self.Field = field
    self.Rim = MakeRim(root, field, 0.6)

    self.ValueLabel = Create("TextLabel", {
        TextSize = M.Text - 1, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -32, 1, 0), Parent = field,
    })

    local chevron = Create("Frame", {
        Name = "Chevron", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(14, 14), Parent = field,
    })
    self.Chevron = chevron
    self.ChevronBars = { Bar(root, chevron, 4.6, 7, 7, 2, 45, "SubText"), Bar(root, chevron, 9.4, 7, 7, 2, -45, "SubText") }

    field.MouseEnter:Connect(function()
        if not self.Disabled then Tween(field, { BackgroundColor3 = root.Theme.Hover }, 0.15) end
    end)
    field.MouseLeave:Connect(function()
        Tween(field, { BackgroundColor3 = root.Theme.Elevated }, 0.2)
    end)
    field.MouseButton1Down:Connect(function()
        if not self.Disabled then Tween(field, { BackgroundColor3 = root.Theme.Hover }, 0.08) end
    end)
    field.Activated:Connect(function() self:Toggle() end)

    for _, option in ipairs(opts.Options or {}) do
        self.Options[#self.Options + 1] = Normalize(option)
    end
    if opts.Default ~= nil then self:Set(opts.Default, true) end
    self:_UpdateDisplay(true)
    Register(root, self, opts.Flag)
    if opts.Disabled then self:SetDisabled(true) end
    return self
end

function Dropdown:_Count()
    local n = 0
    for _ in pairs(self.Selected) do n = n + 1 end
    return n
end

function Dropdown:Get()
    if self.Multi then
        local out = {}
        for _, option in ipairs(self.Options) do
            if self.Selected[option.Value] then out[#out + 1] = option.Value end
        end
        return out
    end
    for _, option in ipairs(self.Options) do
        if self.Selected[option.Value] then return option.Value end
    end
    return nil
end

function Dropdown:Set(value, silent)
    local exists = {}
    for _, option in ipairs(self.Options) do exists[option.Value] = true end
    local selected = {}
    if self.Multi then
        if type(value) == "table" then
            for key, v in pairs(value) do
                if v == true and exists[key] then selected[key] = true
                elseif exists[v] then selected[v] = true end
            end
        elseif value ~= nil and exists[value] then
            selected[value] = true
        end
        if self.Max then
            local kept = 0
            for _, option in ipairs(self.Options) do
                if selected[option.Value] then
                    kept = kept + 1
                    if kept > self.Max then selected[option.Value] = nil end
                end
            end
        end
    elseif value ~= nil and exists[value] then
        selected[value] = true
    end
    self.Selected = selected
    self:_Commit(silent)
end

function Dropdown:Clear(silent)
    self.Selected = {}
    self:_Commit(silent)
end

function Dropdown:_Commit(silent)
    self:_UpdateDisplay()
    for _, rec in ipairs(self.Items) do self:_StyleItem(rec) end
    local value = self:Get()
    if self.Flag then Library.Flags[self.Flag] = value end
    if silent then return end
    Fire("callback", self.Name, self.Callback, value)
    for _, fn in ipairs(self.Listeners) do Fire("callback", self.Name, fn, value) end
end

function Dropdown:OnChanged(fn)
    self.Listeners[#self.Listeners + 1] = fn
    return function()
        for i, listener in ipairs(self.Listeners) do
            if listener == fn then table.remove(self.Listeners, i) break end
        end
    end
end

function Dropdown:_Pick(option)
    if option.Disabled then return end
    local value = option.Value
    if self.Multi then
        if self.Selected[value] then
            if not self.AllowNone and self:_Count() <= 1 then return end
            self.Selected[value] = nil
        else
            if self.Max and self:_Count() >= self.Max then
                self.Root:Notify({
                    Title = self.Name, Type = "Warning", Duration = 2.5,
                    Content = "You can select up to " .. self.Max .. " options.",
                })
                return
            end
            self.Selected[value] = true
        end
        self:_Commit()
    else
        if self.Selected[value] then
            if self.AllowNone then self.Selected = {} end
        else
            self.Selected = { [value] = true }
        end
        self:_Commit()
        self:Close()
    end
end

function Dropdown:_UpdateDisplay(instant)
    local T = self.Root.Theme
    local texts = {}
    for _, option in ipairs(self.Options) do
        if self.Selected[option.Value] then texts[#texts + 1] = option.Text end
    end
    local label
    if #texts == 0 then
        label = self.Placeholder
    elseif #texts <= 2 then
        label = table.concat(texts, ", ")
    else
        label = texts[1] .. ", " .. texts[2] .. "  +" .. (#texts - 2)
    end
    self.ValueLabel.Text = label
    Apply(self.ValueLabel, { TextColor3 = (#texts == 0) and T.Muted or T.Text }, instant, 0.2)
end

function Dropdown:Refresh(options, keepSelection)
    local before = self:_Count()
    self.Options = {}
    for _, option in ipairs(options or {}) do self.Options[#self.Options + 1] = Normalize(option) end

    local exists, keep = {}, {}
    for _, option in ipairs(self.Options) do exists[option.Value] = true end
    if keepSelection ~= false then
        for value in pairs(self.Selected) do
            if exists[value] then keep[value] = true end
        end
    end
    self.Selected = keep

    if self.Popup and self:_WantsSearch() ~= self.HasSearch then
        self:Close()
        self:_DestroyPopup()
    else
        self:_Render()
    end
    self:_Commit(before == self:_Count())
end

function Dropdown:Add(option)
    local list = {}
    for _, o in ipairs(self.Options) do list[#list + 1] = o end
    list[#list + 1] = option
    self:Refresh(list, true)
end

function Dropdown:Remove(value)
    local list = {}
    for _, o in ipairs(self.Options) do
        if o.Value ~= value then list[#list + 1] = o end
    end
    self:Refresh(list, true)
end

function Dropdown:SetName(name)
    self.Name = tostring(name)
    self.Label.Text = self.Name
end

function Dropdown:SetVisible(state) self.Row.Visible = state end

function Dropdown:SetDisabled(state)
    self.Disabled = state
    if state then self:Close() end
    self.Field.Active = not state
    Tween(self.Field, { BackgroundTransparency = state and 0.5 or 0 }, 0.2)
    Tween(self.Label, { TextTransparency = state and 0.55 or 0 }, 0.2)
    Tween(self.ValueLabel, { TextTransparency = state and 0.55 or 0 }, 0.2)
end

function Dropdown:_WantsSearch()
    if self.Search ~= nil then return self.Search == true end
    return #self.Options > self.SearchThreshold
end

function Dropdown:_Top()
    if self.HasSearch then return self.Root.Metrics.Item + 12 end
    return 0
end

function Dropdown:_ListHeight()
    local M = self.Root.Metrics
    local n = self.Shown or #self.Options
    local rows = math.max(1, math.min(n, self.MaxVisible))
    return rows * (M.Item + 2) - 2 + 10
end

function Dropdown:_BuildPopup()
    if self.Popup then return end
    local root, M = self.Root, self.Root.Metrics
    self.HasSearch = self:_WantsSearch()

    local holder = Create("Frame", {
        Name = "VelorDropdown", BackgroundTransparency = 1, Visible = false,
        Size = UDim2.fromOffset(200, 0), Parent = root.Overlay,
    })
    self.Holder = holder
    self.Shadow = root:Shadow(holder, 1, 20)

    local popup = Create("CanvasGroup", {
        Name = "Popup", Size = UDim2.fromScale(1, 1), GroupTransparency = 1, ZIndex = 1, Parent = holder,
    })
    root:Bind(popup, { BackgroundColor3 = "Surface" })
    popup.BackgroundTransparency = root.Alpha.Popup
    root:Round(popup, 0.75)
    self.Popup = popup

    local border = Create("Frame", {
        Name = "Border", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 3, Parent = holder,
    })
    root:Round(border, 0.75)
    self.BorderStroke = root:Stroke(border, "Stroke", 1, 1)
    self.Border = border

    local content = Create("Frame", {
        Name = "Content", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 100), Parent = popup,
    })
    self.Content = content

    if self.HasSearch then
        local box = Create("Frame", {
            Name = "SearchBox", Position = UDim2.fromOffset(6, 6), Size = UDim2.new(1, -12, 0, M.Item), Parent = content,
        })
        root:Bind(box, { BackgroundColor3 = "Elevated" })
        root:Round(box, 0.55)
        root:Stroke(box, "Stroke", 1, 0.2)
        local input = Create("TextBox", {
            Name = "Input", PlaceholderText = "Search...", TextSize = M.Text - 1,
            TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(10, 0),
            Size = UDim2.new(1, -20, 1, 0), Parent = box,
        })
        root:Bind(input, { TextColor3 = "Text", PlaceholderColor3 = "Muted" })
        input:GetPropertyChangedSignal("Text"):Connect(function() self:_Filter(input.Text) end)
        self.SearchBox = input
    end

    local list = Create("ScrollingFrame", {
        Name = "List", CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 2, ScrollingDirection = Enum.ScrollingDirection.Y, Parent = content,
    })
    root:Bind(list, { ScrollBarImageColor3 = "Muted" })
    Create("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = list })
    Pad(list, 5, 5, 5, 5)
    self.List = list

    self.Empty = Create("TextLabel", {
        Text = "No results", TextSize = M.Text - 1, LayoutOrder = 1000000, Visible = false,
        Size = UDim2.new(1, 0, 0, M.Item), Parent = list,
    })
    root:Bind(self.Empty, { TextColor3 = "Muted" })

    self:_Render()
end

function Dropdown:_DestroyPopup()
    if self.Holder then self.Holder:Destroy() end
    self.Holder, self.Popup, self.Content, self.List, self.SearchBox, self.Empty = nil, nil, nil, nil, nil, nil
    self.Shadow, self.Border, self.BorderStroke = nil, nil, nil
    self.Items, self.Shown = {}, nil
end

function Dropdown:_Render()
    if not self.List then return end
    local root, M, T = self.Root, self.Root.Metrics, self.Root.Theme

    for _, rec in ipairs(self.Items) do rec.Button:Destroy() end
    self.Items = {}

    for i, option in ipairs(self.Options) do
        local rec = { Opt = option, Hover = false }
        local button = Create("TextButton", {
            Name = "Item", BackgroundColor3 = T.Hover, BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, M.Item), LayoutOrder = i, Parent = self.List,
        })
        root:Round(button, 0.55)
        rec.Button = button

        rec.Fill = Create("Frame", {
            Name = "Fill", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1),
            BackgroundTransparency = 1, Parent = button,
        })
        root:Round(rec.Fill, 0.55)
        local _, fillAnim = root:Gradient(rec.Fill, "Soft", {
            Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.74), NumberSequenceKeypoint.new(1, 0.9) }),
        }, { Sweep = 1.4, Range = 0.5, Phase = i * 0.6, On = false })
        rec.FillAnim = fillAnim

        rec.Bar = Create("Frame", {
            Name = "Bar", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0),
            Size = UDim2.fromOffset(3, 0), BackgroundColor3 = Color3.new(1, 1, 1), Parent = button,
        }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
        root:Gradient(rec.Bar, "Soft", { Rotation = 90 })

        rec.Text = Create("TextLabel", {
            Text = option.Text, TextSize = M.Text - 1, TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(12, 0),
            Size = UDim2.new(1, -42, 1, 0), Parent = button,
        })

        local mark = Create("Frame", {
            Name = "Mark", BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -9, 0.5, 0), Size = UDim2.fromOffset(18, 18), Parent = button,
        })
        if self.Multi then
            rec.Box = Create("Frame", {
                Name = "Box", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1),
                BackgroundTransparency = 1, Parent = mark,
            })
            root:Round(rec.Box, 0.35)
            root:Gradient(rec.Box, "Soft", { Rotation = 45 })
            rec.BoxStroke = Create("UIStroke", {
                Color = T.Stroke, Thickness = 1.5, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = rec.Box,
            })
        end
        local tickA = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(6, 10.75),
            Size = UDim2.fromOffset(4.5, 2), Rotation = 45, BackgroundTransparency = 1, ZIndex = 2, Parent = mark,
        }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
        local tickB = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromOffset(10.5, 9.25),
            Size = UDim2.fromOffset(8.5, 2), Rotation = -45, BackgroundTransparency = 1, ZIndex = 2, Parent = mark,
        }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
        rec.Ticks = { tickA, tickB }

        button.MouseEnter:Connect(function() rec.Hover = true; self:_StyleItem(rec) end)
        button.MouseLeave:Connect(function() rec.Hover = false; self:_StyleItem(rec) end)
        button.Activated:Connect(function() self:_Pick(option) end)

        self.Items[i] = rec
        self:_StyleItem(rec, true)
    end

    self:_Filter(self.SearchBox and self.SearchBox.Text or "")
end

function Dropdown:_StyleItem(rec, instant)
    local root, M, T = self.Root, self.Root.Metrics, self.Root.Theme
    local selected = self.Selected[rec.Opt.Value] == true
    local hovered = rec.Hover and not rec.Opt.Disabled

    local textColor = T.SubText
    if rec.Opt.Disabled then textColor = T.Muted
    elseif selected or hovered then textColor = T.Text end

    Apply(rec.Button, {
        BackgroundColor3 = T.Hover, BackgroundTransparency = hovered and (selected and 0.55 or 0) or 1,
    }, instant, 0.18)
    Apply(rec.Fill, { BackgroundTransparency = selected and 0 or 1 }, instant, 0.22)
    rec.FillAnim.On = selected
    Apply(rec.Text, { TextColor3 = textColor }, instant, 0.18)
    Apply(rec.Bar, {
        Size = UDim2.fromOffset(3, (selected and not self.Multi) and math.floor(M.Item * 0.5) or 0),
    }, instant, 0.25)

    local tickColor = self.Multi and T.OnAccent or T.Accent
    for _, tick in ipairs(rec.Ticks) do
        Apply(tick, { BackgroundTransparency = selected and 0 or 1, BackgroundColor3 = tickColor }, instant, 0.18)
    end
    if rec.Box then
        Apply(rec.Box, { BackgroundTransparency = selected and 0 or 1 }, instant, 0.18)
        Apply(rec.BoxStroke, { Color = selected and T.Accent or T.Stroke }, instant, 0.18)
    end
end

function Dropdown:_Filter(query)
    if not self.List then return end
    query = (query or ""):lower()
    local shown = 0
    for _, rec in ipairs(self.Items) do
        local visible = query == "" or rec.Opt.Text:lower():find(query, 1, true) ~= nil
        rec.Button.Visible = visible
        if visible then shown = shown + 1 end
    end
    self.Shown = shown
    self.Empty.Text = (#self.Options == 0) and "No options" or "No results"
    self.Empty.Visible = shown == 0
    self:_Layout(true)
end

function Dropdown:_Layout(animate)
    if not self.Popup then return end
    local top = self:_Top()
    local wanted = top + self:_ListHeight()
    local height = math.max(top + 36, math.min(wanted, self.MaxH or wanted))
    self.TargetH = height
    self.Content.Size = UDim2.new(1, 0, 0, height)
    self.List.Position = UDim2.fromOffset(0, top)
    self.List.Size = UDim2.new(1, 0, 0, height - top)
    if self.IsOpen then
        Apply(self.Holder, { Size = UDim2.fromOffset(self.PopupWidth, height) }, not animate, 0.34)
    end
end

function Dropdown:_Restyle(instant)
    self:_UpdateDisplay(instant)
    for _, rec in ipairs(self.Items) do self:_StyleItem(rec, instant) end
    local T = self.Root.Theme
    for _, bar in ipairs(self.ChevronBars) do
        Apply(bar, { BackgroundColor3 = self.IsOpen and T.Accent or T.SubText }, instant, 0.25)
    end
end

function Dropdown:_UpdatePosition()
    local field = self.Field
    if not field.Parent or not self.Holder then return self:Close() end
    local pos, size = field.AbsolutePosition, field.AbsoluteSize
    local viewport = self.Root.Gui.AbsoluteSize
    local x = math.clamp(pos.X + size.X - self.PopupWidth, 8, math.max(8, viewport.X - self.PopupWidth - 8))
    local y = self.Flip and (pos.Y - 5) or (pos.Y + size.Y + 5)
    self.Holder.Position = UDim2.fromOffset(x, y)

    if self.Clip then
        local clipPos, clipSize = self.Clip.AbsolutePosition, self.Clip.AbsoluteSize
        local centerY = pos.Y + size.Y / 2
        if centerY < clipPos.Y or centerY > clipPos.Y + clipSize.Y then self:Close() end
    end
end

function Dropdown:Open()
    if self.IsOpen or self.Disabled then return end
    local root = self.Root
    root:CloseDropdown()
    self:_BuildPopup()

    self.Tick = self.Tick + 1
    self.IsOpen = true
    root.OpenDropdown = self
    root.Catcher.Visible = true

    local pos, size = self.Field.AbsolutePosition, self.Field.AbsoluteSize
    local viewport = root.Gui.AbsoluteSize
    self.PopupWidth = math.min(math.max(size.X, 170), viewport.X - 16)

    local below = viewport.Y - (pos.Y + size.Y) - 16
    local above = pos.Y - 16
    local natural = self:_Top() + self:_ListHeight()
    self.Flip = natural > below and above > below
    self.MaxH = math.max(100, self.Flip and above or below)

    local anchorY = self.Flip and 1 or 0
    self.Holder.AnchorPoint = Vector2.new(0, anchorY)
    self.Content.AnchorPoint = Vector2.new(0, anchorY)
    self.Content.Position = UDim2.new(0, 0, anchorY, 0)
    self.Holder.Size = UDim2.fromOffset(self.PopupWidth, 0)
    self.Holder.Visible = true

    self:_Layout(true)
    self:_UpdatePosition()
    self.PosConn = RunService.RenderStepped:Connect(function() self:_UpdatePosition() end)

    Tween(self.Popup, { GroupTransparency = 0 }, 0.26)
    Tween(self.Shadow, { ImageTransparency = 0.55 }, 0.38)
    Tween(self.BorderStroke, { Transparency = 0.05 }, 0.25)
    Tween(self.Chevron, { Rotation = 180 }, 0.4)
    self.Rim.Set(true)
    for _, bar in ipairs(self.ChevronBars) do Tween(bar, { BackgroundColor3 = root.Theme.Accent }, 0.25) end

    if self.SearchBox and not root.Mobile then
        task.defer(function()
            if self.IsOpen and self.SearchBox then self.SearchBox:CaptureFocus() end
        end)
    end
end

function Dropdown:Close()
    if not self.IsOpen then return end
    local root, T = self.Root, self.Root.Theme
    self.IsOpen = false
    self.Tick = self.Tick + 1
    local tick = self.Tick

    if root.OpenDropdown == self then
        root.OpenDropdown = nil
        root.Catcher.Visible = false
    end
    if self.PosConn then self.PosConn:Disconnect() self.PosConn = nil end
    if self.SearchBox then
        self.SearchBox:ReleaseFocus()
        self.SearchBox.Text = ""
    end

    if self.Holder then
            Tween(self.Holder, { Size = UDim2.fromOffset(self.PopupWidth, 0) }, 0.26, Motion.In, Enum.EasingDirection.In)
        Tween(self.Popup, { GroupTransparency = 1 }, 0.22, Motion.Smooth)
        Tween(self.Shadow, { ImageTransparency = 1 }, 0.2)
        Tween(self.BorderStroke, { Transparency = 1 }, 0.18)
        task.delay(0.28, function()
            if self.Tick == tick and self.Holder then self.Holder.Visible = false end
        end)
    end
    Tween(self.Chevron, { Rotation = 0 }, 0.4)
    self.Rim.Set(false)
    for _, bar in ipairs(self.ChevronBars) do Tween(bar, { BackgroundColor3 = T.SubText }, 0.25) end
end

function Dropdown:Toggle()
    if self.IsOpen then self:Close() else self:Open() end
end

function Dropdown:_Cleanup()
    if self.PosConn then self.PosConn:Disconnect() self.PosConn = nil end
end

function Dropdown:Destroy()
    self:Close()
    self:_Cleanup()
    Unregister(self.Root, self)
    if self.Holder then self.Holder:Destroy() end
    self.Row:Destroy()
end

local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(root, parent, opts)
    opts = opts or {}
    local self = setmetatable({}, Toggle)
    local M, T = root.Metrics, root.Theme
    self.Root = root
    self.Name = tostring(opts.Name or "Toggle")
    self.Callback = opts.Callback
    self.Value = opts.Default == true
    self.Listeners, self.Disabled = {}, false

    self.Row, self.Label = MakeRow(root, parent, self.Name, M.Row, opts.LayoutOrder, 0.72)

    local w, h = (root.Mobile and 44 or 36), (root.Mobile and 24 or 20)
    self.W, self.H = w, h
    local track = Create("Frame", {
        Name = "Track", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -1, 0.5, 0),
        Size = UDim2.fromOffset(w, h), Parent = self.Row,
    })
    root:Bind(track, { BackgroundColor3 = "Elevated" })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = track })
    self.TrackStroke = root:Stroke(track, "Stroke", 1, 0.1)

    self.OnFill = Create("Frame", {
        Name = "On", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1, Parent = track,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    local _, anim = root:Gradient(self.OnFill, "Flow", nil, { Sweep = 1.6, Range = 0.6, On = false })
    self.Anim = anim

    local k = h - 6
    self.K = k
    self.Knob = Create("Frame", {
        Name = "Knob", AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.fromOffset(k, k),
        Position = UDim2.new(0, 3, 0.5, 0), BackgroundColor3 = T.SubText, ZIndex = 2, Parent = track,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })

    local hit = Create("TextButton", { Size = UDim2.fromScale(1, 1), ZIndex = 5, Parent = self.Row })
    self.Hit = hit
    hit.MouseEnter:Connect(function()
        if not self.Disabled then Tween(self.TrackStroke, { Color = root.Theme.Accent }, 0.2) end
    end)
    hit.MouseLeave:Connect(function()
        Tween(self.Knob, { Size = UDim2.fromOffset(self.K, self.K) }, 0.15)
        Tween(self.TrackStroke, { Color = root.Theme.Stroke }, 0.2)
    end)
    hit.MouseButton1Down:Connect(function()
        if not self.Disabled then Tween(self.Knob, { Size = UDim2.fromOffset(self.K + 4, self.K) }, 0.1) end
    end)
    hit.MouseButton1Up:Connect(function()
        Tween(self.Knob, { Size = UDim2.fromOffset(self.K, self.K) }, 0.15)
    end)
    hit.Activated:Connect(function()
        if not self.Disabled then self:Set(not self.Value) end
    end)

    self:_Paint(true)
    Register(root, self, opts.Flag)
    if opts.Disabled then self:SetDisabled(true) end
    return self
end

function Toggle:_Paint(instant)
    local T = self.Root.Theme
    local on = self.Value
    local x = on and (self.W - self.K - 3) or 3
    Apply(self.Knob, {
        Position = UDim2.new(0, x, 0.5, 0), BackgroundColor3 = on and Color3.new(1, 1, 1) or T.SubText,
    }, instant, 0.3, Enum.EasingStyle.Back)
    Apply(self.OnFill, { BackgroundTransparency = on and 0 or 1 }, instant, 0.25)
    self.Anim.On = on
end

function Toggle:_Restyle(instant) self:_Paint(instant) end

function Toggle:Get() return self.Value end

function Toggle:Set(value, silent)
    value = value == true
    if value == self.Value then return end
    self.Value = value
    self:_Paint()
    if self.Flag then Library.Flags[self.Flag] = value end
    if silent then return end
    Fire("callback", self.Name, self.Callback, value)
    for _, fn in ipairs(self.Listeners) do Fire("callback", self.Name, fn, value) end
end

function Toggle:Toggle() self:Set(not self.Value) end

function Toggle:OnChanged(fn)
    self.Listeners[#self.Listeners + 1] = fn
    return function()
        for i, listener in ipairs(self.Listeners) do
            if listener == fn then table.remove(self.Listeners, i) break end
        end
    end
end

function Toggle:SetName(name) self.Name = tostring(name); self.Label.Text = self.Name end
function Toggle:SetVisible(state) self.Row.Visible = state end
function Toggle:SetDisabled(state)
    self.Disabled = state
    Tween(self.Label, { TextTransparency = state and 0.55 or 0 }, 0.2)
    Tween(self.Knob, { BackgroundTransparency = state and 0.5 or 0 }, 0.2)
end
function Toggle:Destroy() Unregister(self.Root, self); self.Row:Destroy() end

local Slider = {}
Slider.__index = Slider

function Slider.new(root, parent, opts, scroll)
    opts = opts or {}
    local self = setmetatable({}, Slider)
    local M, T = root.Metrics, root.Theme
    self.Root, self.Scroll = root, scroll
    self.Name = tostring(opts.Name or "Slider")
    self.Callback = opts.Callback
    self.Min, self.Max = opts.Min or 0, opts.Max or 100
    if self.Max <= self.Min then self.Max = self.Min + 1 end
    self.Step = opts.Step or opts.Increment or 1
    if self.Step <= 0 then self.Step = 1 end
    self.Suffix = opts.Suffix or ""
    self.Digits = Decimals(self.Step)
    self.Listeners, self.Disabled, self.Dragging = {}, false, false

    local height = M.Row + (root.Mobile and 20 or 16)
    self.Row = Create("Frame", {
        Name = "Row_" .. self.Name, BackgroundTransparency = 1, LayoutOrder = opts.LayoutOrder or 0,
        Size = UDim2.new(1, 0, 0, height), Parent = parent,
    })
    self.Label = Create("TextLabel", {
        Text = self.Name, TextSize = M.Text, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(2, 2), Size = UDim2.new(0.62, -8, 0, 20),
        Parent = self.Row,
        Grow = function(h)
            local lh = h and math.max(20, h + 2) or 20
            if self.Label.Size.Y.Offset ~= lh then
                self.Label.Size = UDim2.new(0.62, -8, 0, lh)
                self.Row.Size = UDim2.new(1, 0, 0, height + lh - 20)
            end
        end,
    })
    root:Bind(self.Label, { TextColor3 = "Text" })
    self.ValueLabel = Create("TextLabel", {
        Font = Enum.Font.GothamBold, TextSize = M.Text - 1, TextXAlignment = Enum.TextXAlignment.Right,
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -2, 0, 2), Size = UDim2.new(0.38, 0, 0, 20),
        Parent = self.Row,
    })
    root:Bind(self.ValueLabel, { TextColor3 = "SubText" })

    local hitHeight = root.Mobile and 28 or 20
    local hit = Create("TextButton", {
        Name = "Hit", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, -2),
        Size = UDim2.new(1, 0, 0, hitHeight), Parent = self.Row,
    })
    self.Hit = hit
    local track = Create("Frame", {
        Name = "Track", AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 2, 0.5, 0),
        Size = UDim2.new(1, -4, 0, 5), Parent = hit,
    })
    root:Bind(track, { BackgroundColor3 = "Elevated" })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = track })
    root:Stroke(track, "Stroke", 1, 0.4)
    self.Track = track

    self.Ticks = {}
    local steps = math.floor((self.Max - self.Min) / self.Step + 0.5)
    if opts.Ticks == true or (opts.Ticks ~= false and steps >= 2 and steps <= 20) then
        for i = 0, steps do
            local alpha = i * self.Step / (self.Max - self.Min)
            local tick = Create("Frame", {
                Name = "Tick", AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(alpha, 0, 1, 4),
                Size = UDim2.fromOffset(1, (i == 0 or i == steps) and 4 or 3), BackgroundTransparency = 0.5, Parent = track,
            })
            root:Bind(tick, { BackgroundColor3 = "Muted" })
            self.Ticks[#self.Ticks + 1] = { Frame = tick, Alpha = alpha, On = false }
        end
    end

    self.Fill = Create("Frame", {
        Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Color3.new(1, 1, 1), Parent = track,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    root:Gradient(self.Fill, "Flow", nil, { Sweep = 1.3, Range = 0.5 })

    self.Knob = Create("Frame", {
        Name = "Knob", AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5),
        Size = UDim2.fromOffset(12, 12), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 2, Parent = track,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    self.KnobStroke = Create("UIStroke", { Thickness = 2, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = self.Knob })
    root:Bind(self.KnobStroke, { Color = "Accent" })

    local function fromInput(position)
        local alpha = math.clamp((position.X - track.AbsolutePosition.X) / math.max(1, track.AbsoluteSize.X), 0, 1)
        self:Set(self.Min + alpha * (self.Max - self.Min), false, true)
    end
    hit.InputBegan:Connect(function(input)
        if self.Disabled or not IsPointerDown(input) then return end
        self.Dragging = true
        if self.Scroll then self.Scroll.ScrollingEnabled = false end
        Tween(self.Knob, { Size = UDim2.fromOffset(16, 16) }, 0.12)
        fromInput(input.Position)
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                connection:Disconnect()
                self.Dragging = false
                if self.Scroll then self.Scroll.ScrollingEnabled = true end
                Tween(self.Knob, { Size = UDim2.fromOffset(12, 12) }, 0.15)
            end
        end)
    end)
    self.MoveConn = UserInputService.InputChanged:Connect(function(input)
        if self.Dragging and IsPointerMove(input) then fromInput(input.Position) end
    end)

    local default = opts.Default
    if default == nil then default = self.Min end
    self.Value = self:_Snap(default)
    self:_Paint(true)
    Register(root, self, opts.Flag)
    if opts.Disabled then self:SetDisabled(true) end
    return self
end

function Slider:_Snap(value)
    local snapped = self.Min + math.floor((value - self.Min) / self.Step + 0.5) * self.Step
    snapped = math.clamp(snapped, self.Min, self.Max)
    return tonumber(string.format("%." .. self.Digits .. "f", snapped))
end

function Slider:_Paint(instant, quick)
    local alpha = (self.Value - self.Min) / (self.Max - self.Min)
    self.ValueLabel.Text = string.format("%." .. self.Digits .. "f", self.Value) .. self.Suffix

    local time = quick and 0.12 or 0.25
    Apply(self.Fill, { Size = UDim2.new(alpha, 0, 1, 0) }, instant, time)
    Apply(self.Knob, { Position = UDim2.new(alpha, 0, 0.5, 0) }, instant, time)
    for _, t in ipairs(self.Ticks) do
        local on = t.Alpha <= alpha + 1e-6
        if on ~= t.On then
            t.On = on
            Apply(t.Frame, { BackgroundColor3 = on and self.Root.Theme.Accent or self.Root.Theme.Muted, BackgroundTransparency = on and 0.1 or 0.5 }, instant, 0.18)
        end
    end
end

function Slider:_Restyle()
    for _, t in ipairs(self.Ticks) do
        t.Frame.BackgroundColor3 = t.On and self.Root.Theme.Accent or self.Root.Theme.Muted
    end
end

function Slider:Get() return self.Value end

function Slider:Set(value, silent, quick)
    if type(value) ~= "number" then return end
    value = self:_Snap(value)
    if value == self.Value then return end
    self.Value = value
    self:_Paint(false, quick)
    if self.Flag then Library.Flags[self.Flag] = value end
    if silent then return end
    Fire("callback", self.Name, self.Callback, value)
    for _, fn in ipairs(self.Listeners) do Fire("callback", self.Name, fn, value) end
end

function Slider:OnChanged(fn)
    self.Listeners[#self.Listeners + 1] = fn
    return function()
        for i, listener in ipairs(self.Listeners) do
            if listener == fn then table.remove(self.Listeners, i) break end
        end
    end
end

function Slider:SetName(name) self.Name = tostring(name); self.Label.Text = self.Name end
function Slider:SetVisible(state) self.Row.Visible = state end
function Slider:SetDisabled(state)
    self.Disabled = state
    Tween(self.Label, { TextTransparency = state and 0.55 or 0 }, 0.2)
    Tween(self.ValueLabel, { TextTransparency = state and 0.55 or 0 }, 0.2)
    Tween(self.Fill, { BackgroundTransparency = state and 0.6 or 0 }, 0.2)
end
function Slider:_Cleanup() if self.MoveConn then self.MoveConn:Disconnect() self.MoveConn = nil end end
function Slider:Destroy() self:_Cleanup(); Unregister(self.Root, self); self.Row:Destroy() end

local Input = {}
Input.__index = Input

function Input.new(root, parent, opts)
    opts = opts or {}
    local self = setmetatable({}, Input)
    local M = root.Metrics
    self.Root = root
    self.Name = tostring(opts.Name or "Input")
    self.Callback = opts.Callback
    self.Numeric = opts.Numeric == true
    self.Listeners, self.Disabled = {}, false
    self.Value = tostring(opts.Default or "")

    self.Row, self.Label = MakeRow(root, parent, self.Name, M.Row, opts.LayoutOrder)

    local field = Create("Frame", {
        Name = "Field", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0.58, 0, 0, M.Field), Parent = self.Row,
    })
    Create("UISizeConstraint", { MinSize = Vector2.new(116, 0), Parent = field })
    root:Bind(field, { BackgroundColor3 = "Elevated" })
    root:Round(field, 0.6)
    root:Stroke(field, "Stroke", 1, 0.1)
    self.Field = field
    self.Rim = MakeRim(root, field, 0.6)

    local box = Create("TextBox", {
        Name = "Box", PlaceholderText = opts.Placeholder or "Type here...", Text = self.Value, TextSize = M.Text - 1,
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        ClearTextOnFocus = false, Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -20, 1, 0), Parent = field,
    })
    root:Bind(box, { TextColor3 = "Text", PlaceholderColor3 = "Muted" })
    self.Box = box

    box:GetPropertyChangedSignal("Text"):Connect(function()
        if self.Numeric then
            local cleaned = box.Text:gsub("[^%d%.%-]", "")
            if cleaned ~= box.Text then box.Text = cleaned end
        end
    end)
    box.Focused:Connect(function()
        if self.Disabled then box:ReleaseFocus() return end
        self.Rim.Set(true)
    end)
    box.FocusLost:Connect(function(enter)
        self.Rim.Set(false)
        self:_Commit(box.Text, enter)
    end)

    Register(root, self, opts.Flag)
    if opts.Disabled then self:SetDisabled(true) end
    return self
end

function Input:_Commit(text, enter, silent)
    if self.Numeric and text ~= "" and tonumber(text) == nil then text = self.Value end
    self.Box.Text = text
    if text == self.Value and not enter then return end
    self.Value = text
    if self.Flag then Library.Flags[self.Flag] = self:Get() end
    if silent then return end
    Fire("callback", self.Name, self.Callback, self:Get(), enter)
    for _, fn in ipairs(self.Listeners) do Fire("callback", self.Name, fn, self:Get()) end
end

function Input:Get()
    if self.Numeric then return tonumber(self.Value) end
    return self.Value
end

function Input:Set(value, silent)
    self:_Commit(value == nil and "" or tostring(value), false, silent)
end

function Input:OnChanged(fn)
    self.Listeners[#self.Listeners + 1] = fn
    return function()
        for i, listener in ipairs(self.Listeners) do
            if listener == fn then table.remove(self.Listeners, i) break end
        end
    end
end

function Input:SetName(name) self.Name = tostring(name); self.Label.Text = self.Name end
function Input:SetVisible(state) self.Row.Visible = state end
function Input:SetDisabled(state)
    self.Disabled = state
    Tween(self.Label, { TextTransparency = state and 0.55 or 0 }, 0.2)
    Tween(self.Box, { TextTransparency = state and 0.55 or 0 }, 0.2)
end
function Input:Destroy() Unregister(self.Root, self); self.Row:Destroy() end

local Keybind = {}
Keybind.__index = Keybind

local function KeyName(key)
    return key and key.Name or "None"
end

function Keybind.new(root, parent, opts)
    opts = opts or {}
    local self = setmetatable({}, Keybind)
    local M = root.Metrics
    self.Root = root
    self.Name = tostring(opts.Name or "Keybind")
    self.Callback = opts.Callback
    self.OnPress = opts.OnPress
    self.Listeners, self.Disabled, self.Listening = {}, false, false
    self.Key = nil

    self.Row, self.Label = MakeRow(root, parent, self.Name, M.Row, opts.LayoutOrder)

    local field = Create("TextButton", {
        Name = "Field", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0, root.Mobile and 112 or 100, 0, M.Field), BackgroundTransparency = 0,
        TextSize = M.Text - 1, Parent = self.Row,
    })
    root:Bind(field, { BackgroundColor3 = "Elevated", TextColor3 = "Text" })
    root:Round(field, 0.6)
    root:Stroke(field, "Stroke", 1, 0.1)
    self.Field = field
    self.Rim = MakeRim(root, field, 0.6)

    field.MouseEnter:Connect(function()
        if not self.Disabled then Tween(field, { BackgroundColor3 = root.Theme.Hover }, 0.15) end
    end)
    field.MouseLeave:Connect(function() Tween(field, { BackgroundColor3 = root.Theme.Elevated }, 0.2) end)
    field.Activated:Connect(function()
        if self.Disabled then return end
        self:_Listen(not self.Listening)
    end)

    self.InputConn = root:Connect(UserInputService.InputBegan, function(input, processed)
        if self.Listening then
            if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
            if input.KeyCode == Enum.KeyCode.Escape then
                self:_Listen(false)
            elseif input.KeyCode == Enum.KeyCode.Backspace then
                self:Set(nil)
                self:_Listen(false)
            else
                self:Set(input.KeyCode)
                self:_Listen(false)
            end
        elseif not processed and self.Key and input.KeyCode == self.Key then
            Fire("press", self.Name, self.OnPress, self.Key)
        end
    end)

    local default = opts.Default
    if type(default) == "string" then default = Enum.KeyCode[default] end
    self.Key = default
    self:_Paint()
    Register(root, self, opts.Flag)
    if opts.Disabled then self:SetDisabled(true) end
    return self
end

function Keybind:_Listen(state)
    self.Listening = state
    self.Rim.Set(state)
    self:_Paint()
end

function Keybind:_Paint()
    self.Field.Text = self.Listening and "Press a key..." or KeyName(self.Key)
    Tween(self.Field, { TextTransparency = (not self.Listening and not self.Key) and 0.45 or 0 }, 0.15)
end

function Keybind:_Restyle() end

function Keybind:Get() return self.Key end

function Keybind:Set(key, silent)
    if type(key) == "string" then key = Enum.KeyCode[key] end
    self.Key = key
    self:_Paint()
    if self.Flag then Library.Flags[self.Flag] = key and key.Name or nil end
    if silent then return end
    Fire("callback", self.Name, self.Callback, key)
    for _, fn in ipairs(self.Listeners) do Fire("callback", self.Name, fn, key) end
end

function Keybind:Save() return self.Key and self.Key.Name or nil end
function Keybind:Load(value) self:Set(value) end

function Keybind:OnChanged(fn)
    self.Listeners[#self.Listeners + 1] = fn
    return function()
        for i, listener in ipairs(self.Listeners) do
            if listener == fn then table.remove(self.Listeners, i) break end
        end
    end
end

function Keybind:SetName(name) self.Name = tostring(name); self.Label.Text = self.Name end
function Keybind:SetVisible(state) self.Row.Visible = state end
function Keybind:SetDisabled(state)
    self.Disabled = state
    if state then self:_Listen(false) end
    Tween(self.Label, { TextTransparency = state and 0.55 or 0 }, 0.2)
end
function Keybind:_Cleanup() if self.InputConn then self.InputConn:Disconnect() self.InputConn = nil end end
function Keybind:Destroy() self:_Cleanup(); Unregister(self.Root, self); self.Row:Destroy() end

local ColorPicker = {}
ColorPicker.__index = ColorPicker

local function ToHex(c)
    return string.format("#%02X%02X%02X", math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
end

local function FromHex(text)
    text = tostring(text):gsub("#", "")
    if #text ~= 6 then return nil end
    local r, g, b = tonumber(text:sub(1, 2), 16), tonumber(text:sub(3, 4), 16), tonumber(text:sub(5, 6), 16)
    if not (r and g and b) then return nil end
    return Color3.fromRGB(r, g, b)
end

function ColorPicker.new(root, parent, opts, scroll)
    opts = opts or {}
    local self = setmetatable({}, ColorPicker)
    local M = root.Metrics
    self.Root, self.Scroll = root, scroll
    self.Name = tostring(opts.Name or "Color")
    self.Callback = opts.Callback
    self.Listeners, self.Disabled, self.Expanded = {}, false, false
    self.PickerH = root.Mobile and 136 or 120

    self.Holder = Create("Frame", {
        Name = "ColorPicker", BackgroundTransparency = 1, ClipsDescendants = true, LayoutOrder = opts.LayoutOrder or 0,
        Size = UDim2.new(1, 0, 0, M.Row), Parent = parent,
    })
    self.Row, self.Label = MakeRow(root, self.Holder, self.Name, M.Row, 0, 0.5)

    local swatchW = root.Mobile and 46 or 40
    local swatch = Create("TextButton", {
        Name = "Swatch", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.fromOffset(swatchW, M.Field - 4), BackgroundTransparency = 0, ZIndex = 2, Parent = self.Row,
    })
    root:Round(swatch, 0.6)
    self.SwatchStroke = root:Stroke(swatch, "Stroke", 1, 0.1)
    self.Swatch = swatch
    self.HexLabel = Create("TextLabel", {
        Font = Enum.Font.Code, TextSize = M.Text - 2, TextXAlignment = Enum.TextXAlignment.Right,
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -(swatchW + 8), 0.5, 0),
        Size = UDim2.fromOffset(62, M.Row), Parent = self.Row,
    })
    root:Bind(self.HexLabel, { TextColor3 = "SubText" })

    local area = Create("Frame", {
        Name = "Area", BackgroundTransparency = 1, Position = UDim2.fromOffset(0, M.Row + 2),
        Size = UDim2.new(1, 0, 0, self.PickerH - 8), Parent = self.Holder,
    })
    local sv = Create("TextButton", { Name = "SV", Size = UDim2.new(1, 0, 1, -20), BackgroundTransparency = 0, Parent = area })
    root:Round(sv, 0.6)
    root:Stroke(sv, "Stroke", 1, 0.2)
    local white = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 2, Parent = sv }, {
        Create("UIGradient", { Transparency = NumberSequence.new(0, 1) }),
    })
    root:Round(white, 0.6)
    local black = Create("Frame", { Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0), ZIndex = 3, Parent = sv }, {
        Create("UIGradient", { Rotation = 90, Transparency = NumberSequence.new(1, 0) }),
    })
    root:Round(black, 0.6)
    local cursor = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.fromOffset(12, 12), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 5,
        Parent = sv,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }), Create("UIStroke", { Thickness = 2, Color = Color3.new(0, 0, 0), Transparency = 0.35 }) })

    local hue = Create("TextButton", {
        Name = "Hue", AnchorPoint = Vector2.new(0, 1), Position = UDim2.fromScale(0, 1), Size = UDim2.new(1, 0, 0, 12),
        BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0, Parent = area,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    local stops = {}
    for i = 0, 6 do stops[#stops + 1] = KP(i / 6, Color3.fromHSV(i / 6 % 1 == 0 and (i == 6 and 0.9999 or 0) or i / 6, 1, 1)) end
    Create("UIGradient", { Color = ColorSequence.new(stops), Parent = hue })
    local hueCursor = Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.fromOffset(6, 16),
        BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 3, Parent = hue,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }), Create("UIStroke", { Thickness = 1.5, Color = Color3.new(0, 0, 0), Transparency = 0.4 }) })
    self.SV, self.Hue, self.Cursor, self.HueCursor = sv, hue, cursor, hueCursor

    local function begin(kind, input)
        if self.Disabled or not IsPointerDown(input) then return end
        self.Drag = kind
        if self.Scroll then self.Scroll.ScrollingEnabled = false end
        self:_FromInput(input.Position)
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                connection:Disconnect()
                self.Drag = nil
                if self.Scroll then self.Scroll.ScrollingEnabled = true end
            end
        end)
    end
    sv.InputBegan:Connect(function(input) begin("SV", input) end)
    hue.InputBegan:Connect(function(input) begin("Hue", input) end)
    self.MoveConn = UserInputService.InputChanged:Connect(function(input)
        if self.Drag and IsPointerMove(input) then self:_FromInput(input.Position) end
    end)

    swatch.MouseEnter:Connect(function() Tween(self.SwatchStroke, { Color = root.Theme.Accent }, 0.2) end)
    swatch.MouseLeave:Connect(function()
        if not self.Expanded then Tween(self.SwatchStroke, { Color = root.Theme.Stroke }, 0.2) end
    end)
    swatch.Activated:Connect(function() if not self.Disabled then self:SetExpanded(not self.Expanded) end end)

    local default = opts.Default
    if type(default) == "string" then default = FromHex(default) end
    self.H, self.S, self.V = (default or Color3.fromRGB(139, 108, 255)):ToHSV()
    self.Value = Color3.fromHSV(self.H, self.S, self.V)
    self:_Paint(true)
    Register(root, self, opts.Flag)
    if opts.Disabled then self:SetDisabled(true) end
    return self
end

function ColorPicker:_FromInput(position)
    if self.Drag == "SV" then
        local p, s = self.SV.AbsolutePosition, self.SV.AbsoluteSize
        local x = math.clamp((position.X - p.X) / math.max(1, s.X), 0, 1)
        local y = math.clamp((position.Y - p.Y) / math.max(1, s.Y), 0, 1)
        self:_SetHSV(self.H, x, 1 - y)
    elseif self.Drag == "Hue" then
        local p, s = self.Hue.AbsolutePosition, self.Hue.AbsoluteSize
        self:_SetHSV(math.clamp((position.X - p.X) / math.max(1, s.X), 0, 0.9999), self.S, self.V)
    end
end

function ColorPicker:_SetHSV(h, s, v, silent)
    self.H, self.S, self.V = h, s, v
    self.Value = Color3.fromHSV(h, s, v)
    self:_Paint(false)
    if self.Flag then Library.Flags[self.Flag] = self.Value end
    if silent then return end
    Fire("callback", self.Name, self.Callback, self.Value)
    for _, fn in ipairs(self.Listeners) do Fire("callback", self.Name, fn, self.Value) end
end

function ColorPicker:_Paint(instant)
    Apply(self.Swatch, { BackgroundColor3 = self.Value }, instant or self.Drag ~= nil, 0.12)
    self.HexLabel.Text = ToHex(self.Value)
    self.SV.BackgroundColor3 = Color3.fromHSV(self.H, 1, 1)
    self.Cursor.Position = UDim2.fromScale(self.S, 1 - self.V)
    self.HueCursor.Position = UDim2.fromScale(self.H, 0.5)
end

function ColorPicker:_Restyle() end

function ColorPicker:SetExpanded(state)
    self.Expanded = state
    local M = self.Root.Metrics
    Tween(self.Holder, { Size = UDim2.new(1, 0, 0, M.Row + (state and self.PickerH or 0)) }, 0.35, Enum.EasingStyle.Quint)
    Tween(self.SwatchStroke, { Color = state and self.Root.Theme.Accent or self.Root.Theme.Stroke }, 0.2)
end

function ColorPicker:Get() return self.Value end

function ColorPicker:Set(value, silent)
    if type(value) == "string" then value = FromHex(value) end
    if typeof(value) ~= "Color3" then return end
    local h, s, v = value:ToHSV()
    self:_SetHSV(h, s, v, silent)
end

function ColorPicker:Save() return ToHex(self.Value) end
function ColorPicker:Load(value) self:Set(value) end

function ColorPicker:OnChanged(fn)
    self.Listeners[#self.Listeners + 1] = fn
    return function()
        for i, listener in ipairs(self.Listeners) do
            if listener == fn then table.remove(self.Listeners, i) break end
        end
    end
end

function ColorPicker:SetName(name) self.Name = tostring(name); self.Label.Text = self.Name end
function ColorPicker:SetVisible(state) self.Holder.Visible = state end
function ColorPicker:SetDisabled(state)
    self.Disabled = state
    if state and self.Expanded then self:SetExpanded(false) end
    Tween(self.Label, { TextTransparency = state and 0.55 or 0 }, 0.2)
end
function ColorPicker:_Cleanup() if self.MoveConn then self.MoveConn:Disconnect() self.MoveConn = nil end end
function ColorPicker:Destroy() self:_Cleanup(); Unregister(self.Root, self); self.Holder:Destroy() end

local Segmented = {}
Segmented.__index = Segmented

local function TextWidth(text, size, font)
    local ok, bounds = pcall(function()
        local params = Instance.new("GetTextBoundsParams")
        params.Text, params.Font, params.Size, params.Width = text, font, size, 100000
        return TextService:GetTextBoundsAsync(params)
    end)
    return ok and bounds.X or (#text * size * 0.62)
end

function Segmented.new(root, parent, opts)
    opts = opts or {}
    local self = setmetatable({}, Segmented)
    local M = root.Metrics
    self.Root = root
    self.Name = tostring(opts.Name or "Mode")
    self.Callback = opts.Callback
    self.Listeners, self.Disabled = {}, false
    self.Options = {}
    for _, option in ipairs(opts.Options or {}) do self.Options[#self.Options + 1] = Normalize(option) end
    local n = math.max(1, #self.Options)

    self.Row, self.Label = MakeRow(root, parent, self.Name, M.Row, opts.LayoutOrder, 0.34)
    self.Base = M.Row
    local bar = Create("Frame", {
        Name = "Bar", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0),
        Size = UDim2.new(0.66, 0, 0, M.Field + 2), Parent = self.Row,
    })
    root:Bind(bar, { BackgroundColor3 = "Elevated" })
    root:Round(bar, 0.7)
    root:Stroke(bar, "Stroke", 1, 0.1)
    self.Bar = bar

    self.Pill = Create("Frame", {
        Name = "Pill", Size = UDim2.new(1 / n, -4, 1, -4), Position = UDim2.new(0, 2, 0, 2),
        BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 2, Parent = bar,
    })
    root:Round(self.Pill, 0.5)
    root:Gradient(self.Pill, "Flow", nil, { Sweep = 1.3, Range = 0.5 })

    self.Buttons = {}
    for i, option in ipairs(self.Options) do
        local button = Create("TextButton", {
            Text = option.Text, TextSize = M.Text - 2, Font = Enum.Font.GothamBold,
            Size = UDim2.new(1 / n, 0, 1, 0), Position = UDim2.new((i - 1) / n, 0, 0, 0), ZIndex = 3, Parent = bar,
        })
        Create("UITextSizeConstraint", { MaxTextSize = M.Text - 2, MinTextSize = 6, Parent = button })
        button.Activated:Connect(function() if not self.Disabled then self:Set(option.Value) end end)
        button:GetPropertyChangedSignal("FontFace"):Connect(function() self:_Layout() end)
        self.Buttons[i] = button
    end

    local default = opts.Default
    self.Index = 1
    for i, option in ipairs(self.Options) do if option.Value == default then self.Index = i end end
    self:_Paint(true)
    Register(root, self, opts.Flag)
    if opts.Disabled then self:SetDisabled(true) end

    local lastWidth
    self.Row:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        local width = self.Row.AbsoluteSize.X
        if width ~= lastWidth then lastWidth = width; self:_Layout() end
    end)
    self.Row:GetPropertyChangedSignal("Size"):Connect(function()
        local h = self.WantH
        if h and self.Row.Size.Y.Offset ~= h then self.Row.Size = UDim2.new(1, 0, 0, h) end
    end)
    self.Label:GetPropertyChangedSignal("Text"):Connect(function() self:_Layout() end)
    task.defer(function() self:_Layout() end)
    return self
end

function Segmented:_Layout()
    local row, bar, label, M = self.Row, self.Bar, self.Label, self.Root.Metrics
    local width = row.AbsoluteSize.X
    if width < 40 or #self.Buttons == 0 then return end
    local size = M.Text - 2
    local widths, total = {}, 0
    for i, button in ipairs(self.Buttons) do
        widths[i] = math.ceil(TextWidth(button.Text, size, button.FontFace)) + 18
        total = total + widths[i]
    end
    local labelWidth = math.ceil(TextWidth(label.Text, M.Text, label.FontFace)) + 12
    local room = width - math.min(labelWidth, width * 0.4) - 6
    local stacked = total + 4 > room
    self.WantH = stacked and (self.Base + M.Field + 4) or nil
    local barWidth = stacked and width or math.min(room, math.max(total + 4, width * 0.5))

    if stacked then
        label.AnchorPoint, label.Position, label.Size = Vector2.new(0, 0), UDim2.fromOffset(2, 0), UDim2.new(1, -8, 0, self.Base)
        bar.AnchorPoint, bar.Position = Vector2.new(0, 0), UDim2.fromOffset(0, self.Base - 2)
        bar.Size = UDim2.new(1, 0, 0, M.Field + 2)
        row.Size = UDim2.new(1, 0, 0, self.Base + M.Field + 4)
    else
        label.AnchorPoint, label.Position = Vector2.new(0, 0.5), UDim2.new(0, 2, 0.5, 0)
        label.Size = UDim2.new(1, -(barWidth + 10), 1, 0)
        bar.AnchorPoint, bar.Position = Vector2.new(1, 0.5), UDim2.new(1, 0, 0.5, 0)
        bar.Size = UDim2.new(0, barWidth, 0, M.Field + 2)
        if self.Stacked then row.Size = UDim2.new(1, 0, 0, self.Base) end
    end
    self.Stacked = stacked

    local scaled = total > barWidth
    local geo, x = {}, 0
    for i, button in ipairs(self.Buttons) do
        local w = widths[i] * barWidth / total
        geo[i] = { x = x, w = w }
        button.Position, button.Size = UDim2.fromOffset(x, 0), UDim2.new(0, w, 1, 0)
        button.TextScaled = scaled
        if not scaled then button.TextSize = size end
        x = x + w
    end
    self.Geo = geo
    self:_Paint(true)
end

function Segmented:_Paint(instant)
    local n = math.max(1, #self.Options)
    local T = self.Root.Theme
    local g = self.Geo and self.Geo[self.Index]
    if g then
        Apply(self.Pill, { Position = UDim2.fromOffset(g.x + 2, 2), Size = UDim2.new(0, math.max(2, g.w - 4), 1, -4) }, instant, 0.4)
    else
        Apply(self.Pill, { Position = UDim2.new((self.Index - 1) / n, 2, 0, 2) }, instant, 0.4)
    end
    for i, button in ipairs(self.Buttons) do
        Apply(button, { TextColor3 = i == self.Index and T.OnAccent or T.SubText }, instant, 0.25)
    end
end

function Segmented:_Restyle(instant) self:_Paint(instant) end

function Segmented:Get()
    local option = self.Options[self.Index]
    return option and option.Value
end

function Segmented:Set(value, silent)
    for i, option in ipairs(self.Options) do
        if option.Value == value then
            if i == self.Index then return end
            self.Index = i
            self:_Paint()
            if self.Flag then Library.Flags[self.Flag] = value end
            if silent then return end
            Fire("callback", self.Name, self.Callback, value)
            for _, fn in ipairs(self.Listeners) do Fire("callback", self.Name, fn, value) end
            return
        end
    end
end

function Segmented:OnChanged(fn)
    self.Listeners[#self.Listeners + 1] = fn
    return function()
        for i, listener in ipairs(self.Listeners) do
            if listener == fn then table.remove(self.Listeners, i) break end
        end
    end
end

function Segmented:SetName(name) self.Name = tostring(name); self.Label.Text = self.Name end
function Segmented:SetVisible(state) self.Row.Visible = state end
function Segmented:SetDisabled(state)
    self.Disabled = state
    Tween(self.Label, { TextTransparency = state and 0.55 or 0 }, 0.2)
    Tween(self.Bar, { BackgroundTransparency = state and 0.5 or 0 }, 0.2)
end
function Segmented:Destroy() Unregister(self.Root, self); self.Row:Destroy() end

local Progress = {}
Progress.__index = Progress

function Progress.new(root, parent, opts)
    local self = setmetatable({}, Progress)
    local M = root.Metrics
    self.Root, self.Name = root, tostring(opts.Name or "Progress")
    self.Min, self.Max = opts.Min or 0, opts.Max or 100
    self.Format = opts.Format
    self.Suffix = opts.Suffix
    self.Value = math.clamp(opts.Default or opts.Value or self.Min, self.Min, self.Max)

    self.Row, self.Label = MakeRow(root, parent, self.Name, M.Row + 8, opts.LayoutOrder, 0.6)
    self.Label.AnchorPoint = Vector2.new(0, 0)
    self.Label.Position = UDim2.fromOffset(2, 3)
    self.Label.Size = UDim2.new(0.62, -8, 0, M.Row - 8)

    self.ValueLabel = Create("TextLabel", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -2, 0, 3), Size = UDim2.new(0.38, -4, 0, M.Row - 8),
        TextSize = M.Text - 1, TextXAlignment = Enum.TextXAlignment.Right, Fit = true, Parent = self.Row,
    })
    root:Bind(self.ValueLabel, { TextColor3 = "SubText" })

    local track = Create("Frame", {
        Name = "Track", AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 2, 1, -5), Size = UDim2.new(1, -4, 0, 5),
        ClipsDescendants = true, Parent = self.Row,
    })
    root:Bind(track, { BackgroundColor3 = "Elevated" })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = track })
    root:Stroke(track, "Stroke", 1, 0.3)
    self.Fill = Create("Frame", {
        Name = "Fill", Size = UDim2.fromScale(0, 1), BackgroundColor3 = Color3.new(1, 1, 1), Parent = track,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    root:Gradient(self.Fill, "Flow", nil, { Sweep = 1.3, Range = 0.5 })

    self:_Paint(true)
    Register(root, self, opts.Flag)
    return self
end

function Progress:_Fraction()
    local span = self.Max - self.Min
    return span > 0 and (self.Value - self.Min) / span or 0
end

function Progress:_Paint(instant)
    local text
    if self.Format then
        local ok, result = pcall(self.Format, self.Value, self:_Fraction())
        text = ok and tostring(result) or tostring(self.Value)
    elseif self.Min == 0 and self.Max == 100 and not self.Suffix then
        text = string.format("%d%%", math.floor(self.Value + 0.5))
    else
        local d = Decimals(self.Max - self.Min > 1 and 1 or 0.01)
        text = string.format("%." .. d .. "f", self.Value) .. (self.Suffix or "")
    end
    self.ValueLabel.Text = text
    Apply(self.Fill, { Size = UDim2.fromScale(self:_Fraction(), 1) }, instant, 0.45, Enum.EasingStyle.Quint)
end

function Progress:_Restyle() end
function Progress:Get() return self.Value end

function Progress:Set(value, silent)
    value = math.clamp(tonumber(value) or self.Min, self.Min, self.Max)
    if value == self.Value then return end
    self.Value = value
    self:_Paint()
    if self.Flag then Library.Flags[self.Flag] = value end
end

function Progress:SetName(name) self.Name = tostring(name); self.Label.Text = self.Name end
function Progress:SetVisible(state) self.Row.Visible = state end
function Progress:SetDisabled() end
function Progress:Destroy() Unregister(self.Root, self); self.Row:Destroy() end

local Stepper = {}
Stepper.__index = Stepper

function Stepper.new(root, parent, opts)
    local self = setmetatable({}, Stepper)
    local M = root.Metrics
    self.Root, self.Name, self.Callback = root, tostring(opts.Name or "Stepper"), opts.Callback
    self.Min, self.Max, self.Step = opts.Min or 0, opts.Max or 100, opts.Step or 1
    self.Suffix, self.Listeners, self.Disabled = opts.Suffix or "", {}, false
    self.Decimals = Decimals(self.Step)
    self.Value = self:_Clean(opts.Default or self.Min)

    self.Row, self.Label = MakeRow(root, parent, self.Name, M.Row, opts.LayoutOrder, 0.5)

    local h = M.Field
    local group = Create("Frame", {
        Name = "Group", AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -1, 0.5, 0),
        Size = UDim2.new(0.5, -4, 0, h), Parent = self.Row,
    })
    root:Bind(group, { BackgroundColor3 = "Elevated" })
    root:Round(group, 0.6)
    root:Stroke(group, "Stroke", 1, 0.1)

    local function makeButton(symbol, side, direction)
        local button = Create("TextButton", {
            Text = symbol, Font = Enum.Font.GothamBold, TextSize = M.Text + 3,
            AnchorPoint = Vector2.new(side, 0), Position = UDim2.fromScale(side, 0), Size = UDim2.new(0, h, 1, 0), Parent = group,
        })
        root:Bind(button, { TextColor3 = "SubText" })
        button.MouseEnter:Connect(function() if not self.Disabled then Tween(button, { TextColor3 = root.Theme.Accent }, 0.15) end end)
        button.MouseLeave:Connect(function() Tween(button, { TextColor3 = root.Theme.SubText }, 0.2) end)
        button.MouseButton1Down:Connect(function()
            if self.Disabled then return end
            self.Hold = (self.Hold or 0) + 1
            local id = self.Hold
            self:Set(self.Value + direction * self.Step)
            task.spawn(function()
                task.wait(0.4)
                local wait = 0.12
                while self.Hold == id and group.Parent do
                    self:Set(self.Value + direction * self.Step)
                    task.wait(wait)
                    wait = math.max(0.03, wait * 0.9)
                end
            end)
        end)
        local function release() self.Hold = (self.Hold or 0) + 1 end
        button.MouseButton1Up:Connect(release)
        button.MouseLeave:Connect(release)
        return button
    end
    makeButton("-", 0, -1)
    makeButton("+", 1, 1)

    self.ValueLabel = Create("TextLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -h * 2, 1, 0),
        TextSize = M.Text, Fit = true, Parent = group,
    })
    root:Bind(self.ValueLabel, { TextColor3 = "Text" })

    self:_Paint()
    Register(root, self, opts.Flag)
    if opts.Disabled then self:SetDisabled(true) end
    return self
end

function Stepper:_Clean(value)
    value = math.clamp(tonumber(value) or self.Min, self.Min, self.Max)
    local steps = math.floor((value - self.Min) / self.Step + 0.5)
    return math.clamp(tonumber(string.format("%." .. self.Decimals .. "f", self.Min + steps * self.Step)), self.Min, self.Max)
end

function Stepper:_Paint()
    self.ValueLabel.Text = string.format("%." .. self.Decimals .. "f", self.Value) .. self.Suffix
end

function Stepper:_Restyle() end
function Stepper:Get() return self.Value end

function Stepper:Set(value, silent)
    value = self:_Clean(value)
    if value == self.Value then return end
    self.Value = value
    self:_Paint()
    if self.Flag then Library.Flags[self.Flag] = value end
    if silent then return end
    Fire("callback", self.Name, self.Callback, value)
    for _, fn in ipairs(self.Listeners) do Fire("callback", self.Name, fn, value) end
end

function Stepper:OnChanged(fn)
    self.Listeners[#self.Listeners + 1] = fn
    return function()
        for i, listener in ipairs(self.Listeners) do
            if listener == fn then table.remove(self.Listeners, i) break end
        end
    end
end

function Stepper:SetName(name) self.Name = tostring(name); self.Label.Text = self.Name end
function Stepper:SetVisible(state) self.Row.Visible = state end
function Stepper:SetDisabled(state)
    self.Disabled = state
    Tween(self.Label, { TextTransparency = state and 0.55 or 0 }, 0.2)
    Tween(self.ValueLabel, { TextTransparency = state and 0.55 or 0 }, 0.2)
end
function Stepper:Destroy() self.Hold = (self.Hold or 0) + 1; Unregister(self.Root, self); self.Row:Destroy() end

Library.ImageCache = {}
local ImageWaiting = {}

local function ImageKind(bytes)
    if bytes:sub(1, 8) == "\137PNG\r\n\26\n" then return "png" end
    if bytes:sub(1, 3) == "\255\216\255" then return "jpg" end
    if bytes:sub(1, 4) == "RIFF" and bytes:sub(9, 12) == "WEBP" then return nil, "WEBP is not supported by Roblox, use PNG or JPG" end
    if bytes:sub(1, 3) == "GIF" then return nil, "GIF is not supported by Roblox, use PNG or JPG" end
    return nil, "not a PNG or JPG image"
end

function Library:LoadImage(source, done)
    local cached = self.ImageCache[tostring(source)]
    if cached then done(cached) return end
    if type(source) == "number" then done("rbxassetid://" .. source) return end
    source = tostring(source or "")
    if source:match("^rbxassetid://") or source:match("^rbxasset://") or source:match("^https?://[%w%.]*roblox%.com/asset") then
        done(source) return
    end
    if source == "" then done(nil, "no image set") return end

    local waiting = ImageWaiting[source]
    if waiting then waiting[#waiting + 1] = done return end
    waiting = { done }
    ImageWaiting[source] = waiting
    local function finish(content, reason)
        ImageWaiting[source] = nil
        if content then self.ImageCache[source] = content end
        for _, fn in ipairs(waiting) do pcall(fn, content, reason) end
    end

    task.spawn(function()
        if not (writefile and (getcustomasset or getsynasset)) then
            return finish(nil, "this executor has no writefile / getcustomasset")
        end
        EnsureFolder("Velor"); EnsureFolder("Velor/cache")
        if not source:match("^https?://") then
            if isfile and isfile(source) then
                local asset = AssetOf(source)
                return finish(asset, asset == nil and "getcustomasset failed" or nil)
            end
            return finish(nil, "file not found")
        end
        local base = "Velor/cache/img_" .. Hash(source)
        for _, ext in ipairs({ "png", "jpg" }) do
            if isfile and isfile(base .. "." .. ext) then
                local asset = AssetOf(base .. "." .. ext)
                if asset then return finish(asset) end
            end
        end
        local body, err = Http(source)
        if not body then return finish(nil, "download failed: " .. tostring(err)) end
        local ext, why = ImageKind(body)
        if not ext then return finish(nil, why) end
        local ok = pcall(writefile, base .. "." .. ext, body)
        if not ok then return finish(nil, "could not save the image") end
        local asset = AssetOf(base .. "." .. ext)
        finish(asset, asset == nil and "getcustomasset failed" or nil)
    end)
end

local Section = {}
Section.__index = Section

function Section:_Next()
    self.Order = self.Order + 1
    return self.Order
end

function Section:AddDropdown(opts)
    opts = opts or {}
    opts.LayoutOrder = self:_Next()
    return Dropdown.new(self.Root, self.Body, opts, self.Clip)
end

function Section:AddToggle(opts)
    opts = opts or {}
    opts.LayoutOrder = self:_Next()
    return Toggle.new(self.Root, self.Body, opts)
end

function Section:AddSlider(opts)
    opts = opts or {}
    opts.LayoutOrder = self:_Next()
    return Slider.new(self.Root, self.Body, opts, self.Clip)
end

function Section:AddInput(opts)
    opts = opts or {}
    opts.LayoutOrder = self:_Next()
    return Input.new(self.Root, self.Body, opts)
end

function Section:AddKeybind(opts)
    opts = opts or {}
    opts.LayoutOrder = self:_Next()
    return Keybind.new(self.Root, self.Body, opts)
end

function Section:AddColorPicker(opts)
    opts = opts or {}
    opts.LayoutOrder = self:_Next()
    return ColorPicker.new(self.Root, self.Body, opts, self.Clip)
end

function Section:AddSegmented(opts)
    opts = opts or {}
    opts.LayoutOrder = self:_Next()
    return Segmented.new(self.Root, self.Body, opts)
end

function Section:AddProgress(opts)
    opts = opts or {}
    opts.LayoutOrder = self:_Next()
    return Progress.new(self.Root, self.Body, opts)
end

function Section:AddStepper(opts)
    opts = opts or {}
    opts.LayoutOrder = self:_Next()
    return Stepper.new(self.Root, self.Body, opts)
end

function Section:AddCallout(opts)
    if type(opts) == "string" then opts = { Content = opts } end
    opts = opts or {}
    local root, M = self.Root, self.Root.Metrics
    local key = ({ Success = "Success", Warning = "Warning", Error = "Danger" })[opts.Type or "Info"] or "Accent"
    local card = Create("Frame", {
        Name = "Callout", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = self:_Next(),
        BackgroundTransparency = 0.45, Parent = self.Body,
    })
    root:Bind(card, { BackgroundColor3 = "Elevated" })
    root:Round(card, 0.6)
    local stroke = root:Stroke(card, key, 1, 0.55)
    local tint = Create("Frame", {
        Name = "Tint", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 0.9, ZIndex = 0, Parent = card,
    })
    root:Bind(tint, { BackgroundColor3 = key })
    root:Round(tint, 0.6)
    local content = Create("Frame", {
        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Parent = card,
    }, { Create("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }) })
    Pad(content, 13, 10, 12, 11)
    local title = Create("TextLabel", {
        Text = tostring(opts.Title or ""), Font = Enum.Font.GothamBold, TextSize = M.Text, TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1, Visible = opts.Title ~= nil, Parent = content,
    })
    root:Bind(title, { TextColor3 = key })
    local text = Create("TextLabel", {
        Text = tostring(opts.Content or ""), TextSize = M.Text - 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = 2, RichText = opts.RichText == true, Parent = content,
    })
    root:Bind(text, { TextColor3 = "Text" })
    return {
        Instance = card,
        Set = function(_, newTitle, newContent)
            if newContent == nil then newContent, newTitle = newTitle, nil end
            if newTitle ~= nil then title.Text, title.Visible = tostring(newTitle), true end
            text.Text = tostring(newContent or "")
        end,
    }
end

function Section:AddParagraph(opts)
    if type(opts) == "string" then opts = { Content = opts } end
    opts = opts or {}
    local root, M = self.Root, self.Root.Metrics

    local card = Create("Frame", {
        Name = "Paragraph", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = self:_Next(),
        BackgroundTransparency = 0.4, Parent = self.Body,
    })
    root:Bind(card, { BackgroundColor3 = "Elevated" })
    root:Round(card, 0.6)
    root:Stroke(card, "Stroke", 1, 0.35)
    local content = Create("Frame", {
        Name = "Content", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        Parent = card,
    }, { Create("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder }) })
    Pad(content, 13, 10, 12, 11)
    local bar = Create("Frame", {
        Name = "Accent", Position = UDim2.fromOffset(5, 10), Size = UDim2.fromOffset(2, 16), BackgroundColor3 = Color3.new(1, 1, 1),
        ZIndex = 2, Parent = card,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    root:Gradient(bar, "Soft", { Rotation = 90 })
    content:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()

        local h = math.max(10, math.floor(content.AbsoluteSize.Y - 20))
        if bar.Size.Y.Offset ~= h then bar.Size = UDim2.fromOffset(2, h) end
    end)
    local title = Create("TextLabel", {
        Text = tostring(opts.Title or ""), Font = Enum.Font.GothamBold, TextSize = M.Text, TextXAlignment = Enum.TextXAlignment.Left,
        TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 1, Visible = opts.Title ~= nil, Parent = content,
    })
    root:Bind(title, { TextColor3 = "Text" })
    local text = Create("TextLabel", {
        Text = tostring(opts.Content or ""), TextSize = M.Text - 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 2,
        RichText = opts.RichText == true, Parent = content,
    })
    root:Bind(text, { TextColor3 = "SubText" })
    return {
        Instance = card,
        Set = function(_, newTitle, newContent)
            if newContent == nil then newContent, newTitle = newTitle, nil end
            if newTitle ~= nil then title.Text, title.Visible = tostring(newTitle), true end
            text.Text = tostring(newContent or "")
        end,
    }
end

function Section:AddDivider()
    local root = self.Root
    local holder = Create("Frame", {
        Name = "Divider", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 9), LayoutOrder = self:_Next(), Parent = self.Body,
    })
    local line = Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromScale(0, 0.5), Size = UDim2.new(1, 0, 0, 1),
        BackgroundTransparency = 0.2, Parent = holder,
    })
    root:Bind(line, { BackgroundColor3 = "Stroke" })
    Create("UIGradient", {
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0), NumberSequenceKeypoint.new(0.8, 0),
            NumberSequenceKeypoint.new(1, 1),
        }), Parent = line,
    })
    return holder
end

function Section:AddLabel(text)
    local root, M = self.Root, self.Root.Metrics
    local label = Create("TextLabel", {
        Text = tostring(text), TextSize = M.Text - 1, TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
        Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = self:_Next(), Parent = self.Body,
    })
    root:Bind(label, { TextColor3 = "SubText" })
    Pad(label, 4, 5, 4, 5)
    return { Set = function(_, value) label.Text = tostring(value) end, Instance = label }
end

function Section:AddButton(opts)
    opts = opts or {}
    local root, M = self.Root, self.Root.Metrics
    local accent = opts.Style == "Accent" or opts.Accent == true
    local height = M.Field + 4

    local holder = Create("Frame", {
        Name = "Button", BackgroundTransparency = 1, LayoutOrder = self:_Next(),
        Size = UDim2.new(1, 0, 0, height + 6), Parent = self.Body,
    })
    local button = Create("TextButton", {
        Text = tostring(opts.Name or "Button"), TextSize = M.Text, BackgroundTransparency = 0, ClipsDescendants = true, Fit = true,
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.new(1, 0, 0, height), Parent = holder,
    })
    root:Round(button, 0.6)
    local stroke = root:Stroke(button, "Stroke", 1, 0.1)
    if accent then
        AccentFill(root, button, tostring(opts.Name or "Button"), M.Text)
        stroke.Transparency = 1
    else
        root:Bind(button, { BackgroundColor3 = "Elevated", TextColor3 = "Text" })
    end

    local shine = Create("Frame", {
        Name = "Shine", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 2, Parent = button,
    })
    root:Round(shine, 0.6)
    local shineGradient = Create("UIGradient", {
        Rotation = 20, Offset = Vector2.new(-1, 0), Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.86), NumberSequenceKeypoint.new(1, 1),
        }), Parent = shine,
    })

    button.MouseEnter:Connect(function()
        if not accent then
            Tween(button, { BackgroundColor3 = root.Theme.Hover }, 0.22)
            Tween(stroke, { Color = root.Theme.Accent }, 0.2)
        end
        shineGradient.Offset = Vector2.new(-1, 0)
        Tween(shineGradient, { Offset = Vector2.new(1, 0) }, 0.8)
    end)
    button.MouseLeave:Connect(function()
        if not accent then
            Tween(button, { BackgroundColor3 = root.Theme.Elevated }, 0.2)
            Tween(stroke, { Color = root.Theme.Stroke }, 0.2)
        end
        Tween(button, { Size = UDim2.new(1, 0, 0, height) }, 0.3)
    end)
    button.MouseButton1Down:Connect(function()
        Tween(button, { Size = UDim2.new(1, -6, 0, height - 2) }, 0.12)
    end)
    button.MouseButton1Up:Connect(function()
        Tween(button, { Size = UDim2.new(1, 0, 0, height) }, 0.4)
    end)
    button.Activated:Connect(function()
        Fire("button", opts.Name or "Button", opts.Callback)
    end)
    return button
end

local ImageFormats = {
    horizontal = { ratio = 16 / 9, width = 1 }, vertical = { ratio = 3 / 4, width = 0.6 }, square = { ratio = 1, width = 0.72 },
}
local FormatAlias = {
    horizontal = "horizontal", wide = "horizontal", banner = "horizontal", landscape = "horizontal", ["16:9"] = "horizontal",
    vertical = "vertical", tall = "vertical", portrait = "vertical", ["3:4"] = "vertical", ["9:16"] = "vertical",
    square = "square", ["1:1"] = "square",
}

local function CollageLayout(n, aspect)
    local rects = {}
    local wide, tall = aspect > 1.2, aspect < 0.85
    if n <= 1 then return { { 0, 0, 1, 1 } } end
    if n == 2 then
        if tall then return { { 0, 0, 1, 0.5 }, { 0, 0.5, 1, 0.5 } } end
        return { { 0, 0, 0.5, 1 }, { 0.5, 0, 0.5, 1 } }
    end
    if n == 3 then
        if tall then return { { 0, 0, 1, 0.56 }, { 0, 0.56, 0.5, 0.44 }, { 0.5, 0.56, 0.5, 0.44 } } end
        return { { 0, 0, 0.56, 1 }, { 0.56, 0, 0.44, 0.5 }, { 0.56, 0.5, 0.44, 0.5 } }
    end
    if n == 5 then
        if wide then
            return { { 0, 0, 0.4, 1 }, { 0.4, 0, 0.3, 0.5 }, { 0.7, 0, 0.3, 0.5 }, { 0.4, 0.5, 0.3, 0.5 }, { 0.7, 0.5, 0.3, 0.5 } }
        elseif tall then
            return { { 0, 0, 1, 0.4 }, { 0, 0.4, 0.5, 0.3 }, { 0.5, 0.4, 0.5, 0.3 }, { 0, 0.7, 0.5, 0.3 }, { 0.5, 0.7, 0.5, 0.3 } }
        end
        return { { 0, 0, 0.5, 0.5 }, { 0.5, 0, 0.5, 0.5 }, { 0, 0.5, 1 / 3, 0.5 }, { 1 / 3, 0.5, 1 / 3, 0.5 }, { 2 / 3, 0.5, 1 / 3, 0.5 } }
    end

    local rows = math.max(1, math.min(n, math.floor(math.sqrt(n / aspect) + 0.5)))
    local base, extra = math.floor(n / rows), n % rows
    local index = 0
    for r = 1, rows do
        local count = base + ((r > rows - extra) and 1 or 0)
        for c = 1, count do
            index = index + 1
            rects[index] = { (c - 1) / count, (r - 1) / rows, 1 / count, 1 / rows }
        end
    end
    return rects
end

local MAX_TILES = 9

local function ImageTile(root, parent, mult)
    local M = root.Metrics
    local tile = Create("TextButton", { Name = "Tile", BackgroundTransparency = 0, ClipsDescendants = true, Parent = parent })
    root:Bind(tile, { BackgroundColor3 = "Elevated" })
    if mult and mult > 0 then root:Round(tile, mult) end
    local stroke = root:Stroke(tile, "Stroke", 1, 0.65)
    local shimmer = Create("Frame", { Name = "Shimmer", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 1, Parent = tile })
    local shimmerGradient = Create("UIGradient", {
        Rotation = 20, Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.88), NumberSequenceKeypoint.new(1, 1),
        }), Parent = shimmer,
    })
    local shimmerEntry = root:Animate(shimmerGradient, { Sweep = 2.2, Range = 1 })
    local image = Create("ImageLabel", { Name = "Image", Size = UDim2.fromScale(1, 1), ImageTransparency = 1, ScaleType = Enum.ScaleType.Crop, ZIndex = 2, Parent = tile })
    local note = Create("TextLabel", {
        Name = "Note", Text = "", TextSize = M.Text - 2, TextWrapped = true, Visible = false, ZIndex = 3,
        Size = UDim2.new(1, -16, 1, -8), Position = UDim2.fromOffset(8, 4), Parent = tile,
    })
    root:Bind(note, { TextColor3 = "Muted" })
    local over = Create("TextLabel", {
        Name = "More", Text = "", Font = Enum.Font.GothamBold, TextSize = M.Text + 4, TextColor3 = Color3.new(1, 1, 1), Visible = false,
        BackgroundTransparency = 0.45, BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.fromScale(1, 1), ZIndex = 4, Parent = tile,
    })
    local control = { Tile = tile, Image = image, Stroke = stroke, Source = nil, Token = 0 }
    function control:Load(source, scaleType)
        self.Source = source
        self.Token = self.Token + 1
        local token = self.Token
        image.ScaleType = scaleType or image.ScaleType
        note.Visible = false
        shimmer.Visible = true
        shimmerEntry.On = true
        Tween(image, { ImageTransparency = 1 }, 0.1)
        Library:LoadImage(source, function(content, reason)
            if token ~= self.Token or not tile.Parent then return end
            shimmerEntry.On = false
            if content then
                image.Image = content
                shimmer.Visible = false
                Tween(image, { ImageTransparency = 0 }, 0.6)
            else
                shimmer.Visible = false
                note.Text = "Couldn't load image\n" .. tostring(reason or "")
                note.Visible = true
                self.Failed = true
            end
        end)
    end
    function control:SetMore(count)
        over.Visible = count and count > 0
        over.Text = count and ("+" .. count) or ""
    end
    tile.MouseEnter:Connect(function() Tween(stroke, { Transparency = 0.2 }, 0.2) end)
    tile.MouseLeave:Connect(function() Tween(stroke, { Transparency = 0.65 }, 0.25) end)
    return control
end

function Section:AddImage(source, format)
    local opts
    if type(source) == "table" and (source.Url or source.Urls or source.Image or source.Format or source.Caption or source.Ratio) then
        opts = source
    else
        opts = { Url = source, Format = format }
        if type(source) == "table" then opts.Urls, opts.Url = source, nil end
    end
    if opts.Image and not opts.Url then opts.Url = opts.Image end
    local root, M = self.Root, self.Root.Metrics
    local fitMap = { crop = Enum.ScaleType.Crop, fit = Enum.ScaleType.Fit, stretch = Enum.ScaleType.Stretch }

    local holder = Create("Frame", {
        Name = "Image", BackgroundTransparency = 1, LayoutOrder = self:_Next(), Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        Parent = self.Body,
    }, { Create("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, HorizontalAlignment = Enum.HorizontalAlignment.Center }) })
    Pad(holder, 0, 3, 0, 3)
    local row = Create("Frame", { Name = "Row", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 120), LayoutOrder = 1, Parent = holder })
    local frame = Create("Frame", { Name = "Frame", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.fromScale(0.5, 0), Parent = row })
    local gap = 3
    local tilesHolder = Create("Frame", {
        Name = "Tiles", BackgroundTransparency = 1, Position = UDim2.fromOffset(-gap / 2, -gap / 2), Size = UDim2.new(1, gap, 1, gap), Parent = frame,
    })

    local cornerMult = tonumber(opts.Corner) or 0
    local border = Create("Frame", { Name = "Border", BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), ZIndex = 8, Active = false, Parent = frame })
    if cornerMult > 0 then root:Round(border, cornerMult) end
    local borderStroke = Create("UIStroke", {
        Thickness = 1.75, Transparency = 0.15, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = border,
    })
    root:Gradient(borderStroke, "Rim", nil, { Spin = 30 })
    local caption = Create("TextLabel", {
        Name = "Caption", Text = tostring(opts.Caption or ""), TextSize = M.Text - 2, TextWrapped = true, Visible = opts.Caption ~= nil,
        Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 2, Parent = holder,
    })
    root:Bind(caption, { TextColor3 = "SubText" })

    local object = { Instance = holder, Tiles = {}, Opts = opts }
    local state = { format = "horizontal", ratio = 16 / 9, width = 1, urls = {}, fit = Enum.ScaleType.Crop, callback = opts.Callback }

    local function resolveFormat(name)
        local f = FormatAlias[tostring(name or "horizontal"):lower()] or "horizontal"
        local spec = ImageFormats[f]
        state.format, state.ratio, state.width = f, opts.Ratio or spec.ratio, opts.Width or spec.width
    end

    local function layout()
        local available = row.AbsoluteSize.X
        if available < 20 then available = M.Width - 2 * (M.Pad + 10) end
        local w = math.floor(available * state.width)
        local h = math.floor(w / state.ratio + 0.5)
        frame.Size = UDim2.fromOffset(w, h)
        if row.Size.Y.Offset ~= h then row.Size = UDim2.new(1, 0, 0, h) end
    end
    row:GetPropertyChangedSignal("AbsoluteSize"):Connect(layout)

    local function place()
        local count = math.min(#state.urls, MAX_TILES)
        local rects = CollageLayout(math.max(count, 1), state.ratio)
        local hidden = #state.urls - count
        for i = 1, math.max(count, 1) do
            local tile = object.Tiles[i]
            if not tile then
                tile = ImageTile(root, tilesHolder, cornerMult)
                tile.Tile.Activated:Connect(function()
                    if state.callback then Fire("image", "AddImage", state.callback, tile.Source, i) end
                end)
                object.Tiles[i] = tile
            end
            local r = rects[i]
            tile.Tile.Visible = true
            tile.Tile.Position = UDim2.new(r[1], gap / 2, r[2], gap / 2)
            tile.Tile.Size = UDim2.new(r[3], -gap, r[4], -gap)
            if tile.Source ~= state.urls[i] or tile.Fit ~= state.fit then
                tile.Fit = state.fit
                tile:Load(state.urls[i], state.fit)
            end
            tile:SetMore((i == count and hidden > 0) and hidden or nil)
        end
        for i = math.max(count, 1) + 1, #object.Tiles do
            object.Tiles[i].Tile.Visible = false
            object.Tiles[i].Source = nil
        end
        layout()
    end

    function object:Set(url, newFormat)
        state.urls = { url }
        if newFormat then resolveFormat(newFormat) end
        place()
        return self
    end

    function object:Collage(urls, newFormat)
        if type(urls) ~= "table" then urls = { urls } end
        state.urls = {}
        for _, u in ipairs(urls) do state.urls[#state.urls + 1] = u end
        if newFormat then resolveFormat(newFormat) end
        place()
        return self
    end
    function object:SetFormat(newFormat) resolveFormat(newFormat); place(); return self end
    function object:SetCaption(text)
        caption.Text, caption.Visible = tostring(text or ""), text ~= nil and text ~= ""
        return self
    end
    function object:OnClick(fn) state.callback = fn return self end
    function object:SetVisible(on) holder.Visible = on end
    function object:Destroy() holder:Destroy() end

    resolveFormat(opts.Format)
    local fit = tostring(opts.Fit or "crop"):lower()
    state.fit = fitMap[fit] or Enum.ScaleType.Crop
    state.urls = {}
    if opts.Urls then for _, u in ipairs(opts.Urls) do state.urls[#state.urls + 1] = u end
    elseif opts.Url ~= nil then state.urls[1] = opts.Url end
    place()
    return object
end

function Section:AddCollage(urls, format)
    if type(urls) == "table" and (urls.Urls or urls.Url or urls.Format) then return self:AddImage(urls) end
    return self:AddImage({ Urls = type(urls) == "table" and urls or { urls }, Format = format })
end

function Section:SetCollapsed(state, instant)
    if not self.Collapsible and state then return end
    self.Expanded = not state
    self.Root:CloseDropdown()
    Tween(self.ChevronHolder, { Rotation = self.Expanded and 180 or 0 }, instant and 0 or 0.3)
    self:_Sync(not instant)
end

function Section:Toggle() self:SetCollapsed(self.Expanded) end

function Section:_Sync(animate)
    local target = self.Expanded and self.Body.AbsoluteSize.Y or 0
    if animate then
        self.Animating = os.clock() + 0.44
        Tween(self.Clipper, { Size = UDim2.new(1, 0, 0, target) }, 0.4, Enum.EasingStyle.Quint)
        task.delay(0.46, function()
            if self.Clipper.Parent then self:_Sync(false) end
        end)
    else
        self.Clipper.Size = UDim2.new(1, 0, 0, target)
    end
end

local Dock = {}
Dock.__index = Dock

local EdgeInward = {
    Left = Vector2.new(1, 0), Right = Vector2.new(-1, 0), Top = Vector2.new(0, 1), Bottom = Vector2.new(0, -1),
}
local EdgeList = { "Left", "Right", "Top", "Bottom" }

local function ScreenSize(root)
    local size = root.Gui.AbsoluteSize
    if size.X < 10 or size.Y < 10 then
        local camera = workspace.CurrentCamera
        return camera and camera.ViewportSize or Vector2.new(1280, 720)
    end
    return size
end

function Dock.new(seed)
    local self = setmetatable({}, Dock)
    local root = Root.new({
        Theme = seed.Root.ThemeName, Corner = seed.Root.CornerName,
        Mobile = seed.Root.Mobile, Animated = seed.Root.Animated,
    })
    root.Gui.DisplayOrder = 1001
    local M = root.Metrics
    local cfg = seed.SwipeCfg or {}
    self.Root, self.Rows, self.Open, self.Tick = root, {}, false, 0
    self.RowH = M.Item + 6
    self.PW = root.Mobile and 216 or 204

    self.T, self.TH = 5, 7
    self.L = 134
    self.LH = self.L + 14
    self.Pad = root.Mobile and 20 or 12
    self.Gap = 7
    self.Peel, self.PeelTarget, self.PeelVel = 0, 0, 0
    self.TopExtra = root.Mobile and 34 or 48
    self.Edge = EdgeInward[cfg.Edge] and cfg.Edge or "Bottom"
    self.Along = math.clamp(tonumber(cfg.Along) or 0.5, 0, 1)
    self.Vertical = self.Edge == "Left" or self.Edge == "Right"

    local hit = Create("TextButton", {
        Name = "Swipebar", AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, ZIndex = 40, Visible = false,
        Parent = root.Gui,
    })
    self.Fab = hit
    local holder = Create("Frame", {
        Name = "Handle", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
        ZIndex = 41, Parent = hit,
    })
    self.PillHolder = holder
    self.Shadow = root:Shadow(holder, 0.9, 9)
    local pill = Create("Frame", {
        Name = "Pill", Size = UDim2.fromScale(1, 1), BackgroundTransparency = 0.4, ZIndex = 42, Parent = holder,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    root:Bind(pill, { BackgroundColor3 = "Background" })
    self.Pill = pill
    self.PillStroke = Create("UIStroke", {
        Thickness = 1.25, Transparency = 0.5, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = pill,
    })
    root:Gradient(self.PillStroke, "Metal", nil, { Spin = 24 })
    local glow = Create("Frame", {
        Name = "Glow", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.82,
        ZIndex = 43, Parent = pill,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    self.Glow = glow
    self.GlowGradient, self.GlowEntry = root:Gradient(glow, "Flow", { Rotation = 90 }, { Sweep = 1.1, Range = 0.5, Axis = "Y" })

    local panel = Create("CanvasGroup", {
        Name = "Panel", Size = UDim2.fromOffset(self.PW, 80), GroupTransparency = 1, Visible = false, ZIndex = 62, Parent = root.Gui,
    })
    root:Bind(panel, { BackgroundColor3 = "Background" })
    panel.BackgroundTransparency = math.min(root.Alpha.Popup, 0.1)
    root:Round(panel, 0.9)
    self.PanelScale = Create("UIScale", { Scale = 0.94, Parent = panel })

    self.PanelStroke = Create("UIStroke", {
        Thickness = 1.25, Transparency = 1, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = panel,
    })
    root:Gradient(self.PanelStroke, "Metal", nil, { Spin = 30 })
    self.Panel = panel

    local head = Create("TextLabel", {
        Text = "WINDOWS", Font = Enum.Font.GothamBold, TextSize = M.Text - 3, TextXAlignment = Enum.TextXAlignment.Left,
        Position = UDim2.fromOffset(14, 6), Size = UDim2.new(1, -28, 0, 18), Parent = panel,
    })
    root:Bind(head, { TextColor3 = "SubText" })
    self.List = Create("Frame", {
        Name = "List", BackgroundTransparency = 1, Position = UDim2.fromOffset(6, 26), Size = UDim2.new(1, -12, 0, 0), Parent = panel,
    }, { Create("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder }) })

    local footer = Create("TextButton", {
        Name = "Footer", AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -6), Size = UDim2.new(1, -12, 0, 26),
        BackgroundTransparency = 0, Font = Enum.Font.GothamBold, TextSize = M.Text - 2, Parent = panel,
    })
    root:Bind(footer, { BackgroundColor3 = "Elevated", TextColor3 = "Accent" })
    root:Round(footer, 0.6)
    root:Stroke(footer, "Stroke", 1, 0.2)
    footer.MouseEnter:Connect(function() Tween(footer, { BackgroundColor3 = root.Theme.Hover }, 0.15) end)
    footer.MouseLeave:Connect(function() Tween(footer, { BackgroundColor3 = root.Theme.Elevated }, 0.2) end)
    footer.Activated:Connect(function()
        local anyHidden = false
        for _, w in ipairs(Library.Windows) do if not w.Visible then anyHidden = true end end
        for _, w in ipairs(Library.Windows) do
            if anyHidden then w:Show() else w:Hide() end
        end
    end)
    self.Footer = footer

    root:Connect(root.Catcher.InputBegan, function(input)
        if IsPointerDown(input) and self.Open then self:SetOpen(false) end
    end)
    root:Connect(UserInputService.InputBegan, function(input)
        if input.KeyCode == Enum.KeyCode.Escape and self.Open then self:SetOpen(false) end
    end)

    self:_OrientHit()
    self.Goal = self:_Anchor(self.Edge, self.Along)
    self.Pos = self.Goal
    hit.Position = UDim2.fromOffset(self.Goal.X, self.Goal.Y)
    self:_PaintPill(true)

    self.SX = NewSpring(self.Goal.X, 26, 1)
    self.SY = NewSpring(self.Goal.Y, 26, 1)
    root:Connect(RunService.RenderStepped, function(dt)
        dt = math.min(dt, 1 / 20)
        if self.SpringOn then self:_Spring(dt) end
        local sx, sy = self.SX, self.SY
        sx.g, sy.g = self.Goal.X, self.Goal.Y
        local w = self.Dragging and 34 or 17
        sx.w, sy.w = w, w
        if math.abs(sx.x - sx.g) < 0.05 and math.abs(sy.x - sy.g) < 0.05 and math.abs(sx.v) + math.abs(sy.v) < 1.5 then
            sx.x, sy.x, sx.v, sy.v = sx.g, sy.g, 0, 0
            if self.Pos == self.Goal then return end
            self.Pos = self.Goal
        else
            StepSpring(sx, dt); StepSpring(sy, dt)
        end
        if self.Pos ~= self.Goal then self.Pos = Vector2.new(sx.x, sy.x) end
        hit.Position = UDim2.fromOffset(math.floor(sx.x * 2 + 0.5) / 2, math.floor(sy.x * 2 + 0.5) / 2)
    end)
    root:Connect(root.Gui:GetPropertyChangedSignal("AbsoluteSize"), function()
        self.Goal = self:_Anchor(self.Edge, self.Along)
        if self.Open then self:_Place() end
    end)

    local drag = { active = false }
    local COMMIT = root.Mobile and 34 or 28
    local FLICK = 520
    hit.MouseEnter:Connect(function()
        self.Hover = true
        self:_PaintPill(false)
        self:_PaintState()
    end)
    hit.MouseLeave:Connect(function()
        self.Hover = false
        self:_PaintPill(false)
        self:_Wake()
    end)
    hit.InputBegan:Connect(function(input)
        if not IsPointerDown(input) then return end
        local now = os.clock()
        drag.active, drag.mode, drag.n, drag.vel = true, nil, 0, 0
        drag.start, drag.grab, drag.t = input.Position, self.Pos, now
        drag.s0, drag.t0 = 0, now
        self.Held = true
        self:_PaintPill(false)
        self:_PaintState()
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState ~= Enum.UserInputState.End then return end
            connection:Disconnect()
            drag.active = false
            self.Held, self.Dragging = false, false
            if drag.mode == nil then
                self:_Click()
            elseif drag.mode == "swipe" then
                if drag.n >= COMMIT or drag.vel >= FLICK then
                    self:_Reveal(true)
                elseif drag.n <= -COMMIT * 0.6 or drag.vel <= -FLICK then
                    self:_Reveal(false)
                end
            end
            self.PeelTarget = 0
            self.SpringOn = true
            self.Goal = self:_Anchor(self.Edge, self.Along)
            self:_PaintPill(false)
            self:_Wake()
        end)
    end)
    root:Connect(UserInputService.InputChanged, function(input)
        if not (drag.active and IsPointerMove(input)) then return end
        local delta = Vector2.new(input.Position.X - drag.start.X, input.Position.Y - drag.start.Y)
        local inward = EdgeInward[self.Edge]
        local n = delta.X * inward.X + delta.Y * inward.Y
        local a = self.Vertical and delta.Y or delta.X
        if not drag.mode and delta.Magnitude > 6 then
            local lifted = os.clock() - drag.t >= 0.3
            drag.mode = (lifted or math.abs(a) > math.abs(n) * 1.3) and "slide" or "swipe"
            if drag.mode == "slide" then
                self.Dragging = true
                if self.Open then self:SetOpen(false) end
            else
                self.SpringOn = true
            end
        end
        if drag.mode == "slide" then
            local edge, along = self:_Resolve(drag.grab + delta)
            if edge ~= self.Edge then
                self.Edge = edge
                self:_OrientHit()
                self:_PaintPill(false)
            end
            self.Along = along
            self.Goal = self:_Anchor(edge, along)
        elseif drag.mode == "swipe" then
            local now = os.clock()
            if now - drag.t0 >= 0.04 then
                drag.vel = drag.vel * 0.5 + ((n - drag.s0) / (now - drag.t0)) * 0.5
                drag.s0, drag.t0 = n, now
            end
            drag.n = n
            local R = n >= 0 and 40 or 12
            self.PeelTarget = (n >= 0 and 1 or -1) * R * (1 - math.exp(-math.abs(n) / R))
            self.Glow.BackgroundTransparency = 0.6 - 0.5 * math.clamp(n / COMMIT, 0, 1)
        end
    end)
    self:_Wake()
    return self
end

function Dock:_Anchor(edge, along)
    local vp = ScreenSize(self.Root)
    local half = self.LH / 2 + 12
    local inset = self.Gap + self.TH / 2
    along = math.clamp(along, 0, 1)
    if edge == "Left" or edge == "Right" then
        local top = half + (self.TopExtra or 0)
        local y = top + along * math.max(0, vp.Y - half - top)
        return Vector2.new(edge == "Left" and inset or vp.X - inset, y)
    end
    local x = half + along * math.max(0, vp.X - half * 2)
    local y = edge == "Top" and (inset + self.TopExtra) or (vp.Y - inset)
    return Vector2.new(x, y)
end

function Dock:_Resolve(p)
    local vp = ScreenSize(self.Root)
    local d = { Left = p.X, Right = vp.X - p.X, Top = p.Y - self.TopExtra, Bottom = vp.Y - p.Y }
    d[self.Edge] = d[self.Edge] - 80
    local best, bestD = self.Edge, math.huge
    for _, edge in ipairs(EdgeList) do
        if d[edge] < bestD then best, bestD = edge, d[edge] end
    end
    local half = self.LH / 2 + 12
    local along
    if best == "Left" or best == "Right" then
        local top = half + self.TopExtra
        along = (p.Y - top) / math.max(1, vp.Y - half - top)
    else
        along = (p.X - half) / math.max(1, vp.X - half * 2)
    end
    return best, math.clamp(along, 0, 1)
end

function Dock:_OrientHit()
    self.Vertical = self.Edge == "Left" or self.Edge == "Right"
    local w, h = self.TH + self.Pad * 2, self.LH + self.Pad * 2
    self.Fab.Size = self.Vertical and UDim2.fromOffset(w, h) or UDim2.fromOffset(h, w)
    self.GlowGradient.Rotation = self.Vertical and 90 or 0
    if self.GlowEntry then self.GlowEntry.Axis = self.Vertical and "Y" or "X" end
end

function Dock:_PaintPill(instant)
    local big = self.Hover or self.Held or self.Open
    local peel = self.Peel or 0
    local T, L = big and self.TH or self.T, (big and self.LH or self.L) + math.abs(peel) * 0.6
    local size = self.Vertical and Vector2.new(T, L) or Vector2.new(L, T)
    local off = EdgeInward[self.Edge] * (-(self.TH - T) / 2 + peel)
    Apply(self.PillHolder, {
        Size = UDim2.fromOffset(size.X, size.Y), Position = UDim2.new(0.5, off.X, 0.5, off.Y),
    }, instant or self.SpringOn, 0.45)
end

function Dock:_Spring(dt)
    local sp = self.PeelSpring
    if not sp then sp = NewSpring(0, 20, 0.7); self.PeelSpring = sp end
    sp.x, sp.v, sp.g = self.Peel or 0, self.PeelVel or 0, self.PeelTarget or 0
    if self.Held then sp.w, sp.z = 36, 1 else sp.w, sp.z = 19, 0.66 end
    local n = math.max(1, math.ceil(dt / (1 / 240)))
    local h, k, c = dt / n, sp.w * sp.w, 2 * sp.z * sp.w
    for _ = 1, n do
        sp.v = sp.v + (-k * (sp.x - sp.g) - c * sp.v) * h
        sp.x = sp.x + sp.v * h
    end
    local settled = not self.Held and math.abs(sp.x - sp.g) < 0.04 and math.abs(sp.v) < 0.4
    if settled then sp.x, sp.v, self.SpringOn = sp.g, 0, false end
    self.Peel, self.PeelVel = sp.x, sp.v
    self:_PaintPill(true)
    if settled then
        self:_PaintPill(false)
        self:_PaintState()
    end
end

function Dock:_PaintState()
    local lit = self.Open
    for _, window in ipairs(Library.Windows) do if window.Visible then lit = true end end
    local awake = self.Hover or self.Held or self.Open or self.Awake
    Tween(self.Glow, { BackgroundTransparency = lit and 0.1 or (awake and 0.55 or 0.84) }, 0.5)
    Tween(self.Pill, { BackgroundTransparency = awake and 0.12 or 0.42 }, 0.35)
    Tween(self.PillStroke, { Transparency = awake and 0.05 or 0.55 }, 0.35)
    Tween(self.Shadow, { ImageTransparency = awake and 0.62 or 0.92 }, 0.35)
end

function Dock:_Wake()
    self.Awake = true
    self.WakeTick = (self.WakeTick or 0) + 1
    local tick = self.WakeTick
    self:_PaintState()
    task.delay(2.4, function()
        if self.WakeTick == tick and self.Awake then
            self.Awake = false
            if self.Root.Gui.Parent then self:_PaintState() end
        end
    end)
end

function Dock:SetEdge(edge, along)
    if not EdgeInward[edge] then return false end
    self.Edge = edge
    if along ~= nil then self.Along = math.clamp(tonumber(along) or 0.5, 0, 1) end
    self:_OrientHit()
    self.Goal = self:_Anchor(self.Edge, self.Along)
    self:_PaintPill(false)
    if self.Open then self:SetOpen(false) end
    self:_Wake()
    return true
end

function Dock:_Click()
    local wins = Library.Windows
    if #wins == 0 then return end
    if #wins == 1 then wins[1]:Toggle() else self:SetOpen(not self.Open) end
end

function Dock:_Reveal(state)
    local wins = Library.Windows
    if #wins == 0 then return end
    if #wins == 1 then
        if state then wins[1]:Show() else wins[1]:Hide() end
    else
        self:SetOpen(state)
    end
end

function Dock:_MakeRow(window)
    local root = self.Root
    local M = root.Metrics
    local frame = Create("TextButton", {
        Name = "Row", Size = UDim2.new(1, 0, 0, self.RowH), BackgroundTransparency = 1, Parent = self.List,
    })
    root:Bind(frame, { BackgroundColor3 = "Hover" })
    root:Round(frame, 0.7)
    local label = Create("TextLabel", {
        Font = Enum.Font.GothamMedium, TextSize = M.Text, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
        Position = UDim2.fromOffset(10, 0), Size = UDim2.new(1, -60, 1, 0), Parent = frame,
    })
    local track = Create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0), Size = UDim2.fromOffset(30, 16), Parent = frame,
    })
    root:Bind(track, { BackgroundColor3 = "Elevated" })
    Create("UICorner", { CornerRadius = UDim.new(1, 0), Parent = track })
    root:Stroke(track, "Stroke", 1, 0.2)
    local fill = Create("Frame", {
        Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Parent = track,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    root:Gradient(fill, "Flow", nil, { Sweep = 1.6, Range = 0.6 })
    local knob = Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 3, 0.5, 0), Size = UDim2.fromOffset(10, 10),
        BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 2, Parent = track,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })

    frame.MouseEnter:Connect(function() Tween(frame, { BackgroundTransparency = 0.6 }, 0.15) end)
    frame.MouseLeave:Connect(function() Tween(frame, { BackgroundTransparency = 1 }, 0.2) end)
    frame.Activated:Connect(function() window:Toggle() end)

    local record = { Frame = frame, Label = label, Fill = fill, Knob = knob }
    self.Rows[window] = record
    return record
end

function Dock:Update()
    local wins = Library.Windows
    local T = self.Root.Theme
    self.Fab.Visible = true

    for window, record in pairs(self.Rows) do
        if not table.find(wins, window) then
            record.Frame:Destroy()
            self.Rows[window] = nil
        end
    end
    local anyHidden = false
    for i, window in ipairs(wins) do
        local record = self.Rows[window] or self:_MakeRow(window)
        record.Frame.LayoutOrder = i
        record.Label.Text = window.TitleLabel.Text
        local on = window.Visible
        if not on then anyHidden = true end
        Tween(record.Label, { TextColor3 = on and T.Text or T.SubText }, 0.2)
        Tween(record.Fill, { BackgroundTransparency = on and 0 or 1 }, 0.25)
        Tween(record.Knob, { Position = UDim2.new(0, on and 17 or 3, 0.5, 0) }, 0.3)
    end
    self.Footer.Text = anyHidden and "Show all" or "Hide all"

    if #wins < 2 and self.Open then self:SetOpen(false) end
    self.PH = 26 + #wins * (self.RowH + 2) + 40
    self.List.Size = UDim2.new(1, -12, 0, #wins * (self.RowH + 2))
    if self.Open then
        Tween(self.Panel, { Size = UDim2.fromOffset(self.PW, self.PH) }, 0.3)
        self:_Place()
    else
        self.Panel.Size = UDim2.fromOffset(self.PW, self.PH)
    end
    self:_PaintState()
end

function Dock:_Place()
    local vp = ScreenSize(self.Root)
    local pw, ph = self.PW, self.PH or 80
    local c = self.Goal
    local gap = self.TH / 2 + self.Gap + 12
    local x, y
    if self.Edge == "Left" then
        x, y = c.X + gap, c.Y - ph / 2
    elseif self.Edge == "Right" then
        x, y = c.X - gap - pw, c.Y - ph / 2
    elseif self.Edge == "Top" then
        x, y = c.X - pw / 2, c.Y + gap
    else
        x, y = c.X - pw / 2, c.Y - gap - ph
    end
    self.Panel.AnchorPoint = Vector2.new(0, 0)
    self.Panel.Position = UDim2.fromOffset(
        math.clamp(x, 8, math.max(8, vp.X - pw - 8)), math.clamp(y, 8, math.max(8, vp.Y - ph - 8))
    )
end

function Dock:SetOpen(state)
    if state == self.Open then return end
    if state and #Library.Windows < 2 then return end
    self.Open = state
    self.Tick = self.Tick + 1
    local tick = self.Tick
    self.Root.Catcher.Visible = state
    if state then
        self:Update()
        self.Panel.Visible = true
        self:_Place()
        Tween(self.Panel, { GroupTransparency = 0 }, 0.28)
        Tween(self.PanelStroke, { Transparency = 0.15 }, 0.28)
        Tween(self.PanelScale, { Scale = 1 }, 0.45, Enum.EasingStyle.Quint)
    else
        Tween(self.Panel, { GroupTransparency = 1 }, 0.2)
        Tween(self.PanelStroke, { Transparency = 1 }, 0.12)
        Tween(self.PanelScale, { Scale = 0.94 }, 0.25)
        task.delay(0.28, function()
            if self.Tick == tick and not self.Open then self.Panel.Visible = false end
        end)
    end
    self:_PaintPill(false)
    self:_PaintState()
end

function Library._DockRefresh(seed)
    local wins = Library.Windows
    local want = false
    for _, w in ipairs(wins) do if w.WantsButton then want = true end end
    local dock = Library.DockObj
    if not want or #wins == 0 then
        if dock and dock.Root.Gui.Parent then
            dock.Fab.Visible = false
            if dock.Open then dock:SetOpen(false) end
        end
        return
    end
    if not dock or not dock.Root.Gui.Parent then
        dock = Dock.new(seed or wins[1])
        Library.DockObj = dock
    end
    dock:Update()
end

local Window = {}
Window.__index = Window

local function Viewport(root)
    local size = root.Gui.AbsoluteSize
    if size.X < 10 or size.Y < 10 then
        local camera = workspace.CurrentCamera
        return camera and camera.ViewportSize or Vector2.new(1280, 720)
    end
    return size
end

local function IconButton(root, parent, position, size, draw, callback)
    local button = Create("TextButton", {
        AnchorPoint = Vector2.new(1, 0.5), Position = position, Size = UDim2.fromOffset(size, size),
        BackgroundTransparency = 1, Parent = parent,
    })
    root:Bind(button, { BackgroundColor3 = "Elevated" })
    root:Round(button, 0.6)
    draw(button)
    button.MouseEnter:Connect(function() Tween(button, { BackgroundTransparency = 0 }, 0.15) end)
    button.MouseLeave:Connect(function() Tween(button, { BackgroundTransparency = 1 }, 0.2) end)
    button.Activated:Connect(callback)
    return button
end

local Transitions = {
    Drop  = { scale = 0.976, drop = -10, reveal = true,  freq = 9.5,  damp = 0.92 },
    Scale = { scale = 0.9,   drop = 0,   reveal = false, freq = 10.5, damp = 0.84 },
    Slide = { scale = 0.99,  drop = -44, reveal = false, freq = 9,    damp = 0.94 },
    Fade  = { scale = 1,     drop = 0,   reveal = false, freq = 12,   damp = 1 },
}
Library.Transitions = Transitions

function Library:CreateWindow(opts)
    opts = opts or {}
    local root = Root.new(opts)
    local M, T = root.Metrics, root.Theme
    local self = setmetatable({}, Window)
    self.Root, self.Order, self.Tick = root, 0, 0
    self.Visible, self.Collapsed = false, false
    self.ToggleKey = opts.ToggleKey or Enum.KeyCode.RightShift
    root.Animating = false
    if opts.Font then
        local ok, err = Library:SetFont(opts.Font, { Name = opts.FontName, Bold = opts.FontBold })
        if not ok then warn("[Velor] font: " .. tostring(err)) end
    end

    local viewport = Viewport(root)
    local width = math.min(opts.Width or (opts.Size and opts.Size.X) or M.Width, viewport.X - 16)
    local maxHeight = opts.MaxHeight or (root.Mobile and math.min(380, viewport.Y - 120) or 420)
    self.Width, self.MaxHeight = width, math.max(120, maxHeight)
    self.BaseY = root.Mobile and 58 or 64
    self.H, self.ContentH = M.Title, 0

    local holder = Create("Frame", {
        Name = "Window", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, self.BaseY), Size = UDim2.fromOffset(width, M.Title + 1), Visible = false,
        ZIndex = 1, Parent = root.Gui,
    })
    self.Holder = holder
    self.TransitionName = Transitions[opts.Transition] and opts.Transition or "Drop"
    self.Scale = Create("UIScale", { Scale = Transitions[self.TransitionName].scale, Parent = holder })

    local main = Create("CanvasGroup", {
        Name = "Main", Size = UDim2.fromScale(1, 1), GroupTransparency = 1, ZIndex = 1, Parent = holder,
    })
    root:Bind(main, { BackgroundColor3 = "Background" })
    main.BackgroundTransparency = root.Alpha.Main
    root:Round(main, 1)
    self.Main = main

    self.Glare = Create("Frame", {
        Name = "Glare", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 2, Parent = main,
    })
    self.GlareGradient = Create("UIGradient", { Rotation = 28, Parent = self.Glare })
    root:Animate(self.GlareGradient, { Sweep = 0.22, Range = 0.95 })
    self.Reflective, self.ReflectStrength = true, 1

    do
        local function layer(name, kind, rotation, fade, anim)
            local frame = Create("Frame", {
                Name = name, Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 0, Parent = main,
            })
            root:Gradient(frame, kind, {
                Rotation = rotation, Transparency = NumberSequence.new({
                    NumberSequenceKeypoint.new(0, fade[1]), NumberSequenceKeypoint.new(0.5, fade[2]), NumberSequenceKeypoint.new(1, fade[3]),
                }),
            }, anim)
        end
        layer("AuroraA", "Flow", 115, { 0.8, 0.92, 0.86 }, { Sweep = 0.7, Range = 0.7, Spin = 12, Base = 115 })
        layer("AuroraB", "Soft", 65, { 0.9, 0.84, 0.94 }, { Sweep = -0.45, Range = 0.9, Phase = 1.7, Spin = -8, Base = 65 })
        layer("AuroraC", "Flow", 200, { 0.93, 0.88, 0.8 }, { Sweep = 0.3, Range = 0.8, Phase = 3.1, Spin = 5, Base = 200 })
    end

    self.FrameLayers = {}
    local function frameLayer(name, inset, mult, thickness, on, kind, anim, props)
        local holderFrame = Create("Frame", {
            Name = name, BackgroundTransparency = 1, Position = UDim2.fromOffset(inset, inset),
            Size = UDim2.new(1, -inset * 2, 1, -inset * 2), ZIndex = 4, Parent = holder,
        })
        root:Round(holderFrame, mult)
        local stroke = Create("UIStroke", {
            Thickness = thickness, Transparency = 1, Color = Color3.new(1, 1, 1),
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = holderFrame,
        })
        local gradient
        if kind then
            gradient = root:Gradient(stroke, kind, props, anim)
        else
            gradient = Create("UIGradient", { Parent = stroke })
            for key, value in pairs(props or {}) do gradient[key] = value end
            if anim then root:Animate(gradient, anim) end
        end
        local layer = { Frame = holderFrame, Stroke = stroke, Gradient = gradient, On = on, Base = on }
        self.FrameLayers[#self.FrameLayers + 1] = layer
        return layer
    end
    local function ramp(...)
        local points, args = {}, { ... }
        for i = 1, #args, 2 do points[#points + 1] = NumberSequenceKeypoint.new(args[i], args[i + 1]) end
        return NumberSequence.new(points)
    end

    self.BorderStroke = frameLayer("Border", 0, 1, 1.5, 0.04, "Metal", { Spin = 16 }).Stroke

    self.RimStroke = frameLayer("Rim", 2, 0.86, 1, 0.55, "Rim", { Spin = 40 }).Stroke

    self.FrameGlare = frameLayer("FrameGlare", 0, 1, 2.25, 0.08, nil, { Spin = 52, Base = 20 }, {
        Rotation = 20, Transparency = ramp(0, 1, 0.38, 1, 0.47, 0.5, 0.5, 0.08, 0.53, 0.5, 0.62, 1, 1, 1),
    })
    self.FrameGlare2 = frameLayer("FrameGlare2", 0, 1, 1.5, 0.4, nil, { Spin = -31, Base = 200 }, {
        Rotation = 200, Transparency = ramp(0, 1, 0.42, 1, 0.5, 0.35, 0.58, 1, 1, 1),
    })

    self.FrameGlints = frameLayer("FrameGlints", 0, 1, 2, 0.1, nil, nil, {
        Rotation = 45, Transparency = ramp(0, 0, 0.14, 0.7, 0.3, 1, 0.7, 1, 0.86, 0.8, 1, 0.3),
    })

    self.FrameBevel = frameLayer("FrameBevel", 2.5, 0.84, 1, 0.35, nil, nil, {
        Rotation = 90,
        Color = ColorSequence.new({ KP(0, Color3.new(1, 1, 1)), KP(0.45, Color3.new(1, 1, 1)), KP(0.55, Color3.fromRGB(20, 20, 28)), KP(1, Color3.fromRGB(20, 20, 28)) }),
        Transparency = ramp(0, 0, 0.3, 0.7, 0.5, 1, 0.75, 0.82, 1, 0.5),
    })
    local inner = Create("Frame", {
        Name = "InnerEdge", BackgroundTransparency = 1, Position = UDim2.fromOffset(3, 3), Size = UDim2.new(1, -6, 1, -6), ZIndex = 1, Parent = main,
    })
    root:Round(inner, 0.8)
    Create("UIStroke", { Thickness = 1, Transparency = 0.9, Color = Color3.new(1, 1, 1), ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Parent = inner })

    local titlebar = Create("Frame", {
        Name = "TitleBar", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, M.Title), Active = true, Parent = main,
    })
    local strip = Create("Frame", {
        Name = "SteelStrip", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.9, ZIndex = 0, Parent = titlebar,
    })
    root:Gradient(strip, "Metal", { Rotation = 0, Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.55), NumberSequenceKeypoint.new(0.5, 0.8), NumberSequenceKeypoint.new(1, 0.6),
    }) }, { Sweep = 0.35, Range = 0.25 })
    local logo = Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 14, 0.5, 0), Size = UDim2.fromOffset(12, 12),
        BackgroundColor3 = Color3.new(1, 1, 1), Parent = titlebar,
    })
    root:Round(logo, 0.4)
    root:Gradient(logo, "Soft", nil, { Spin = 90, Base = 0 })
    local logoRing = Create("UIStroke", { Thickness = 3, Transparency = 0.78, Color = Color3.new(1, 1, 1), Parent = logo })
    root:Gradient(logoRing, "Soft", nil, { Spin = -90, Base = 0 })

    local hasSubtitle = opts.Subtitle ~= nil and opts.Subtitle ~= ""
    self.TitleLabel = Create("TextLabel", {
        Text = tostring(opts.Title or "Vélor"), Font = Enum.Font.GothamBold, TextSize = M.Text + 1,
        TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.new(0, 34, 0, hasSubtitle and 6 or 0),
        Size = UDim2.new(1, -112, 0, hasSubtitle and 18 or M.Title), Fit = true, Parent = titlebar,
    })
    root:Bind(self.TitleLabel, { TextColor3 = "Text" })
    if hasSubtitle then
        local sub = Create("TextLabel", {
            Text = tostring(opts.Subtitle), TextSize = M.Text - 3, TextXAlignment = Enum.TextXAlignment.Left,
            Position = UDim2.new(0, 34, 0, M.Title - 19), Size = UDim2.new(1, -112, 0, 14), Fit = true, Parent = titlebar,
        })
        root:Bind(sub, { TextColor3 = "SubText" })
    end

    local btn = M.Title - 14
    IconButton(root, titlebar, UDim2.new(1, -8, 0.5, 0), btn, function(b)
        Bar(root, b, btn / 2, btn / 2, 11, 2, 45, "SubText")
        Bar(root, b, btn / 2, btn / 2, 11, 2, -45, "SubText")
    end, function() self:Hide() end)
    self.CollapseBtn = IconButton(root, titlebar, UDim2.new(1, -8 - btn - 4, 0.5, 0), btn, function(b)
        local holderC = Create("Frame", {
            BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(14, 14), Parent = b,
        })
        self.CollapseIcon = holderC
        Bar(root, holderC, 4.6, 7, 7, 2, 45, "SubText")
        Bar(root, holderC, 9.4, 7, 7, 2, -45, "SubText")
        holderC.Rotation = 180
    end, function() self:SetCollapsed(not self.Collapsed) end)

    local divider = Create("Frame", {
        Name = "Divider", Position = UDim2.new(0, 0, 0, M.Title), Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = Color3.new(1, 1, 1), Parent = main,
    })
    root:Gradient(divider, "Flow", {
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.45), NumberSequenceKeypoint.new(1, 1),
        }),
    }, { Sweep = 0.9, Range = 0.55 })

    local content = Create("ScrollingFrame", {
        Name = "Content", Position = UDim2.fromOffset(0, M.Title + 1), Size = UDim2.new(1, 0, 1, -(M.Title + 1)),
        CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2,
        ScrollingDirection = Enum.ScrollingDirection.Y, Parent = main,
    })
    root:Bind(content, { ScrollBarImageColor3 = "Muted" })
    local layout = Create("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, Parent = content })
    Pad(content, 10, 10, 10, 12)
    self.Content = content
    local function measure()
        self.ContentH = layout.AbsoluteContentSize.Y + 18
    end
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(measure)

    local tr = Transitions[self.TransitionName]
    self.Spring = NewSpring(0, tr.freq, tr.damp)
    local move = { x = 0, y = 0, gx = 0, gy = 0 }
    local drop = { v = tr.drop }
    self.Move, self.Drop = move, drop
    local first = true
    local function clampMove(gx, gy)
        local vp = Viewport(root)
        local w = holder.Size.X.Offset
        gx = math.clamp(gx, 60 - w / 2 - vp.X / 2, vp.X / 2 - 60 + w / 2)
        gy = math.clamp(gy, -self.BaseY, vp.Y - self.BaseY - M.Title)
        return gx, gy
    end
    root:Connect(RunService.RenderStepped, function(dt)
        local sp = self.Spring
        local active = self.Visible or not SpringRest(sp) or sp.x > 0.0006
        if not active and not first then return end
        dt = math.min(dt, 1 / 20)
        measure()

        local settled = SpringRest(sp)
        if not settled then
            StepSpring(sp, dt)
            if sp.g == 0 and sp.x < 0.004 then sp.x, sp.v = 0, 0 end
            if SpringRest(sp) then sp.x, sp.v = sp.g, 0 end
        end
        local p = sp.x
        local reach = math.clamp(p, 0, 1)
        local fade = Smooth(reach / 0.55)

        if not self.Visible and p <= 0 and holder.Visible and not first then
            holder.Visible = false
            root.Animating = false
            return
        end

        local target = self.Collapsed and M.Title or (self.FixedH or (M.Title + 1 + math.min(self.ContentH, self.MaxHeight)))
        if first and self.ContentH > 18 then self.H, first = target, false end
        local hs = self.HSpring
        if not hs then hs = NewSpring(self.H, 15, 1); self.HSpring = hs end
        hs.x, hs.g = self.H, target
        if math.abs(target - self.H) < 0.25 and math.abs(hs.v) < 3 then
            self.H, hs.v = target, 0
        else
            StepSpring(hs, dt)
            self.H = hs.x
        end
        local reveal = Transitions[self.TransitionName].reveal and math.clamp(p, 0, 1.025) or 1
        local h = math.floor(M.Title + (self.H - M.Title) * reveal + 0.5)
        if holder.Size.Y.Offset ~= h then holder.Size = UDim2.fromOffset(holder.Size.X.Offset, h) end

        local style = Transitions[self.TransitionName]
        local scale = style.scale + (1 - style.scale) * p
        if self.Scale.Scale ~= scale then self.Scale.Scale = scale end
        drop.v = style.drop * (1 - p)
        local want = 1 - fade
        if self.Main.GroupTransparency ~= want then self.Main.GroupTransparency = want end
        for _, layer in ipairs(self.FrameLayers) do
            local t = 1 - (1 - layer.On) * fade
            if layer.Frame.Visible and layer.Stroke.Transparency ~= t then layer.Stroke.Transparency = t end
        end

        local alpha = 1 - math.exp(-dt * 30)
        move.x = move.x + (move.gx - move.x) * alpha
        move.y = move.y + (move.gy - move.y) * alpha
        if math.abs(move.gx - move.x) < 0.05 then move.x = move.gx end
        if math.abs(move.gy - move.y) < 0.05 then move.y = move.gy end
        holder.Position = UDim2.new(0.5, move.x, 0, self.BaseY + move.y + drop.v)
    end)

    local drag = { active = false }
    titlebar.InputBegan:Connect(function(input)
        if not IsPointerDown(input) then return end
        drag.active, drag.start, drag.gx, drag.gy = true, input.Position, move.gx, move.gy
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                drag.active = false
                connection:Disconnect()
            end
        end)
    end)
    root:Connect(UserInputService.InputChanged, function(input)
        if drag.active and IsPointerMove(input) then
            local delta = input.Position - drag.start
            move.gx, move.gy = clampMove(drag.gx + delta.X, drag.gy + delta.Y)
        end
    end)

    self.Resizable = opts.Resizable ~= false
    self.MinW, self.MinH = opts.MinWidth or 220, opts.MinHeight or (M.Title + 90)
    self.DefaultW = width
    local gripSize = M.Knob - 14
    local grip = Create("TextButton", {
        Name = "Grip", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -4, 1, -4), Size = UDim2.fromOffset(gripSize, gripSize),
        ZIndex = 8, Visible = self.Resizable, Parent = holder,
    })
    Bar(root, grip, gripSize - 4, gripSize - 4, 4, 1.5, -45, "Muted")
    Bar(root, grip, gripSize - 8, gripSize - 8, 9, 1.5, -45, "Muted")
    Bar(root, grip, gripSize - 12, gripSize - 12, 14, 1.5, -45, "Muted")
    self.Grip = grip
    local rs = { active = false, last = 0 }
    grip.InputBegan:Connect(function(input)
        if not IsPointerDown(input) then return end
        if os.clock() - rs.last < 0.35 then self:ResetSize() rs.last = 0 return end
        rs.last = os.clock()
        rs.active, rs.start, rs.w, rs.h = true, input.Position, self.Width, holder.Size.Y.Offset
        local connection
        connection = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                rs.active = false
                connection:Disconnect()
            end
        end)
    end)
    root:Connect(UserInputService.InputChanged, function(input)
        if rs.active and IsPointerMove(input) then
            local delta = input.Position - rs.start
            self:SetSize(rs.w + delta.X, rs.h + delta.Y)
        end
    end)

    root:Connect(UserInputService.InputBegan, function(input, processed)
        if processed then return end
        if input.KeyCode == self.ToggleKey then self:Toggle() end
    end)

    local want = opts.Swipebar
    if want == nil then want = opts.ToggleButton end
    if want == nil and opts.MobileButton == false then want = false end
    if want == nil then want = true end
    if type(want) == "table" then self.SwipeCfg, want = want, true end
    self.WantsButton = want == true
    Library.Windows[#Library.Windows + 1] = self
    root.Gui.Destroying:Connect(function()
        local list = Library.Windows
        for i = #list, 1, -1 do if list[i] == self then table.remove(list, i) end end
        pcall(Library._DockRefresh)
    end)

    self:SetReflective(opts.Reflective ~= false, opts.ReflectStrength)
    if not opts.Hidden then self:Show() end
    Library._DockRefresh(self)
    return self
end

function Window:Show()
    if self.Visible then return end
    self.Visible = true
    local style = Transitions[self.TransitionName]
    local sp = self.Spring
    sp.g, sp.w, sp.z = 1, style.freq, style.damp
    self.Root.Animating = true
    self.Holder.Visible = true
    if Library._DockRefresh then pcall(Library._DockRefresh) end
end

function Window:Hide()
    if not self.Visible then return end
    self.Visible = false
    self.Root:CloseDropdown()

    local sp = self.Spring
    sp.g, sp.w, sp.z = 0, 15, 1
    if Library._DockRefresh then pcall(Library._DockRefresh) end
end

function Window:SetTransition(name)
    if not Transitions[name] then return false end
    self.TransitionName = name
    local style = Transitions[name]
    if self.Visible then self.Spring.w, self.Spring.z = style.freq, style.damp end
    return true
end

function Window:Toggle()
    if self.Visible then self:Hide() else self:Show() end
end

function Window:SetCollapsed(state)
    if state == self.Collapsed then return end
    self.Collapsed = state
    self.Grip.Visible = self.Resizable and not state
    self.Root:CloseDropdown()
    Tween(self.CollapseIcon, { Rotation = state and 0 or 180 }, 0.45)
end

function Window:SetSize(w, h)
    local vp = Viewport(self.Root)
    local M = self.Root.Metrics
    w = math.clamp(w or self.Width, self.MinW, vp.X - 16)
    h = math.clamp(h or self.Holder.Size.Y.Offset, self.MinH, math.max(self.MinH, vp.Y - self.BaseY - 12))
    local dw = w - self.Width
    self.Width, self.FixedH = w, h
    self.Move.gx, self.Move.x = self.Move.gx + dw / 2, self.Move.x + dw / 2
    self.Holder.Position = UDim2.new(0.5, self.Move.x, 0, self.BaseY + self.Move.y + self.Drop.v)
    self.Holder.Size = UDim2.fromOffset(w, math.floor(h + 0.5))
    self.H = h
end

function Window:ResetSize()
    local dw = self.DefaultW - self.Width
    self.FixedH = nil
    self.Width = self.DefaultW
    self.Move.gx, self.Move.x = self.Move.gx + dw / 2, self.Move.x + dw / 2
    self.Holder.Position = UDim2.new(0.5, self.Move.x, 0, self.BaseY + self.Move.y + self.Drop.v)
    self.Holder.Size = UDim2.fromOffset(self.Width, self.Holder.Size.Y.Offset)
end

function Window:SetResizable(state)
    self.Resizable = state ~= false
    self.Grip.Visible = self.Resizable and not self.Collapsed
end

function Window:SetFont(font, opts) return Library:SetFont(font, opts) end

function Window:SetToggleKey(key) self.ToggleKey = key end
function Window:SetTitle(text)
    self.TitleLabel.Text = tostring(text)
    pcall(Library._DockRefresh)
end

function Window:SetSwipebar(state)
    if type(state) == "table" then
        self.SwipeCfg = state
        local dock = Library.DockObj
        if dock and dock.Root.Gui.Parent and state.Edge then dock:SetEdge(state.Edge, state.Along) end
        state = true
    end
    self.WantsButton = state == true
    pcall(Library._DockRefresh, self)
end
Window.SetToggleButton = Window.SetSwipebar

function Window:SetReflective(state, strength)
    self.Reflective = state ~= false
    if strength then self.ReflectStrength = math.clamp(strength, 0, 1.5) end
    local k = self.ReflectStrength
    local function t(v) return math.clamp(1 - (1 - v) * k, 0, 1) end

    self.GlareGradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.3, 1), NumberSequenceKeypoint.new(0.4, t(0.95)),
        NumberSequenceKeypoint.new(0.47, t(0.9)), NumberSequenceKeypoint.new(0.5, t(0.93)), NumberSequenceKeypoint.new(0.535, t(0.8)),
        NumberSequenceKeypoint.new(0.55, t(0.93)), NumberSequenceKeypoint.new(0.575, t(0.88)), NumberSequenceKeypoint.new(0.6, 1),
        NumberSequenceKeypoint.new(1, 1),
    })
    self.Glare.Visible = self.Reflective and k > 0

    for _, layer in ipairs({ self.FrameGlare, self.FrameGlare2, self.FrameGlints, self.FrameBevel }) do
        layer.Frame.Visible = self.Reflective and k > 0
        layer.On = math.clamp(1 - (1 - layer.Base) * math.min(k, 1.5), 0, 1)
    end
    if self.Spring and SpringRest(self.Spring) then
        local fade = Smooth(math.clamp(self.Spring.x, 0, 1) / 0.55)
        for _, layer in ipairs(self.FrameLayers) do layer.Stroke.Transparency = 1 - (1 - layer.On) * fade end
    end
end

function Window:SetTheme(name)
    if Library.DockObj then Library.DockObj.Root:SetTheme(name) end
    return self.Root:SetTheme(name)
end
function Window:SetCorner(name)
    if Library.DockObj then Library.DockObj.Root:SetCorner(name) end
    return self.Root:SetCorner(name)
end
function Window:Notify(opts) self.Root:Notify(opts) end

function Window:Dialog(opts) return self.Root:Dialog(opts) end

function Window:Confirm(title, content, callback, opts)
    opts = opts or {}
    local done = false
    local function answer(value) if not done then done = true Fire("confirm", title, callback, value) end end
    return self.Root:Dialog({
        Title = title, Content = content, Type = opts.Type or "Warning", RichText = opts.RichText,
        Buttons = {
            { Name = opts.Cancel or "Cancel", Callback = function() answer(false) end },
            { Name = opts.Confirm or "Confirm", Style = opts.Danger and "Danger" or "Accent", Callback = function() answer(true) end },
        },
        OnClose = function() answer(false) end,
    })
end

function Window:Prompt(title, content, callback, opts)
    opts = opts or {}
    local done = false
    local function answer(value) if not done then done = true Fire("prompt", title, callback, value) end end
    return self.Root:Dialog({
        Title = title, Content = content, Type = opts.Type or "Info", Input = { Placeholder = opts.Placeholder, Default = opts.Default },
        Buttons = {
            { Name = opts.Cancel or "Cancel", Callback = function() answer(nil) end },
            { Name = opts.Confirm or "OK", Style = "Accent", Callback = function(text) answer(text) end },
        },
        OnClose = function() answer(nil) end,
    })
end
function Window:Destroy() self.Root:Destroy() end

function Window:AddConfigSection(opts)
    opts = opts or {}
    local section = self:AddSection(opts.Title or "Configuration", { Collapsed = opts.Collapsed })
    local autoload = Library:GetAutoload()
    local input = section:AddInput({ Name = "Name", Placeholder = "config name", Default = autoload or "default" })
    local list
    local function refresh() list:Refresh(Library:ListConfigs(), true) end
    list = section:AddDropdown({
        Name = "Saved", Options = Library:ListConfigs(), Placeholder = "Select a config", Search = true,
        Callback = function(value) if value then input:Set(value, true) end end,
    })
    local function report(ok, err, good)
        self:Notify({
            Title = "Config", Content = ok and good or tostring(err), Type = ok and "Success" or "Error", Duration = 3,
        })
    end
    section:AddButton({ Name = "Save config", Style = "Accent", Callback = function()
        local ok, err = Library:SaveConfig(input:Get())
        report(ok, err, "Saved '" .. tostring(input:Get()) .. "'")
        if ok then refresh() end
    end })
    section:AddButton({ Name = "Load config", Callback = function()
        local ok, err = Library:LoadConfig(input:Get())
        report(ok, err, "Loaded '" .. tostring(input:Get()) .. "'")
    end })
    section:AddButton({ Name = "Delete config", Callback = function()
        local ok, err = Library:DeleteConfig(input:Get())
        report(ok, err, "Deleted '" .. tostring(input:Get()) .. "'")
        if ok then refresh() end
    end })
    section:AddButton({ Name = "Refresh list", Callback = refresh })
    section:AddToggle({ Name = "Autoload this config", Default = autoload ~= nil, Callback = function(on)
        local ok, err = Library:SetAutoload(on and input:Get() or nil)
        if not ok then report(false, err) end
    end })
    return section
end

function Window:AddInterfaceSection(opts)
    opts = opts or {}
    local section = self:AddSection(opts.Title or "Interface", { Collapsed = opts.Collapsed })
    local themes = {}
    for name in pairs(Library.Themes) do themes[#themes + 1] = name end
    table.sort(themes)
    section:AddDropdown({ Name = "Theme", Options = themes, Default = self.Root.ThemeName, Flag = opts.ThemeFlag or "UI_Theme",
        Callback = function(name) Library:SetTheme(name) end })
    section:AddSegmented({ Name = "Corners", Options = { "Rounded", "Soft", "Sharp", "Square" }, Default = self.Root.CornerName,
        Flag = opts.CornerFlag or "UI_Corner", Callback = function(name) Library:SetCorner(name) end })
    section:AddSegmented({ Name = "Transition", Options = { "Drop", "Scale", "Slide", "Fade" }, Default = self.TransitionName,
        Flag = opts.TransitionFlag or "UI_Transition", Callback = function(name) self:SetTransition(name) end })
    local fontDropdown = section:AddDropdown({ Name = "Font", Options = Library:GetFonts(), Default = Library:GetFont(),
        Callback = function(name)
            local ok, err = Library:SetFont(name)
            if not ok then self:Notify({ Title = "Font", Content = tostring(err), Type = "Error" }) end
        end })
    local fontUrl = ""
    section:AddInput({ Name = "Custom font", Placeholder = "URL to a .ttf / .otf", Callback = function(text) fontUrl = tostring(text or "") end })
    section:AddButton({ Name = "Apply custom font", Callback = function()
        if fontUrl == "" then return end
        local name = fontUrl:match("([^/\\]+)%.%a+[%?#]?.*$") or "Custom"
        local ok, err = Library:SetFont(fontUrl, { Name = name })
        if ok then
            fontDropdown:Refresh(Library:GetFonts(), true)
            fontDropdown:Set(name, true)
        end
        self:Notify({ Title = "Font", Content = ok and ("Applied " .. name) or tostring(err), Type = ok and "Success" or "Error" })
    end })
    section:AddKeybind({ Name = "Menu key", Default = self.ToggleKey, Flag = opts.KeyFlag or "UI_MenuKey",
        Callback = function(key) if key then self:SetToggleKey(key) end end })
    section:AddToggle({ Name = "Swipebar", Default = self.WantsButton, Flag = opts.ButtonFlag or "UI_Swipebar",
        Callback = function(on) self:SetSwipebar(on) end })
    section:AddSegmented({ Name = "Swipebar edge", Options = { "Left", "Right", "Top", "Bottom" },
        Default = (Library.DockObj and Library.DockObj.Edge) or (self.SwipeCfg and self.SwipeCfg.Edge) or "Bottom",
        Flag = opts.EdgeFlag or "UI_SwipebarEdge",
        Callback = function(edge) if Library.DockObj then Library.DockObj:SetEdge(edge) end end })
    section:AddDivider()
    section:AddButton({ Name = "Unload UI", Callback = function() Library:Destroy() end })
    return section
end

local function Commas(n)
    local text = tostring(math.floor(tonumber(n) or 0))
    local out = text:reverse():gsub("(%d%d%d)", "%1,"):reverse()
    return (out:gsub("^,", ""))
end

local function SetClipboard(text)
    local fn = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
    if not fn then return false end
    return pcall(fn, text)
end

function Window:AddDiscord(title, desc, invite)
    local opts = type(title) == "table" and title or { Title = title, Desc = desc, Invite = invite }
    local root, M = self.Root, self.Root.Metrics
    self.Order = self.Order + 1
    local code = tostring(opts.Invite or ""):match("discord%.gg/([%w%-_]+)") or tostring(opts.Invite or ""):match("discord%.com/invite/([%w%-_]+)")
        or tostring(opts.Invite or ""):match("^([%w%-_]+)$")
    local link = code and ("https://discord.gg/" .. code) or nil

    local frame = Create("Frame", {
        Name = "Discord", Size = UDim2.new(1, 0, 0, 62), LayoutOrder = self.Order, Parent = self.Content,
    })
    root:Bind(frame, { BackgroundColor3 = "Surface" })
    frame.BackgroundTransparency = root.Alpha.Section
    root:Round(frame, 0.8)
    root:Stroke(frame, "Stroke", 1, 0.3)

    local icon = Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0), Size = UDim2.fromOffset(40, 40),
        BackgroundColor3 = Color3.new(1, 1, 1), ClipsDescendants = true, Parent = frame,
    })
    Create("UICorner", { CornerRadius = UDim.new(0, 12), Parent = icon })
    root:Gradient(icon, "Soft", { Rotation = 45 })
    local letter = Create("TextLabel", {
        Text = "D", Font = Enum.Font.GothamBold, TextSize = 18, Size = UDim2.fromScale(1, 1), Parent = icon,
    })
    root:Bind(letter, { TextColor3 = "OnAccent" })
    local image = Create("ImageLabel", { Size = UDim2.fromScale(1, 1), ImageTransparency = 1, ZIndex = 2, Parent = icon })

    local nameLabel = Create("TextLabel", {
        Text = tostring(opts.Title or "Discord"), Font = Enum.Font.GothamBold, TextSize = M.Text, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(60, 9), Size = UDim2.new(1, -140, 0, 16), Parent = frame,
    })
    root:Bind(nameLabel, { TextColor3 = "Text" })
    local descLabel = Create("TextLabel", {
        Text = tostring(opts.Desc or ""), TextSize = M.Text - 3, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(60, 26), Size = UDim2.new(1, -140, 0, 14), Parent = frame,
    })
    root:Bind(descLabel, { TextColor3 = "SubText" })
    local stats = Create("TextLabel", {
        Text = link and "Contacting Discord..." or "No invite set", TextSize = M.Text - 3, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.fromOffset(60, 41), Size = UDim2.new(1, -140, 0, 14), Parent = frame,
    })
    root:Bind(stats, { TextColor3 = "Muted" })

    local join = Create("TextButton", {
        BackgroundTransparency = 1, ClipsDescendants = true,
        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -10, 0.5, 0), Size = UDim2.fromOffset(62, M.Field), Parent = frame,
    })
    root:Round(join, 0.6)
    local joinLabel = AccentFill(root, join, "Join", M.Text - 1)

    local card = { Frame = frame, Invite = link }
    local resetTick = 0
    join.Activated:Connect(function()
        if not card.Invite then return end
        local ok = SetClipboard(card.Invite)
        joinLabel.Text = ok and "Copied" or "No clip"
        resetTick = resetTick + 1
        local tick = resetTick
        self:Notify({ Title = "Discord", Content = ok and "Invite link copied to your clipboard." or card.Invite, Type = ok and "Success" or "Info", Duration = 3 })
        task.delay(1.6, function() if resetTick == tick and join.Parent then joinLabel.Text = "Join" end end)
    end)

    function card:Refresh()
        if not self.Invite then return end
        task.spawn(function()
            local code2 = self.Invite:match("([%w%-_]+)$")
            local body, err = Http("https://discord.com/api/v10/invites/" .. code2 .. "?with_counts=true")
            local ok, data = pcall(function() return HttpService:JSONDecode(body or "") end)
            if not body or not ok or type(data) ~= "table" or not data.guild then
                if frame.Parent then stats.Text = body and "Invite not found" or ("Couldn't reach Discord" .. (err and (" (" .. err .. ")") or "")) end
                return
            end
            if not frame.Parent then return end
            local guild = data.guild
            if not opts.Title or opts.Title == "" then nameLabel.Text = tostring(guild.name) end
            if (not opts.Desc or opts.Desc == "") and guild.description then descLabel.Text = tostring(guild.description) end
            letter.Text = tostring(guild.name or "D"):sub(1, 1):upper()
            stats.Text = ("%s members  \xC2\xB7  %s online"):format(Commas(data.approximate_member_count), Commas(data.approximate_presence_count))
            root:Bind(stats, { TextColor3 = "SubText" })
            stats.TextColor3 = root.Theme.SubText
            if guild.icon and writefile and (getcustomasset or getsynasset) then
                local icon_url = ("https://cdn.discordapp.com/icons/%s/%s.png?size=128"):format(guild.id, guild.icon)
                EnsureFolder("Velor"); EnsureFolder("Velor/cache")
                local path = ("Velor/cache/discord_%s_%s.png"):format(guild.id, guild.icon)
                if not (isfile and isfile(path)) then
                    local bytes = Http(icon_url)
                    if bytes then pcall(writefile, path, bytes) end
                end
                local asset = (isfile and isfile(path)) and AssetOf(path)
                if asset and frame.Parent then
                    image.Image = asset
                    letter.Visible = false
                    Tween(image, { ImageTransparency = 0 }, 0.35)
                end
            end
        end)
    end
    function card:SetInvite(value)
        local c = tostring(value):match("discord%.gg/([%w%-_]+)") or tostring(value):match("discord%.com/invite/([%w%-_]+)") or tostring(value):match("^([%w%-_]+)$")
        self.Invite = c and ("https://discord.gg/" .. c) or nil
        self:Refresh()
    end
    function card:Destroy() frame:Destroy() end
    card:Refresh()
    return card
end

function Window:AddSection(title, sopts)
    sopts = sopts or {}
    local root, M = self.Root, self.Root.Metrics
    self.Order = self.Order + 1

    local frame = Create("Frame", {
        Name = "Section", Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        LayoutOrder = self.Order, Parent = self.Content,
    })

    frame.BackgroundColor3 = Color3.new(1, 1, 1)
    root:Gradient(frame, "Pane", { Rotation = 90 })
    frame.BackgroundTransparency = root.Alpha.Section
    root:Round(frame, 0.8)
    local cardStroke = root:Stroke(frame, "Stroke", 1, 0.2)
    Create("UIGradient", { Rotation = 90, Parent = cardStroke, Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.4, 0.45), NumberSequenceKeypoint.new(1, 0.85),
    }) })
    Pad(frame, M.Pad, 5, M.Pad, 8)
    Create("UIListLayout", { Padding = UDim.new(0, 0), SortOrder = Enum.SortOrder.LayoutOrder, Parent = frame })

    local section = setmetatable({
        Root = root, Clip = self.Content, Order = 0, Expanded = sopts.Collapsed ~= true,
        Collapsible = sopts.Collapsible ~= false,
    }, Section)

    local header = Create("TextButton", {
        Name = "Header", Size = UDim2.new(1, 0, 0, M.Header), LayoutOrder = 0, Parent = frame,
    })
    Create("Frame", {
        Name = "Highlight", Size = UDim2.new(1, 2 * M.Pad - 16, 0, 1), Position = UDim2.fromOffset(-(M.Pad - 8), -4),
        BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.88, ZIndex = 2, Parent = header,
    }, { Create("UIGradient", { Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1),
    }) }) })
    local accent = Create("Frame", {
        AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.fromOffset(3, 12),
        BackgroundColor3 = Color3.new(1, 1, 1), Parent = header,
    }, { Create("UICorner", { CornerRadius = UDim.new(1, 0) }) })
    root:Gradient(accent, "Soft", { Rotation = 90 })
    local text = Create("TextLabel", {
        Text = tostring(title or "Section"), Font = Enum.Font.GothamBold, TextSize = M.Text - 2,
        TextXAlignment = Enum.TextXAlignment.Left, Position = UDim2.fromOffset(12, 0), Size = UDim2.new(1, -40, 1, 0),
        Fit = true, Parent = header,
    })
    root:Bind(text, { TextColor3 = "SubText" })
    header.MouseEnter:Connect(function()
        Tween(text, { TextColor3 = root.Theme.Text }, 0.15)
        Tween(accent, { Size = UDim2.fromOffset(3, 18) }, 0.3, Enum.EasingStyle.Back)
    end)
    header.MouseLeave:Connect(function()
        Tween(text, { TextColor3 = root.Theme.SubText }, 0.2)
        Tween(accent, { Size = UDim2.fromOffset(3, 12) }, 0.25)
    end)

    local chevron = Create("Frame", {
        BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -2, 0.5, 0),
        Size = UDim2.fromOffset(14, 14), Rotation = section.Expanded and 180 or 0, Parent = header,
    })
    Bar(root, chevron, 4.6, 7, 7, 2, 45, "Muted")
    Bar(root, chevron, 9.4, 7, 7, 2, -45, "Muted")
    section.ChevronHolder = chevron
    chevron.Visible = section.Collapsible

    local clipper = Create("Frame", {
        Name = "Clipper", BackgroundTransparency = 1, ClipsDescendants = true, LayoutOrder = 1,
        Size = UDim2.new(1, 0, 0, 0), Parent = frame,
    })
    local body = Create("Frame", {
        Name = "Body", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        Parent = clipper,
    })
    Create("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, Parent = body })
    section.Body, section.Clipper = body, clipper
    section.Frame = frame

    body:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        if section.Expanded and os.clock() > (section.Animating or 0) then
            clipper.Size = UDim2.new(1, 0, 0, body.AbsoluteSize.Y)
        end
    end)
    if section.Collapsible then
        header.Activated:Connect(function() section:SetCollapsed(section.Expanded) end)
    end

    return section
end

local function StandaloneRoot()
    if not Library.Standalone or not Library.Standalone.Gui or not Library.Standalone.Gui.Parent then
        Library.Standalone = Root.new({})
    end
    return Library.Standalone
end

function Library:CreateDropdown(parent, opts)
    return Dropdown.new(StandaloneRoot(), parent, opts, nil)
end

function Library:Notify(opts) StandaloneRoot():Notify(opts) end
function Library:Dialog(opts) return StandaloneRoot():Dialog(opts) end

function Library:SetSwipebar(edge, along)
    local dock = Library.DockObj
    if not (dock and dock.Root.Gui.Parent) then return false end
    return dock:SetEdge(edge, along)
end

function Library:SetTheme(name)
    for _, root in ipairs(self.Roots) do root:SetTheme(name) end
    if self.DockObj and self.DockObj.Root.Gui.Parent then self.DockObj:Update() end
end

function Library:SetCorner(name)
    for _, root in ipairs(self.Roots) do root:SetCorner(name) end
end

local CONFIG_DIR = "Velor"

local function ConfigName(name)
    return (tostring(name or ""):gsub("[^%w%-_ ]", ""))
end

function Library:SaveConfig(name)
    name = ConfigName(name)
    if name == "" then return false, "enter a config name" end
    if not (writefile and isfolder and makefolder) then return false, "executor has no file API" end
    local data = {}
    for flag, object in pairs(self.FlagObjects) do
        if object.Save then data[flag] = object:Save() else data[flag] = object:Get() end
    end
    return pcall(function()
        if not isfolder(CONFIG_DIR) then makefolder(CONFIG_DIR) end
        writefile(CONFIG_DIR .. "/" .. name .. ".json", HttpService:JSONEncode(data))
    end)
end

function Library:LoadConfig(name)
    name = ConfigName(name)
    if not (readfile and isfile) then return false, "executor has no file API" end
    local path = CONFIG_DIR .. "/" .. name .. ".json"
    if name == "" or not isfile(path) then return false, "config not found" end
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
    if not ok then return false, data end
    for flag, value in pairs(data) do
        local object = self.FlagObjects[flag]
        if object then
            if object.Load then object:Load(value) else object:Set(value) end
        end
    end
    return true
end

function Library:ListConfigs()
    local names = {}
    if listfiles and isfolder and isfolder(CONFIG_DIR) then
        local ok, files = pcall(listfiles, CONFIG_DIR)
        if ok then
            for _, path in ipairs(files) do
                local n = tostring(path):match("([^/\\]+)%.json$")
                if n then names[#names + 1] = n end
            end
        end
    end
    table.sort(names)
    return names
end

function Library:DeleteConfig(name)
    name = ConfigName(name)
    if not (delfile and isfile) then return false, "executor has no file API" end
    local path = CONFIG_DIR .. "/" .. name .. ".json"
    if name == "" or not isfile(path) then return false, "config not found" end
    return pcall(delfile, path)
end

function Library:SetAutoload(name)
    if not (writefile and isfolder and makefolder) then return false, "executor has no file API" end
    return pcall(function()
        if not isfolder(CONFIG_DIR) then makefolder(CONFIG_DIR) end
        if name and ConfigName(name) ~= "" then
            writefile(CONFIG_DIR .. "/autoload.txt", ConfigName(name))
        elseif isfile(CONFIG_DIR .. "/autoload.txt") and delfile then
            delfile(CONFIG_DIR .. "/autoload.txt")
        end
    end)
end

function Library:GetAutoload()
    if not (readfile and isfile) or not isfile(CONFIG_DIR .. "/autoload.txt") then return nil end
    local ok, text = pcall(readfile, CONFIG_DIR .. "/autoload.txt")
    if ok and text and ConfigName(text) ~= "" then return ConfigName(text) end
    return nil
end

function Library:AutoLoad()
    local name = self:GetAutoload()
    if name then return self:LoadConfig(name) end
    return false, "no autoload config"
end

function Library:Destroy()
    for i = #self.Roots, 1, -1 do self.Roots[i]:Destroy() end
    self.Roots = {}
    self.Windows = {}
    self.DockObj = nil
    self.Standalone = nil
    if genv.__VelorUI == self then genv.__VelorUI = nil end
end

return Library
