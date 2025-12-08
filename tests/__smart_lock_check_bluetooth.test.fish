source functions/__smart_lock_check_bluetooth.fish

@test "__smart_lock_check_bluetooth: no_env_var" \
    (
        set --erase SMART_LOCK_DEVICES_MACS; or true
        __smart_lock_check_bluetooth
        or echo "status_1"
    ) = "status_1"

@test "__smart_lock_check_bluetooth: no connected device" \
    (
        function __smart_lock_get_bluetooth_device_type; return 1; end
        set --export SMART_LOCK_DEVICES_MACS "00:00:00:00:00:00"
        __smart_lock_check_bluetooth
        or echo "status_1"
    ) = "status_1"

@test "__smart_lock_check_bluetooth: connected device" \
    (
        function __smart_lock_get_bluetooth_device_type; echo "phone"; return 0; end
        set --export SMART_LOCK_DEVICES_MACS "00:00:00:00:00:00"
        __smart_lock_check_bluetooth
        and echo "status_0"
    ) = "status_0"
