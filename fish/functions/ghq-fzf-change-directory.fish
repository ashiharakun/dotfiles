function ghq-fzf-change-directory --description 'Select a ghq repository via fzf and cd into it'
    if not command -q ghq || not command -q fzf
        return
    end

    set -l src (ghq list | fzf --preview "eza -l -g -a --icons (ghq root)/{}")
    if test -n "$src"
        commandline -r "cd "(ghq root)/$src
        commandline -f execute
    else
        commandline -f repaint
    end
end
