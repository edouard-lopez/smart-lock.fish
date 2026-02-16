function __smart_lock_lock \
    --description 'Lock the screen and turn off display'

    # Lock screen based on desktop environment
    if test "$XDG_CURRENT_DESKTOP" = "X-Cinnamon"
        cinnamon-screensaver-command --lock
    else
        # Universal fallback for systemd-based systems (KDE, GNOME, etc.)
        loginctl lock-session
    end

    # Turn off display based on session type
    if test "$XDG_SESSION_TYPE" = "x11"
        type --query xset &>/dev/null; and xset dpms force off
    else if test "$XDG_SESSION_TYPE" = "wayland"
        # from https://github.com/hopeseekr/BashScripts/blob/trunk/turn-off-monitors
        if test "$XDG_SESSION_DEKSTOP" = "gnome"
            busctl --user set-property org.gnome.Mutter.DisplayConfig /org/gnome/Mutter/DisplayConfig org.gnome.Mutter.DisplayConfig PowerSaveMode i 1
        else if test "$XDG_SESSION_DEKSTOP" = "kde"
            kscreen-doctor --dpms off
        end
    end
end
