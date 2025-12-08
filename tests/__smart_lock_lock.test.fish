source functions/__smart_lock_lock.fish

@test "__smart_lock_lock: executes commands" \
    (
        function cinnamon-screensaver-command
            echo "cinnamon-screensaver-command $argv"
        end
        function xset
            echo "xset $argv"
        end
        __smart_lock_lock | string collect
    ) = "cinnamon-screensaver-command --lock
xset dpms force off"
