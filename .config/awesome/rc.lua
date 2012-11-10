require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
local vicious = require("vicious")
require("colours")

if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                    text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.add_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

--beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init("/home/r/.config/awesome/themes/halfwit-dark/theme.lua")

terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
ircclient = "xchat"

layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
}

taginfo = {
    --names  = { "sys", "web", "chat", "media", "wine", "dev", "art", "misc" },
    --names  = { "", "", "", "", "", "", "", "" },
    names = { "á", "â", "ã", "ä", "å", "æ", "ç", "è" },
    layout = { layouts[2], layouts[8], layouts[2], layouts[1], layouts[1], layouts[2], layouts[5], layouts[2]},
}

tags = {}

if screen.count() == 1 then
    tags[1] = awful.tag(taginfo.names, 1, taginfo.layout)
else
    tags[1] = awful.tag({ "main" }, 1, layouts[2])
    for s = 2, screen.count() do
        tags[s] = awful.tag(taginfo.names, s, taginfo.layout) 
    end
end

awesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit } 
}

programsmenu = {
   { "chromium", "chromium"},
   { "irssi", "urxvt -e irssi -c espernet" },
   { "sylpheed", "sylpheed" },
   { "deluge", "deluge" },
   { "file manager", "pcmanfm"},
   { "gimp", "gimp" }
}

shutdownprompt = {
   { "really?", "sudo shutdown -h now" }
}

rebootprompt = {
   { "really?", "sudo reboot" }
}

systemmenu = {
   { "lock", "slimlock" },
   { "shutdown", shutdownprompt },
   { "reboot", rebootprompt }
}

toolsmenu = {
    { "screenshot", "/home/r/bin/scroad" }
}

mainmenu = awful.menu({ items = { { "programs", programsmenu },
				    { "awesome", awesomemenu },
				    { "system", systemmenu },
                    { "tools", toolsmenu },
                    { "open terminal", terminal }
                }
})

function batteryInfo()
     local dir = "="
     local fcur = io.open("/sys/class/power_supply/BAT1/energy_now")
     local fcap = io.open("/sys/class/power_supply/BAT1/energy_full")
     local fsta = io.open("/sys/class/power_supply/BAT1/status")
     local cur = fcur:read()
     local cap = fcap:read()
     local sta = fsta:read()
     local battery = math.floor(cur * 100 / cap)
     if sta:match("Charging") then
         dir = "+"
     elseif sta:match("Discharging") then
         dir = "-"
         if tonumber(battery) > 25 and tonumber(battery) < 75 then
             battery = battery
         elseif tonumber(battery) < 25 then
             if tonumber(battery) < 10 then
                 naughty.notify({ title      = "Battery Warning"
                                , text       = "Battery low! "..battery.."%".." left!"
                                , timeout    = 10
                                , position   = "top_right"
                                , fg         = beautiful.bg_focus
                                , bg         = beautiful.fg_urgent
                                })
             end
             battery = battery
         else
             battery = battery
         end
     end
     bat.text = ""..colcya..battery..coldef..colblu.."%"..coldef..""..colbblu..dir..coldef
     fcur:close()
     fcap:close()
     fsta:close()
 end

launcher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
                                     menu = mainmenu })
textclock = awful.widget.textclock()

systray = widget({ type = "systray" })

space = widget({ type = "textbox" })
space.text  = " "

seperator = widget({ type = "imagebox" })
seperator.image = image(beautiful.widget_seperator)

arrow = widget({ type = "imagebox" })
arrow.image = image(beautiful.widget_arrow_seperator)

bat = widget({type = "textbox" })
baticon = widget({type = "imagebox"})
baticon.image = image(beautiful.widget_battery)

mem = widget({type = "textbox" })
memicon = widget({type = "imagebox"})
memicon.image = image(beautiful.widget_memory)
vicious.register(mem, vicious.widgets.mem, "" .. colcya .. "$2" .. coldef .. coldblu .. "Mb" .. coldef, 5)

