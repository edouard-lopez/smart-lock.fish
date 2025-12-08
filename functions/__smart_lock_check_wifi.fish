function __smart_lock_check_wifi \
    --description 'Check if connected to a trusted Wi-Fi network'

    if not set --query SMART_LOCK_BSSIDS
        return 1
    end

    set --local current_bssid (__smart_lock_get_current_bssid)
    for bssid in $SMART_LOCK_BSSIDS
        if test "$current_bssid" = (string upper "$bssid")
            return 0
        end
    end
    return 1
end
