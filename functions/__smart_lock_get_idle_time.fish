function __smart_lock_get_idle_time \
    --description 'Get user idle time in seconds using xprintidle'

    if not command --query xprintidle
        echo 0
        return 1
    end

    math (xprintidle) / 1000
end
