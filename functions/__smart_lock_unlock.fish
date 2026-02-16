function __smart_lock_unlock \
    --description 'Unlock the screen'

    # Unlock screen based on desktop environment
    if test "$XDG_CURRENT_DESKTOP" = "X-Cinnamon"
        cinnamon-screensaver-command --deactivate
    else
        # Universal fallback for systemd-based systems (KDE, GNOME, etc.)
        loginctl unlock-session
    end
end
