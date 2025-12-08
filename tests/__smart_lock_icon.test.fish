source functions/__smart_lock_icon.fish

@test "__smart_lock_icon: env var set" \
    (
        set --export MY_ICON "icon"
        __smart_lock_icon MY_ICON "fallback"
    ) = "icon "

@test "__smart_lock_icon: env var unset" \
    (
        set --erase MY_ICON
        __smart_lock_icon MY_ICON "fallback"
    ) = "fallback"
