test "__smart_lock_icon: env var set" \
    (
        set -x MY_ICON "icon"
        __smart_lock_icon MY_ICON "fallback"
    ) = "icon "

test "__smart_lock_icon: env var unset" \
    (
        set -e MY_ICON
        __smart_lock_icon MY_ICON "fallback"
    ) = "fallback"
