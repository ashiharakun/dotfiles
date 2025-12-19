if command -q eza
    abbr -a ls 'eza --icons --git'
    abbr -a lt 'eza -T -L 3 -a -I "node_modules|.git|.cache" --icons'
    abbr -a ltl 'eza -T -L 3 -a -I "node_modules|.git|.cache" -l --icons'
end

alias ll 'ls -lGF'
alias la 'ls -la'

alias .. 'cd ..'
alias ..2 'cd ../..'
alias ..3 'cd ../../..'

alias cdgt 'cd (git rev-parse --show-toplevel)'

abbr -a G '| grep --color=auto'
abbr -a C '| wc -l'
