source functions/__smart_lock_check_wifi.fish

@test "__smart_lock_check_wifi: no env var" \
    (
        set --erase SMART_LOCK_BSSIDS; or true
        __smart_lock_check_wifi
        or echo "status_1"
    ) = "status_1"

@test "__smart_lock_check_wifi: no matching bssid" \
    (
        function __smart_lock_get_current_bssid; echo "AA:BB:CC:DD:EE:FF"; end
        set --export SMART_LOCK_BSSIDS "00:11:22:33:44:55"
        __smart_lock_check_wifi
        or echo "status_1"
    ) = "status_1"

@test "__smart_lock_check_wifi: matching bssid" \
    (
        function __smart_lock_get_current_bssid; echo "AA:BB:CC:DD:EE:FF"; end
        set --export SMART_LOCK_BSSIDS "aa:bb:cc:dd:ee:ff"
        __smart_lock_check_wifi
        and echo "status_0"
    ) = "status_0"
