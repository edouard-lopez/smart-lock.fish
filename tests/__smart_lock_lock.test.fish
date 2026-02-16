source functions/__smart_lock_lock.fish

@test "__smart_lock_lock: executes cinnamon-screensaver-command on Cinnamon with X11" \
    (
        set -lx XDG_CURRENT_DESKTOP "X-Cinnamon"
        set -lx XDG_SESSION_TYPE "x11"
        function cinnamon-screensaver-command
            echo "cinnamon-screensaver-command $argv"
        end
        function xset
            echo "xset $argv"
        end
        __smart_lock_lock | string collect
    ) = "cinnamon-screensaver-command --lock
xset dpms force off"

@test "__smart_lock_lock: executes loginctl on KDE with X11" \
    (
        set -lx XDG_CURRENT_DESKTOP "KDE"
        set -lx XDG_SESSION_TYPE "x11"
        function loginctl
            echo "loginctl $argv"
        end
        function xset
            echo "xset $argv"
        end
        __smart_lock_lock | string collect
    ) = "loginctl lock-session
xset dpms force off"

@test "__smart_lock_lock: executes loginctl on Wayland without xset" \
    (
        set -lx XDG_CURRENT_DESKTOP "KDE"
        set -lx XDG_SESSION_TYPE "wayland"
        function loginctl
            echo "loginctl $argv"
        end
        __smart_lock_lock | string collect
    ) = "loginctl lock-session"

@test "__smart_lock_lock: executes kscreen-doctor on KDE Wayland" \
    (
        set -lx XDG_CURRENT_DESKTOP "KDE"
        set -lx XDG_SESSION_TYPE "wayland"
        set -lx XDG_SESSION_DEKSTOP "kde"
        function loginctl
            echo "loginctl $argv"
        end
        function kscreen-doctor
            echo "kscreen-doctor $argv"
        end
        __smart_lock_lock | string collect
    ) = "loginctl lock-session
kscreen-doctor --dpms off"

@test "__smart_lock_lock: executes busctl on GNOME Wayland" \
    (
        set -lx XDG_CURRENT_DESKTOP "GNOME"
        set -lx XDG_SESSION_TYPE "wayland"
        set -lx XDG_SESSION_DEKSTOP "gnome"
        function loginctl
            echo "loginctl $argv"
        end
        function busctl
            echo "busctl $argv"
        end
        __smart_lock_lock | string collect
    ) = "loginctl lock-session
busctl --user set-property org.gnome.Mutter.DisplayConfig /org/gnome/Mutter/DisplayConfig org.gnome.Mutter.DisplayConfig PowerSaveMode i 1"

@test "__smart_lock_lock: executes loginctl as fallback on X11" \
    (
        set -lx XDG_CURRENT_DESKTOP "GNOME"
        set -lx XDG_SESSION_TYPE "x11"
        function loginctl
            echo "loginctl $argv"
        end
        function xset
            echo "xset $argv"
        end
        __smart_lock_lock | string collect
    ) = "loginctl lock-session
xset dpms force off"
