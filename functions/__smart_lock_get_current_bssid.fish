function __smart_lock_get_current_bssid \
    --description 'Get the BSSID of the currently connected Wi-Fi network'

    nmcli --terse --fields active,bssid dev wifi \
        | grep '^yes' \
        | cut -d':' -f2- \
        | string replace --all '\\' '' \
        | string upper
end
