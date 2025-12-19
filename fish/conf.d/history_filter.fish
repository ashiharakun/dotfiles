function __history_filter --on-event fish_postexec
    set -l cmd $argv[1]
    if string match -r '^(cd|jj?|lazygit|la|ll|ls|rm|rmdir)(\\s|$)' -- "$cmd"
        history delete --exact --case-sensitive -- "$cmd"
    end
end