cpu = widget({type = "textbox" })
cpuicon = widget({type = "imagebox" })
cpuicon.image = image(beautiful.widget_cpu)
vicious.register(cpu,  vicious.widgets.cpu, "" .. colblu .. "CPU: " .. coldef .. colcya .. "$1" .. coldef .. coldblu .. "%" .. coldef, 5)

thermal = widget({type = "textbox" })
thermalicon = widget({type = "imagebox" })
thermalicon.image = image(beautiful.widget_thermal)
vicious.register(thermal,  vicious.widgets.thermal, "" .. colcya .. "$1" .. coldef .. coldblu .. "C" .. coldef, 5, { "coretemp.0", "core"})

net_downicon = widget({ type = "imagebox" })
net_upicon = widget({ type = "imagebox" })
net_downicon.image = image(beautiful.widget_net_down)
net_upicon.image = image(beautiful.widget_net_up)
net = widget({ type = "textbox" })
vicious.register(net, vicious.widgets.net, "" .. colcya .. "${wlan0 down_kb}" .. coldef .. coldblu .. "k " .. coldef .. colcya .. "${wlan0 up_kb}" .. coldef .. coldblu .. "k" .. coldef, 5)

vol = widget({ type="textbox" })
volicon = widget({ type="imagebox" })
volicon.image = image(beautiful.widget_volume)
vicious.register(vol, vicious.widgets.volume, "" .. colcya .. "$1" .. coldef .. coldblu .. "%" .. coldef, 2, "Master")

vol:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn_with_shell("ossxmix") end)
))

mpd = widget({ type = "textbox"})
mpdicon = widget({ type="imagebox" })
mpdicon.image = image(beautiful.widget_music)
vicious.register(mpd, vicious.widgets.mpd, "" ..  colblu .. "mpd: " .. coldef .. colcya .. "${state}ing: " .. coldef .. colmag .. "${Artist}" .. coldef .. " - " .. colbblu .. "${Title}" .. coldef, 1)

date = widget({ type = "textbox" })
vicious.register(date, vicious.widgets.date, "" .. colmag .. "%a %b %d" .. coldef)

time = widget({ type = "textbox" })
vicious.register(time, vicious.widgets.date, "" .. colwhi .. "%R" .. coldef)

function mpd_text_rotate()
    if string.len(mpd_text) >= mpd_text_max_size then
        mpd_text = string.gsub(mpd_text, '^(.)(.+)$', '%2%1')
        mpd_text_box.text = string.sub(mpd_text, 1, mpd_text_max_size).."..."
    else
        mpd_text_box.text = mpd_text
    end
end

--awful.hooks.timer.register(6, function() batteryInfo() end) batteryInfo()

--awful.hooks.timer.register(0.25, function() mpd_text_rotate() end)

wibox_main = {}
promptbox = {}
layoutbox = {}
taglist = {}
taglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
tasklist = {}
tasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    promptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    layoutbox[s] = awful.widget.layoutbox(s)
    layoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    taglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, taglist.buttons)
    tasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, tasklist.buttons)

    wibox_main[s] = awful.wibox({  position = "top", height = beautiful.wibox_height, screen = s, bg = "#00000000" })
    wibox_main[s].bg_image = image(beautiful.wibox_bg_image)
    wibox_main[s].widgets = {
        {
            launcher,-- space, 
            taglist[s], 
            layoutbox[s], seperator,
            layout = awful.widget.layout.horizontal.leftright
        },
        space, space, date, space, arrow, space,-- systray, space, 
        vol, volicon, space, bat, baticon, space, arrow,
        space, thermal, space, space, mem, space, space, cpu, space,
        arrow, space, net_upicon, net, net_downicon, space,
        arrow, space, mpd, space, arrow,
        space, time, space, seperator,
        tasklist[s], 
        layout = awful.widget.layout.horizontal.rightleft
    } 
end

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

run_once("chromium")
run_once("urxvt")
run_once(ircclient)

