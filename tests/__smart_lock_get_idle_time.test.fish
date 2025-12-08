source functions/__smart_lock_get_idle_time.fish

@test "__smart_lock_get_idle_time: xprintidle missing" \
    (
        set --local --export PATH /tmp
        __smart_lock_get_idle_time
    ) = 0

@test "__smart_lock_get_idle_time: xprintidle present" \
    (
        set --local tmp (mktemp -d)
        echo "echo 5000" > $tmp/xprintidle
        chmod +x $tmp/xprintidle
        set --local --export PATH $tmp $PATH
        __smart_lock_get_idle_time
        rm -rf $tmp
    ) = 5
