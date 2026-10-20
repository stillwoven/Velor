# API reference

## Library

| Member | Description |
| --- | --- |
| `Library:CreateWindow(opts) -> Window` | Creates a window (see below). |
| `Library:CreateDropdown(parent, opts) -> Dropdown` | Standalone dropdown inside any `GuiObject`. |
| `Library:Notify(opts)` / `Library:Dialog(opts)` | Toast / dialog on the standalone layer (windows have their own). |
| `Library:LoadImage(source, done)` | Resolves a URL / asset / file to image content. `done(content)` or `done(nil, reason)`. Cached in `Library.ImageCache` and in `workspace/Velor/cache`. |
| `Library:SetTheme(name)` / `Library:SetCorner(name)` | Apply to every window and element. |
| `Library:AddTheme(name, colors)` | Register a custom theme (see [THEMING](THEMING.md)). |
| `Library:SaveConfig(name)` / `Library:LoadConfig(name)` | Persist every element that has a `Flag` to `Velor/<name>.json`. Returns `ok, err`. |
| `Library:ListConfigs() -> {string}` | Names of the saved configs. |
| `Library:DeleteConfig(name)` | Deletes a saved config. Returns `ok, err`. |
| `Library:SetAutoload(name?)` / `Library:GetAutoload()` | Remember which config loads on start (`nil` clears it). |
| `Library:AutoLoad()` | Loads the autoload config. Call it after your UI is built. |
| `Library.Windows` | Array of every live window. |
| `Library:Destroy()` | Removes every window, popup and effect. |
| `Library.Flags` | `{ [flag] = value }`, always current. |
| `Library.FlagObjects` | `{ [flag] = element }`. |
| `Library.Themes`, `Library.Corners` | Theme and corner tables. |
| `Library:SetSwipebar(edge, along?)` | Dock the swipebar: `Left`, `Right`, `Top` or `Bottom`, and `0` (start) to `1` (end) along it. |
| `Library.Defaults` | `{ Theme, Corner }` used by standalone dropdowns and new windows. |

## Window options

| Option | Type | Default | Notes |
| --- | --- | --- | --- |
| `Title` | string | `"Vélor"` | |
| `Subtitle` | string | none | Small text under the title. |
| `Theme` | string | `"Velor"` | `Velor`, `Midnight`, `Obsidian`, `Ocean`, `Emerald`, `Rose`, `Ember`, `Frost`, `Noir`, `Platinum`, `Aurora` or your own (`Library:AddTheme`). |
| `Corner` | string | `"Soft"` | `Rounded` (12), `Soft` (7), `Sharp` (2), `Square` (0). |
| `Animated` | boolean | `true` | Animated gradients and rim light. |
| `Width` | number | `280` (`276` mobile) | Clamped to the screen. |
| `Size` | Vector2 | none | Alternative to `Width` (only `X` is read). |
| `MaxHeight` | number | `420` (`380` mobile) | The panel grows with its content up to this height, then scrolls. |
| `ToggleKey` | Enum.KeyCode | `RightShift` | Ignored on touch-only devices. |
| `Swipebar` | boolean / table | `true` | Show the swipebar for this window. A table sets where it starts: `{ Edge = "Bottom", Along = 0.5 }` (default: bottom centre). `ToggleButton` and `MobileButton = false` still work as aliases. |
| `Transition` | string | `"Drop"` | How the window opens and closes: `Drop` (unrolls from the title bar), `Scale`, `Slide` or `Fade`. All are springs: interrupt one mid-way and it reverses smoothly. |
| `Reflective` | boolean | `true` | Glare across the window and light on the frame (travelling glare, corner glints, bevel). |
| `ReflectStrength` | number | `1` | `0` to `1.5`. |
| `Mobile` | boolean | auto | Force mobile sizing on or off. |
| `Font` | string | none | Preset name, or a URL / path to your own `.ttf` / `.otf`. |
| `FontName` | string | none | Name given to a custom `Font`. |
| `FontBold` | boolean | `false` | Use the bold face of a custom `Font`. |
| `Resizable` | boolean | `true` | Corner grip; double-click it to reset. |
| `MinWidth` | number | `220` | Smallest width when resizing. |
| `MinHeight` | number | title + 90 | Smallest height when resizing. |
| `Hidden` | boolean | `false` | Create without showing. |

