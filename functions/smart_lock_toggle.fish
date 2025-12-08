function smart_lock_toggle \
    --description 'Toggle screen lock based on trusted Wi-Fi networks or Bluetooth devices'

    set --universal SMART_LOCK_STATUS

    # Icon configuration with emoji fallback
    set --local icon_lock (__smart_lock_icon oct_lock "🔒")
    set --local icon_unlock (__smart_lock_icon md_vpn_key "🔑")
    set --local icon_wifi (__smart_lock_icon md_signal_wifi_4_bar "🛜")
    set --local icon_phone (__smart_lock_icon md_smartphone "📱")
    set --local icon_mouse (__smart_lock_icon md_mouse "🖱️")
    set --local icon_alert (__smart_lock_icon md_cancel "❓")

    # Validate required environment variables
    if not set --query SMART_LOCK_BSSIDS; and not set --query SMART_LOCK_DEVICES_MACS
        set --universal SMART_LOCK_STATUS (set_color red)"$icon_alert SMART_LOCK_*"
        return 1
    end

    set --local trusted_devices_found
    # Check trusted Wi-Fi
    if __smart_lock_check_wifi
        set trusted_devices_found "$trusted_devices_found$icon_wifi"
    end

    # Check trusted Bluetooth devices
    if set --query SMART_LOCK_DEVICES_MACS
        for mac in $SMART_LOCK_DEVICES_MACS
            set --local device_type (__smart_lock_get_bluetooth_device_type "$mac")
            switch "$device_type"
                case phone
                    set trusted_devices_found "$trusted_devices_found$icon_phone"
                case mouse
                    set trusted_devices_found "$trusted_devices_found$icon_mouse"
            end
        end
    end

    # Apply lock/unlock based on trusted devices
    if test -n "$trusted_devices_found"
        __smart_lock_unlock
        set --universal SMART_LOCK_STATUS "$icon_unlock$trusted_devices_found"
        return 0
    end

    # Only lock if user has been idle long enough
    if __smart_lock_is_idle
        __smart_lock_lock
        set --universal SMART_LOCK_STATUS "$icon_lock"
    else
        set --local idle_threshold (set --query SMART_LOCK_AFTER; and echo $SMART_LOCK_AFTER; or echo 180)
        set --local idle_time (__smart_lock_get_idle_time)
        set --local remaining (math $idle_threshold - $idle_time)
        set --universal SMART_LOCK_STATUS "$icon_lock "~(math round $remaining)"s"
    end
    emit smart_lock_update
end
