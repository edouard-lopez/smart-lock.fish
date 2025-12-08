function __smart_lock_lock \
    --description 'Lock the screen and turn off display'

    cinnamon-screensaver-command --lock
    xset dpms force off
end