wp = 1
function change_wp(wp_incr)
    wp = wp + wp_incr
    if wp > #theme.wallpapers then wp = 1 end
    if wp < 1 then wp = #theme.wallpapers end
    naughty.notify ({ title = "Changing wallpaper...",
        text = "Setting wallpaper to " .. theme.wallpapers[wp], timeout = 2, position = "top_left" })
    awful.util.spawn_with_shell("feh --bg-fill " .. theme.wploc .. theme.wallpapers[wp])
end

root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mainmenu:show({keygrabber=true}) end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    awful.key({modkey }, "r", function() awful.util.spawn("dmenu_run -i -p 'Run command:'") end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  promptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, 	      }, "q",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "g",      awful.mouse.client.resize           ),
    awful.key({ modkey,           }, "n",
        function (c)
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),

    awful.key({ modkey,           }, "Escape",      function () awful.util.spawn("slimlock") end),
    awful.key({ modkey,           }, "v",      function () change_wp(1) end),
    awful.key({ modkey, "Shift"   }, "v",      function () change_wp(-1) end),
    awful.key({ modkey,           }, "p",      function () awful.util.spawn_with_shell("mpc toggle") end),
    awful.key({ modkey,           }, ".",      function () awful.util.spawn_with_shell("mpc next") end),
    awful.key({ modkey,           }, ",",      function () awful.util.spawn_with_shell("mpc prev") end),
    awful.key({ modkey,           }, "Up",     function () awful.util.spawn_with_shell("amixer set Master 2000+") end),
    awful.key({ modkey,           }, "Down",     function () awful.util.spawn_with_shell("amixer set Master 2000-") end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        )
)
    
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))


root.keys(globalkeys)
--[[if screen.count() == 1 then
    tags[1] = awful.tag(taginfo.names, 1, taginfo.layout)
else
    tags[1] = awful.tag({ "main" }, 1, layouts[2])
    for s = 2, screen.count() do
        tags[s] = awful.tag(taginfo.names, s, taginfo.layout) 
    end
end]]
if screen.count() == 1 then
    awful.rules.rules = {
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,	
                     focus = true,
		             size_hints_honor = false,
                     keys = clientkeys,
                     buttons = clientbuttons } },
      { rule = { class = "luakit" },
        properties = { tag = tags[1][2], border_width = 0 } },   
      { rule = { class = "Chromium" },
        properties = { tag = tags[1][2],
                       border_width = 0 } },  
      { rule = { class = "MPlayer" },
        properties = { size_hints_honor = true } },  
      { rule = { class = "irssi" },
        properties = { tag = tags[1][3] } },  
      { rule = { class = "xchat" },
        properties = { tag = tags[1][3],
                       border_width = 0 } },  
      { rule = { class = "Spotify" },
        properties = { tag = tags[1][4], border_width = 0 } },
      { rule = { class = "Gimp" },
        properties = { tag = tags[1][7] } },
      { rule = { class = "Wine" },
        properties = { tag = tags[1][5], border_width = 0 } }
    }
else 
    awful.rules.rules = {
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,	
                     focus = true,
		             size_hints_honor = false,
                     keys = clientkeys,
                     buttons = clientbuttons } },
      { rule = { class = "luakit" },
        properties = { tag = tags[2][2], border_width = 0 } },   
      { rule = { class = "Chromium" },
        properties = { tag = tags[2][2],
                       border_width = 0 } },  
      { rule = { class = "MPlayer" },
        properties = { size_hints_honor = true } },  
      { rule = { class = "irssi" },
        properties = { tag = tags[2][3] } },  
      { rule = { class = "XChat" },
        properties = { tag = tags[2][3],
                       border_width = 0 } },  
      { rule = { class = "Spotify" },
        properties = { tag = tags[2][4], border_width = 0 } },
      { rule = { class = "Gimp" },
        properties = { tag = tags[2][7] } },
      { rule = { class = "Wine" },
        properties = { tag = tags[2][5], border_width = 0 } }
    }
end


client.add_signal("manage", function (c, startup)
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

