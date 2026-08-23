{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    extraConfig = ''
         hl.on("hyprland.start", function ()
          hl.exec_cmd("vesktop", {workspace = "1"})
          hl.exec_cmd("chromium", {workspace = "2"})
         end)

         hl.env("LIBVA_VIDEO_DRIVER", "nvidia")
         hl.env("GBM_BACKEND", "nvidia-drm")
         hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
         hl.env("NVD_BACKEND", "direct")
         hl.env("WLR_NO_HARDWARE_CURSORS", "1")
         hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
         hl.env("XCURSOR_SIZE", "24")
         hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
         hl.env("HYPRCURSOR_SIZE", "24")

         hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@240", position = "auto", scale = 1, })
         hl.monitor({ output = "DP-1", mode = "2560x1440@240", position = "auto", scale = 1, })

         hl.config({
           general = {
             gaps_in = 25,
             gaps_out = 50,
             border_size = 2,
             layout = "dwindle",
             col = {
               active_border = { colors = { "rgba(89b4faee)", "rgba(cba6f7ee)" }, angle = 45 },
               inactive_border = "rgba(595959aa)",
             },
           },
           decoration = {
             rounding = 20,
             shadow = {
               enabled = true,
               range = 20,
               render_power = 3,
               color = "rgba(1a1a1aee)",
             },
             blur = {
               enabled = true,
               size = 6,
               passes = 3,
             },
           },
           misc = {
             vrr = 0,
           },
         })

         hl.device({
          name = "tablet-monitor-pen",
          output = "DP-1",
         })

         hl.device({
          name = "by-tech-gaming-keyboard",
          repeat_rate = 50,
          repeat_delay = 250,
         })

         hl.window_rule({
          name = "foot-opacity-test",
          match = { class = "foot" },
          opacity = "0.8 0.8",
         })

         hl.layer_rule({ match = { namespace = "quickshell:.*" }, blur = true })
         hl.layer_rule({ match = { namespace = "quickshell:.*" }, ignore_alpha = 0 })

         local mainMod = "SUPER"

         hl.bind(mainMod .. "+A", hl.dsp.global("caelestia:launcher"))
         hl.bind(mainMod .. "+D", hl.dsp.global("caelestia:dashboard"))
         hl.bind(mainMod .. "+N", hl.dsp.exec_cmd("caelestia shell drawers toggle sidebar"))
         hl.bind(mainMod .. "+S", hl.dsp.exec_cmd("caelestia shell drawers toggle session"))
         hl.bind(mainMod .. "+L", hl.dsp.exec_cmd("caelestia shell lock lock"))
         hl.bind(mainMod .. "+E", hl.dsp.exec_cmd("foot fish -c 'cat ~/.local/state/caelestia/sequences.txt; yazi'"))
         hl.bind(mainMod .. "+Q", hl.dsp.window.close())
         hl.bind(mainMod .. "+T", hl.dsp.exec_cmd("foot"))
         hl.bind(mainMod .. "+SHIFT+S", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots"))
         hl.bind(mainMod .. "+F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

         for i = 1, 5 do
           hl.bind(mainMod .. "+" .. i, hl.dsp.focus({ workspace = tostring(i) }))
           hl.bind(mainMod .. "+SHIFT+" .. i, hl.dsp.window.move({ workspace = tostring(i) }))
         end

      hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
      hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

      hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
      hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
      hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
      hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
    '';
  };
}
