function __smart_lock_icon \
    --description 'Return icons-in-terminal glyph or emoji fallback' \
    --argument-names icon_var emoji_fallback

    if set --query $icon_var
        echo "$$icon_var "
    else
        echo $emoji_fallback
    end
end
