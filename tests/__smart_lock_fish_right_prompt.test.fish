source functions/__smart_lock_fish_right_prompt.fish

@test "fish_right_prompt: prints status" \
    (
        set --export SMART_LOCK_STATUS "🔒"
        fish_right_prompt
    ) = "🔒"

@test "fish_right_prompt: ignores final rendering" \
    (
        set --export SMART_LOCK_STATUS "🔒"
        set --local out (fish_right_prompt --final-rendering)
        echo "empty$out"
    ) = "empty"
