source functions/smart_lock_toggle.fish

@test "smart_lock_toggle: missing env vars" \
    (
        function __smart_lock_icon; echo $argv[2]; end
        set --erase SMART_LOCK_BSSIDS; or true
        set --erase SMART_LOCK_DEVICES_MACS; or true
        smart_lock_toggle
        or echo "status_1"
    ) = "status_1"

@test "smart_lock_toggle: trusted wifi unlocks" \
    (
        function __smart_lock_icon; echo $argv[2]; end
        function __smart_lock_check_wifi; return 0; end
        function __smart_lock_unlock; echo "unlocked"; end
        function __smart_lock_get_bluetooth_device_type; return 1; end
        set --export SMART_LOCK_BSSIDS "mock"
        set --erase SMART_LOCK_DEVICES_MACS; or true
        smart_lock_toggle >/dev/null
        echo $SMART_LOCK_STATUS
    ) = "🔑🛜"

@test "smart_lock_toggle: trusted bluetooth unlocks" \
    (
        function __smart_lock_icon; echo $argv[2]; end
        function __smart_lock_check_wifi; return 1; end
        function __smart_lock_get_bluetooth_device_type; echo "phone"; end
        function __smart_lock_unlock; echo "unlocked"; end
        set --erase SMART_LOCK_BSSIDS; or true
        set --export SMART_LOCK_DEVICES_MACS "mock"
        smart_lock_toggle >/dev/null
        echo $SMART_LOCK_STATUS
    ) = "🔑📱"

@test "smart_lock_toggle: idle lock" \
    (
        function __smart_lock_icon; echo $argv[2]; end
        function __smart_lock_check_wifi; return 1; end
        function __smart_lock_check_bluetooth; return 1; end
        function __smart_lock_is_idle; return 0; end
        function __smart_lock_lock; echo "locked"; end
        set --export SMART_LOCK_BSSIDS "mock"
        set --erase SMART_LOCK_DEVICES_MACS; or true
        smart_lock_toggle >/dev/null
        echo $SMART_LOCK_STATUS
    ) = "🔒"

@test "smart_lock_toggle: not idle enough" \
    (
        function __smart_lock_icon; echo $argv[2]; end
        function __smart_lock_check_wifi; return 1; end
        function __smart_lock_check_bluetooth; return 1; end
        function __smart_lock_is_idle; return 1; end
        function __smart_lock_get_idle_time; echo 100; end
        set --export SMART_LOCK_BSSIDS "mock"
        set --erase SMART_LOCK_DEVICES_MACS; or true
        set --export SMART_LOCK_AFTER 200
        smart_lock_toggle >/dev/null
        string match --regex "🔒 ~100s" $SMART_LOCK_STATUS
    ) = "🔒 ~100s"
