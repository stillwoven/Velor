# Theming

Switch themes and corner styles live on any window:

```lua
Window:SetTheme("Emerald")
Window:SetCorner("Sharp")
```

Built-in themes: `Midnight`, `Obsidian`, `Ocean`, `Emerald`, `Rose`, `Ember`, `Frost`, `Aurora`, `Noir` (warm gold), `Platinum` (cool silver).

## Custom themes

Missing keys fall back to `Midnight`. If you give an `Accent` but no `Accent2`, the second gradient colour is derived from it.

```lua
Library:AddTheme("Sunset", {
    Background = Color3.fromRGB(16, 10, 14),
    Surface    = Color3.fromRGB(25, 16, 21),
    Elevated   = Color3.fromRGB(35, 23, 29),
    Hover      = Color3.fromRGB(47, 31, 39),
    Stroke     = Color3.fromRGB(66, 44, 54),
    Accent     = Color3.fromRGB(255, 122, 89),
    Accent2    = Color3.fromRGB(255, 190, 90),
    OnAccent   = Color3.fromRGB(34, 10, 4),
    Text       = Color3.fromRGB(250, 238, 232),
    SubText    = Color3.fromRGB(176, 146, 138),
    Muted      = Color3.fromRGB(118, 92, 86),
})

local Window = Library:CreateWindow({ Theme = "Sunset" })
```

| Key | Used for |
| --- | --- |
| `Background` | Window body  |
| `Surface` | Sections, popups, toasts |
| `Elevated` | Fields, buttons, search box |
| `Hover` | Hover and press fills |
| `Stroke` | Borders and dividers |
| `Accent` | Selection, focus, gradients, floating button |
| `Accent2` | Second gradient colour. Gradients flow `Accent` -> `Accent2` -> `Accent` |
| `OnAccent` | Icons drawn on top of the accent color |
| `Text`, `SubText`, `Muted` | Primary, secondary and placeholder text |
| `Success`, `Warning`, `Danger` | Notification types |

## Corner styles

| Name | Window radius | Notes |
| --- | --- | --- |
| `Rounded` | 12 px | Fields and rows scale down proportionally |
| `Soft` | 7 px | Default |
| `Sharp` | 2 px | Near-square, precise look |
| `Square` | 0 px | Fully square |

## Frame light

The window is a solid themed surface with a metal frame. The frame has a bright glare that circles the bezel, a counter-rotating
secondary glare, glints on two corners and a bevel (light on top, shade below). A soft glare also sweeps across the window.

```lua
Library:CreateWindow({ Reflective = false })        -- no glare or frame light
Library:CreateWindow({ ReflectStrength = 0.6 })     -- 0 .. 1.5
```

## Animation

Gradients flow between `Accent` and `Accent2`: the aurora across the whole window, the rim light around the window and focused
fields, selected items, toggles, sliders, accent buttons and the mobile button. They only animate while the window is
visible. `Animated = false` makes everything static.

Opening and closing run on springs (`Transition = "Drop" | "Scale" | "Slide" | "Fade"`, or `Window:SetTransition(name)`).
