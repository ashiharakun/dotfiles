function y --description 'Launch yazi and cd into the last visited directory'
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    set -l cwd

    yazi $argv --cwd-file "$tmp"
    set cwd (string trim (cat "$tmp"))

    if test -n "$cwd" -a "$cwd" != "$PWD"
        cd "$cwd"
    end

    rm -f -- "$tmp"
end
