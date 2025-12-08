test "__smart_lock_get_current_bssid: connected" \
    (
        function nmcli; echo "yes:AA:BB:CC:DD:EE:FF"; end
        __smart_lock_get_current_bssid
    ) = "AA:BB:CC:DD:EE:FF"

test "__smart_lock_get_current_bssid: not connected" \
    (
        function nmcli; echo "no:AA:BB:CC:DD:EE:FF"; end
        __smart_lock_get_current_bssid
    ) = ""
