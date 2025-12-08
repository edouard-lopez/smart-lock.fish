test "__smart_lock_is_idle: default threshold, not idle" \
    (
        function __smart_lock_get_idle_time; echo 100; end
        set -e SMART_LOCK_AFTER
        __smart_lock_is_idle
    ) = 1

test "__smart_lock_is_idle: default threshold, idle" \
    (
        function __smart_lock_get_idle_time; echo 200; end
        set -e SMART_LOCK_AFTER
        __smart_lock_is_idle
    ) = 0

test "__smart_lock_is_idle: custom threshold, not idle" \
    (
        function __smart_lock_get_idle_time; echo 50; end
        set -x SMART_LOCK_AFTER 60
        __smart_lock_is_idle
    ) = 1

test "__smart_lock_is_idle: custom threshold, idle" \
    (
        function __smart_lock_get_idle_time; echo 70; end
        set -x SMART_LOCK_AFTER 60
        __smart_lock_is_idle
    ) = 0
