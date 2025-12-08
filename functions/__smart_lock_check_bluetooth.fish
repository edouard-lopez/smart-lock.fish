function __smart_lock_check_bluetooth \
    --description 'Check if a trusted Bluetooth device is connected'

    if not set --query SMART_LOCK_DEVICES_MACS
        return 1
    end

    for mac in $SMART_LOCK_DEVICES_MACS
        if __smart_lock_get_bluetooth_device_type "$mac" >/dev/null
            return 0
        end
    end
    return 1
end
