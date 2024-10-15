local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local xresources = require("beautiful.xresources")
local beautiful = require("beautiful")
local dpi = xresources.apply_dpi
local tags = {"1", "2", "3", "4", "5"}
local modkey = "Mod4"

-- Theme
beautiful.init({
    font          = "RobotoMono Nerd Bold 10",
    bg_normal     = "#1b1c1f",
    bg_focus      = "#282A2E",
    fg_normal     = "#c9c9c9",
    fg_focus      = "#ffffff",
    useless_gap   = dpi(5),
    border_width  = dpi(2),
    border_normal = "#282A2E",
    border_focus  = "#24b3f0",

    notification_font = "RobotoMono Nerd Bold 12",
    notification_bg = "#282a2e",
    notification_fg = "#c5c8c6",
    notification_width = 300,
    notification_height = 100,
    notification_icon_size = dpi(50),

    titlebar_close_button_normal = "~/.config/awesome/icons/default.svg",
    titlebar_close_button_focus = "~/.config/awesome/icons/close.svg",
    titlebar_close_button_focus_hover = "~/.config/awesome/icons/close_hover.svg",

    titlebar_minimize_button_normal = "~/.config/awesome/icons/default.svg",
    titlebar_minimize_button_focus = "~/.config/awesome/icons/min.svg",
    titlebar_minimize_button_focus_hover = "~/.config/awesome/icons/min_hover.svg",

    titlebar_maximized_button_normal_active = "~/.config/awesome/icons/default.svg",
    titlebar_maximized_button_normal_inactive = "~/.config/awesome/icons/default.svg",
    titlebar_maximized_button_focus_active = "~/.config/awesome/icons/max.svg",
    titlebar_maximized_button_focus_inactive = "~/.config/awesome/icons/max.svg",
    titlebar_maximized_button_focus_active_hover = "~/.config/awesome/icons/max_hover.svg",
    titlebar_maximized_button_focus_inactive_hover = "~/.config/awesome/icons/max_hover.svg"
})

-- Layouts
awful.layout.layouts = { awful.layout.suit.tile, awful.layout.suit.floating }
awful.screen.connect_for_each_screen(function(s) awful.tag(tags, s, awful.layout.layouts[1]) end)

-- Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey, "Control" }, "q", awesome.quit),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey }, "Return", function () awful.spawn("kitty") end),
    awful.key({ modkey }, "space", function() awful.spawn("rofi -show drun") end),
    awful.key({ modkey }, "Tab", function() awful.spawn("rofi -show window") end),
    awful.key({ modkey }, "BackSpace", function() awful.spawn("thunar") end),
    awful.key({ modkey }, ".", function() awful.spawn("rofi -show emoji") end),
    awful.key({ modkey }, "Left", function() awful.client.focus.bydirection("left") end),
    awful.key({ modkey }, "Right", function() awful.client.focus.bydirection("right") end),
    awful.key({ modkey }, "Up", function() awful.client.focus.bydirection("up") end),
    awful.key({ modkey }, "Down", function() awful.client.focus.bydirection("down") end),
    awful.key({ modkey, "Control" }, "Left", function() awful.client.swap.bydirection("left") end),
    awful.key({ modkey, "Control" }, "Right", function() awful.client.swap.bydirection("right") end),
    awful.key({ modkey, "Control" }, "Up", function() awful.client.swap.bydirection("up") end),
    awful.key({ modkey, "Control" }, "Down", function() awful.client.swap.bydirection("down") end),
    awful.key({ modkey, "Shift" }, "Right", function() awful.tag.incmwfact(0.05) end),
    awful.key({ modkey, "Shift" }, "Left", function() awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey }, "Prior", function() awful.tag.incncol(1, nil, true) end),
    awful.key({ modkey }, "Next", function() awful.tag.incncol(-1, nil, true) end),
    awful.key({ modkey, "Control" }, "space", function() awful.layout.inc(1) end),
    awful.key({ modkey, "Control" }, "n",
            function()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    c:emit_signal("request::activate", "key.unminimize", {raise = true})
            end
        end)
)

for i = 1, #tags do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end),
        -- Move client to tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end)
    )
end

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
    awful.button({ modkey }, 1, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}); awful.mouse.client.move(c) end),
    awful.button({ modkey }, 3, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}); awful.mouse.client.resize(c) end))

clientkeys = gears.table.join(
    awful.key({ modkey }, "f", function(c) c.fullscreen = not c.fullscreen; c:raise() end),
    awful.key({ modkey }, "q", function(c) c:kill() end),
    awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end),
    awful.key({ modkey }, "n", function(c) c.minimized = true end),
    awful.key({ modkey }, "m", function(c) c.maximized = not c.maximized; c:raise() end))

root.keys(globalkeys)

-- Rules
awful.rules.rules = {
    { rule={}, properties = { 
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap+awful.placement.no_offscreen,
        titlebars_enabled= false}
    },
    { rule_any = { class = {"Polybar"}}, properties = { focusable = false, border_width=0 }}
}

-- Signals
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
tag.connect_signal("property::layout", function(t)
    if t.layout == awful.layout.suit.floating then
        for _,c in ipairs(client.get()) do
            if c.class ~= "Polybar" then 
                awful.titlebar.show(c)
            end
        end
    else
        for _,c in ipairs(client.get()) do awful.titlebar.hide(c) end
    end
end)
client.connect_signal("manage", function (c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
    if awful.layout.get() == awful.layout.suit.floating then awful.titlebar.show(c) end
end)

-- Titlebar
client.connect_signal("request::titlebars", function(c)
    awful.titlebar(c, {size=dpi(24)}):setup {
        { -- Left          
            {  
                awful.titlebar.widget.closebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.minimizebutton(c),
                spacing=-2,
                layout  = wibox.layout.fixed.horizontal
            },
            left=dpi(5),
            widget = wibox.container.margin,
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            layout  = wibox.layout.flex.horizontal
        },
        layout = wibox.layout.align.horizontal
    }
end)
awful.titlebar.enable_tooltip = false

-- Notification
naughty.config.defaults.timout = 3
