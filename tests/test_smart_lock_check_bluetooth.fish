test "__smart_lock_check_bluetooth: no env var" \
    (
        set -e SMART_LOCK_DEVICES_MACS
        __smart_lock_check_bluetooth
    ) = 1

test "__smart_lock_check_bluetooth: no connected device" \
    (
        function __smart_lock_get_bluetooth_device_type; return 1; end
        set -x SMART_LOCK_DEVICES_MACS "00:00:00:00:00:00"
        __smart_lock_check_bluetooth
    ) = 1

test "__smart_lock_check_bluetooth: connected device" \
    (
        function __smart_lock_get_bluetooth_device_type; echo "phone"; return 0; end
        set -x SMART_LOCK_DEVICES_MACS "00:00:00:00:00:00"
        __smart_lock_check_bluetooth
    ) = 0
