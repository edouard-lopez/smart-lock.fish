test "__smart_lock_get_idle_time: xprintidle missing" \
    (
        set -x PATH /tmp
        __smart_lock_get_idle_time
    ) = 0

test "__smart_lock_get_idle_time: xprintidle present" \
    (
        function xprintidle; echo 5000; end
        __smart_lock_get_idle_time
    ) = 5
