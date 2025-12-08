function fish_right_prompt --on-event smart_lock_update
    if contains -- --final-rendering $argv
        return
    end
    printf $SMART_LOCK_STATUS
end
