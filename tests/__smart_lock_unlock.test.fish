source functions/__smart_lock_unlock.fish

@test "__smart_lock_unlock: executes cinnamon-screensaver-command on Cinnamon" \
    (
        set -lx XDG_CURRENT_DESKTOP "X-Cinnamon"
        function cinnamon-screensaver-command
            echo "cinnamon-screensaver-command $argv"
        end
        __smart_lock_unlock
    ) = "cinnamon-screensaver-command --deactivate"

@test "__smart_lock_unlock: executes loginctl on KDE" \
    (
        set -lx XDG_CURRENT_DESKTOP "KDE"
        function loginctl
            echo "loginctl $argv"
        end
        __smart_lock_unlock
    ) = "loginctl unlock-session"

@test "__smart_lock_unlock: executes loginctl as fallback" \
    (
        set -lx XDG_CURRENT_DESKTOP "GNOME"
        function loginctl
            echo "loginctl $argv"
        end
        __smart_lock_unlock
    ) = "loginctl unlock-session"