## Window

`Show()`, `Hide()`, `Toggle()`, `SetCollapsed(bool)`, `SetToggleKey(key)`, `SetTitle(text)`, `SetTheme(name)`, `SetReflective(on, strength)`,
`SetCorner(name)`, `SetTransition(name)`, `SetSwipebar(bool | { Edge, Along })` (`SetToggleButton` is an alias), `Notify(opts)`, `Dialog(opts)`, `Confirm(title, content, callback, opts?)`, `Prompt(title, content, callback, opts?)`, `AddSection(title, opts?) -> Section`,
`AddConfigSection(opts?) -> Section`, `AddInterfaceSection(opts?) -> Section`, `Destroy()`.

### Swipebar

One slim glass handle, shaped and placed like the iPhone home indicator, is shared by **all** windows. It works with mouse and touch.

| Gesture | Result |
| --- | --- |
| Tap / click | One window: show or hide it. Two or more: open or close the switch panel. |
| Swipe inward (towards the screen centre) | The handle follows with a rubber band and brightens. Release past ~30 px, or with a quick flick, to show the window or open the panel. |
| Swipe outward | Same, to hide the window or close the panel. Letting go early springs the handle back. |
| Drag along the edge | Move the handle anywhere from one end of the edge to the other. |
| Press and hold (about 0.3 s), then drag | The handle lifts and follows your finger in any direction, then docks on the nearest edge: left, right, top or bottom. |

The handle rests dim, wakes when touched or hovered, and glows while a window is open. The panel (two or more windows) opens on
the inner side of the handle wherever it is docked and offers a switch per window plus *Show all / Hide all*.

It is on by default. Use `Swipebar = false` to turn it off, or place it from code:

```lua
Library:CreateWindow({ Swipebar = { Edge = "Left", Along = 0.3 } })   -- default is Bottom, 0.5
Library:SetSwipebar("Bottom", 0.5)
```

### Ready-made sections

- `Window:AddConfigSection({ Title?, Collapsed? })` - config name, saved list (searchable), Save / Load / Delete / Refresh,
  and an *Autoload this config* switch. Uses `Library:SaveConfig` & friends.
- `Window:AddInterfaceSection({ Title?, Collapsed? })` - theme dropdown, corner switcher, open / close transition, font, menu keybind, swipebar switch + edge picker,
  and *Unload UI*. Its elements use the flags `UI_Theme`, `UI_Corner`, `UI_Transition`, `UI_MenuKey`, `UI_Swipebar`, `UI_SwipebarEdge`.

The title bar drags the window and the chevron button collapses it to just the title bar.

`AddSection(title, { Collapsed = false, Collapsible = true })`

## Section

