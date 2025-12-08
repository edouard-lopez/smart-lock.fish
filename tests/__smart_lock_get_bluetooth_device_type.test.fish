source functions/__smart_lock_get_bluetooth_device_type.fish

@test "__smart_lock_get_bluetooth_device_type: not connected" \
    (
        function bluetoothctl; echo "Missing device"; end
        __smart_lock_get_bluetooth_device_type "00:00:00:00:00:00"
        or echo "status_1"
    ) = "status_1"

@test "__smart_lock_get_bluetooth_device_type: phone" \
    (
        function bluetoothctl
            echo "Device 00:00:00:00:00:00"
            echo "	Name: My Phone"
            echo "	Icon: phone"
            echo "	Connected: yes"
        end
        __smart_lock_get_bluetooth_device_type "00:00:00:00:00:00"
    ) = "phone"

@test "__smart_lock_get_bluetooth_device_type: mouse" \
    (
        function bluetoothctl
            echo "Device 00:00:00:00:00:00"
            echo "	Name: My Mouse"
            echo "	Icon: input-mouse"
            echo "	Connected: yes"
        end
        __smart_lock_get_bluetooth_device_type "00:00:00:00:00:00"
    ) = "mouse"

@test "__smart_lock_get_bluetooth_device_type: other" \
    (
        function bluetoothctl
            echo "Device 00:00:00:00:00:00"
            echo "	Name: My Headset"
            echo "	Icon: audio-headset"
            echo "	Connected: yes"
        end
        __smart_lock_get_bluetooth_device_type "00:00:00:00:00:00"
    ) = "other"
