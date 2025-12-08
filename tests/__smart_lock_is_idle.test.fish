source functions/__smart_lock_is_idle.fish

@test "__smart_lock_is_idle: default threshold, not idle" \
    (
        function __smart_lock_get_idle_time; echo 100; end
        set --erase SMART_LOCK_AFTER
        __smart_lock_is_idle
        or echo "status_1"
    ) = "status_1"

@test "__smart_lock_is_idle: default threshold, idle" \
    (
        function __smart_lock_get_idle_time; echo 200; end
        set --erase SMART_LOCK_AFTER
        __smart_lock_is_idle
        and echo "status_0"
    ) = "status_0"

@test "__smart_lock_is_idle: custom threshold, not idle" \
    (
        function __smart_lock_get_idle_time; echo 50; end
        set --export SMART_LOCK_AFTER 60
        __smart_lock_is_idle
        or echo "status_1"
    ) = "status_1"

@test "__smart_lock_is_idle: custom threshold, idle" \
    (
        function __smart_lock_get_idle_time; echo 70; end
        set --export SMART_LOCK_AFTER 60
        __smart_lock_is_idle
        and echo "status_0"
    ) = "status_0"
