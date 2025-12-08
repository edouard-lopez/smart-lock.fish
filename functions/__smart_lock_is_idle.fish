function __smart_lock_is_idle \
    --description 'Check if user has been idle longer than SMART_LOCK_AFTER seconds'

    set --local idle_threshold (set --query SMART_LOCK_AFTER; and echo $SMART_LOCK_AFTER; or echo 180)
    set --local idle_time (__smart_lock_get_idle_time)

    test "$idle_time" -ge "$idle_threshold"
end
