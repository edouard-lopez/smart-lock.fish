function __smart_lock_get_bluetooth_device_type \
    --description 'Get the icon type of a connected Bluetooth device' \
    --argument-names mac

    set --local bluetooth_device (bluetoothctl info "$mac" 2>/dev/null | string collect)

    if not echo $bluetooth_device | grep -q "Connected: yes"
        return 1
    end

    if echo $bluetooth_device | grep -q 'Icon: phone'
        echo phone
    else if echo $bluetooth_device | grep -q 'Icon: input-mouse'
        echo mouse
    else
        echo other
    end
end
