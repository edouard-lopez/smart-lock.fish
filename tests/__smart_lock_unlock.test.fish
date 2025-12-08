source functions/__smart_lock_unlock.fish

@test "__smart_lock_unlock: executes command" \
    (
        function cinnamon-screensaver-command
            echo "cinnamon-screensaver-command $argv"
        end
        __smart_lock_unlock
    ) = "cinnamon-screensaver-command --deactivate"
