if test -d /usr/local/sbin
    fish_add_path -g /usr/local/sbin
end

if command -q direnv
    direnv hook fish | source
end

if status is-interactive
    if command -q starship
        starship init fish | source
    end
end