| Method | Description |
| --- | --- |
| `AddDropdown(opts) -> Dropdown` | |
| `AddToggle(opts) -> Toggle` | |
| `AddSlider(opts) -> Slider` | |
| `AddInput(opts) -> Input` | |
| `AddKeybind(opts) -> Keybind` | |
| `AddColorPicker(opts) -> ColorPicker` | |
| `AddSegmented(opts) -> Segmented` | |
| `AddStepper({ Name, Min, Max, Step, Default, Suffix, Flag, Callback }) -> Stepper` | `- value +` control. Hold a button to repeat (it accelerates). `Get`, `Set`, `OnChanged`. |
| `AddProgress({ Name, Min, Max, Default, Suffix?, Format?, Flag }) -> Progress` | Animated bar. `Set(value)` glides to the new value. `Format = function(value, fraction) return text end` customises the readout. |
| `AddParagraph({ Title?, Content, RichText? }) -> { Set(title?, content) }` | Info card with an accent bar. Wraps and grows with its text. |
| `AddCallout({ Type, Title?, Content, RichText? }) -> { Set(title?, content) }` | Tinted note. `Type` = `Info`, `Success`, `Warning` or `Error`. |
| `AddImage(url, format)` / `AddImage({ Url, Format, Ratio, Width, Fit, Caption, Callback })` | A picture from a URL, `rbxassetid://` or file path. See [Images](#images-and-collages). |
| `AddCollage({ url, url, ... }, format)` | Several pictures arranged into one frame. Same element as `AddImage` with a list. |
| `AddButton({ Name, Callback, Style })` | `Style = "Accent"` gives a filled, animated gradient button. Returns the button instance. |
| `AddLabel(text) -> { Set(text) }` | |
| `AddDivider()` | Thin fading line. |
| `SetCollapsed(bool)` / `Toggle()` | Expand or collapse the section. |

## Dropdown

| Option | Type | Default | Notes |
| --- | --- | --- | --- |
| `Name` | string | `"Dropdown"` | |
| `Options` | array | `{}` | Strings, numbers, or `{ Text, Value, Disabled }`. |
| `Default` | value or array | none | Value for single, array (or set) for multi. |
| `Multi` | boolean | `false` | |
| `Max` | number | none | Max selections (multi). Shows a warning toast when exceeded. |
| `AllowNone` | boolean | `false` single, `true` multi | Allow clearing the selection. |
| `Search` | boolean | auto | `nil` shows search above `SearchThreshold` options. |
| `SearchThreshold` | number | `7` | |
| `MaxVisible` | number | `5` | Rows visible before the list scrolls. |
| `Placeholder` | string | `"Select..."` | |
| `Flag` | string | none | Registers in `Library.Flags` and configs. |
| `Callback` | function | none | Receives a value (single) or an array (multi). |
| `Disabled` | boolean | `false` | |

Methods: `Get()`, `Set(value, silent?)`, `Clear(silent?)`, `Refresh(options, keepSelection?)`, `Add(option)`,
`Remove(value)`, `OnChanged(fn) -> disconnect`, `Open()`, `Close()`, `Toggle()`, `SetName`, `SetVisible`,
`SetDisabled`, `Destroy()`.

## Toggle

Options: `Name`, `Default` (boolean), `Flag`, `Callback(bool)`, `Disabled`.
Methods: `Get()`, `Set(bool, silent?)`, `Toggle()`, `OnChanged(fn)`, `SetName`, `SetVisible`, `SetDisabled`, `Destroy()`.

## Slider

| Option | Type | Default | Notes |
| --- | --- | --- | --- |
| `Name` | string | `"Slider"` | |
| `Min`, `Max` | number | `0`, `100` | |
| `Default` | number | `Min` | |
| `Step` | number | `1` | Also accepted as `Increment`. Decimals are derived from it. |
| `Ticks` | boolean | auto | Increment marks under the track. Shown automatically for 2 to 20 steps; `true` forces them, `false` hides them. |
| `Suffix` | string | none | Shown after the value, e.g. `"%"`. |
| `Flag`, `Callback(number)`, `Disabled` | | | |

Methods: `Get()`, `Set(number, silent?)`, `OnChanged(fn)`, `SetName`, `SetVisible`, `SetDisabled`, `Destroy()`.
Dragging a slider temporarily locks scrolling so touch drags don't move the panel.

## Input

Options: `Name`, `Default`, `Placeholder`, `Numeric` (digits only, `Get()` returns a number), `Flag`,
`Callback(value, enterPressed)` (fires when focus is lost), `Disabled`.
Methods: `Get()`, `Set(value, silent?)`, `OnChanged(fn)`, `SetName`, `SetVisible`, `SetDisabled`, `Destroy()`.

## Keybind

Options: `Name`, `Default` (`Enum.KeyCode` or its name), `Flag`, `Callback(key)` (when the binding changes),
`OnPress(key)` (when the bound key is pressed), `Disabled`.
Click the field, then press a key. `Escape` cancels, `Backspace` clears.
Methods: `Get()` (`Enum.KeyCode?`), `Set(key, silent?)`, `OnChanged(fn)`, `SetName`, `SetVisible`, `SetDisabled`, `Destroy()`.

## ColorPicker

Options: `Name`, `Default` (`Color3` or `"#RRGGBB"`), `Flag`, `Callback(Color3)`, `Disabled`.
Click the swatch to expand an inline saturation / value square and hue bar. Configs store it as a hex string.
Methods: `Get()` (`Color3`), `Set(Color3 | hex, silent?)`, `OnChanged(fn)`, `SetExpanded(bool)`, `SetName`, `SetVisible`,
`SetDisabled`, `Destroy()`.

## Segmented

A compact switcher for 2-4 short choices. Options: `Name`, `Options` (strings or `{ Text, Value }`), `Default`, `Flag`,
`Callback(value)`, `Disabled`. Methods: `Get()`, `Set(value, silent?)`, `OnChanged(fn)`, `SetName`, `SetVisible`,
`SetDisabled`, `Destroy()`.

## Notifications

```lua
Window:Notify({ Title = "Saved", Content = "Config written.", Type = "Success", Duration = 4 })
```

| Option | Notes |
| --- | --- |
| `Title`, `Content` | Text. Both wrap and the toast grows. |
| `Type` | `Info` (accent gradient), `Success`, `Warning`, `Error`. Sets the icon, the edge colour and the tint. |
| `Duration` | Seconds (default `4`). `0` keeps the toast until it is clicked or closed. The timer pauses while the pointer is over it. |
| `Callback` | Runs when the toast is clicked (clicking also dismisses it). |

Each toast has a tinted icon tile, a wash of its type colour, a lit top edge, a close button and a slim time bar. Everything is
bound to the theme, so toasts re-colour live. They stack with a smooth slide / collapse animation, five at most.

## Dialogs

A modal prompt over a dimmed screen: one card, a message, an optional text field and your buttons.

```lua
Window:Dialog({
    Title = "Delete save?", Content = "This cannot be undone.", Type = "Warning",
    Buttons = {
        { Name = "Cancel" },
        { Name = "Delete", Style = "Danger", Callback = function() print("deleted") end },
    },
})

Window:Confirm("Reset settings?", "Back to defaults.", function(yes) print(yes) end, { Danger = true, Confirm = "Reset" })
Window:Prompt("Name this profile", "Saved with your config.", function(text) print(text) end, { Placeholder = "Profile name" })
```

| Option | Notes |
| --- | --- |
| `Title`, `Content`, `RichText` | Text. Wraps and grows. |
| `Type` | `Info`, `Success`, `Warning`, `Error`: icon and colours. |
| `Buttons` | `{ { Name, Style, Callback, Keep } }` or plain strings. `Style` = `Default`, `Accent` or `Danger` (the last button of several is `Accent` by default). A button closes the dialog after its callback unless `Keep = true`. 4+ buttons stack. |
| `Input` | `true` or `{ Placeholder, Default }`. Adds a text field; button callbacks receive its text and Enter presses the primary button. |
| `Dismissible` | Default `true`: Escape or a click outside closes it. |
| `Width` | Default `330` (`280` on mobile), clamped to the screen. |
| `OnClose` | Runs when it is dismissed (not when a button closes it). |

It returns an object with `Close()`, `SetContent(text)` and `GetInput()`. `Confirm` calls back with `true` / `false` (cancel and
dismiss are `false`); `Prompt` with the text, or `nil` on cancel.

## Images and collages

```lua
Section:AddImage("https://example.com/banner.png", "Horizontal")        -- Horizontal (16:9) | Vertical (3:4) | Square (1:1)
Section:AddCollage({ url1, url2, url3, url4 }, "Square")                -- one frame, pictures arranged automatically
Section:AddImage({ url1, url2, url3 }, "Horizontal")                    -- a list is a collage too
local img = Section:AddImage():Collage({ url1, url2 }, "Vertical")      -- or build it afterwards
```

| Option | Notes |
| --- | --- |
| `Url` / `Urls` | One picture or a list. Sources: `https://` URL (**PNG or JPG**), `rbxassetid://123` or a number, or a file path in the executor workspace. |
| `Format` | `Horizontal` (16:9 banner, full width), `Vertical` (3:4, 60% width), `Square` (1:1, 72% width). Aliases: `16:9`, `Banner`, `Wide`, `Portrait`, `Tall`, `1:1`. |
| `Ratio`, `Width` | Override the format: width / height, and the fraction (0 to 1) of the row it fills. |
| `Fit` | `Crop` (default, fills the frame), `Fit` (whole picture) or `Stretch`. |
| `Caption` | Small text under the picture. |
| `Corner` | Corner roundness multiplier. Default `0`: the frame, its stroke and every tile are square. Pass e.g. `0.6` to round them. Pictures get a themed rim-light frame. |
| `Callback` | `function(url, index)` when a picture is clicked. |

Collages take up to 9 pictures (more show as `+N` on the last tile). The layout follows the format: two pictures split the long
side, three give one large and two small, four a 2x2 grid, five and up a mosaic whose rows always fill the frame. Every picture is
cropped to its tile, so nothing needs to be pre-sized.

Returned object: `Set(url, format?)`, `Collage(urls, format?)`, `SetFormat(format)`, `SetCaption(text)`, `OnClick(fn)`,
`SetVisible(bool)`, `Destroy()`.

Pictures from URLs are downloaded with the executor's http function, saved to `workspace/Velor/cache` and shown with
`getcustomasset`, so they need `writefile` and `getcustomasset`. While loading, a tile shimmers; if it fails the tile says why
(for example a WEBP or GIF, which Roblox cannot display).

## Behavior notes

- Only one popup is open at a time. Clicking outside or pressing Escape closes it.
- Popups flip upward when there isn't enough room below and follow the field while the window moves or scrolls.
- Callback errors are caught and printed as warnings; they never break the UI.
- Animations stop while the window is hidden.
- Re-executing the script destroys the previous instance first.


## Fonts

| Call | Description |
| --- | --- |
| `Library:SetFont(font, opts?)` | `"Default"`, a preset (`Gotham`, `Builder Sans`, `Montserrat`, `Ubuntu`, `Nunito`, `Roboto`, `Source Sans`, `Arimo`, `Roboto Mono`), a previously loaded custom name, or a URL / workspace path to a `.ttf` / `.otf`. `opts`: `Name`, `Bold` (URL or path of a bold face). Returns `ok, err`. |
| `Library:LoadFont(name, source, bold?)` | Downloads and registers a font without applying it. |
| `Library:GetFont()` / `Library:GetFonts()` | Current font / list of selectable fonts. |
| `Window:SetFont(...)` | Same as `Library:SetFont`. |
| `CreateWindow({ Font, FontName, FontBold })` | Apply a font when the window is created. |

Custom fonts need `writefile` and `getcustomasset` (or `getsynasset`) and are cached under `workspace/Velor/fonts/`.

## Discord card

`Window:AddDiscord(Title, Desc, Invite)` (or one table: `{ Title, Desc, Invite }`). `Invite` is a code or a link
(`discord.gg/xyz`, `discord.com/invite/xyz`). The card fetches the server through the executor's http function, shows the
icon, member count and online count, and the **Join** button copies `https://discord.gg/<code>` with `setclipboard`.
If `Title` / `Desc` are empty the server name / description are used. Returns a card with `:Refresh()`,
`:SetInvite(code)` and `:Destroy()`.

## Resizing

`CreateWindow` options: `Resizable` (default `true`), `MinWidth` (220), `MinHeight`. Methods: `Window:SetSize(width, height)`,
`Window:ResetSize()` (back to default width and auto-fit height), `Window:SetResizable(state)`.
