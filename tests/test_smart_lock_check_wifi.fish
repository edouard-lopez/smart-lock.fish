test "__smart_lock_check_wifi: no env var" \
    (
        set -e SMART_LOCK_BSSIDS
        __smart_lock_check_wifi
    ) = 1

test "__smart_lock_check_wifi: no matching bssid" \
    (
        function __smart_lock_get_current_bssid; echo "AA:BB:CC:DD:EE:FF"; end
        set -x SMART_LOCK_BSSIDS "00:11:22:33:44:55"
        __smart_lock_check_wifi
    ) = 1

test "__smart_lock_check_wifi: matching bssid" \
    (
        function __smart_lock_get_current_bssid; echo "AA:BB:CC:DD:EE:FF"; end
        set -x SMART_LOCK_BSSIDS "aa:bb:cc:dd:ee:ff"
        __smart_lock_check_wifi
    ) = 0
