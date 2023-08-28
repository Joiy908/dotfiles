if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_prompt --description 'Write out the prompt'
    set_color cyan
    echo -n "╭─"
    set_color normal

    # show user
    set_color green
    echo -n $USER
    set_color white
    echo -n '❙'

    # Display current directory
    set_color yellow
    echo -n (prompt_pwd)
    set_color normal

    # Add newline and prompt symbol
    set_color cyan
    echo
    echo -n "╰─❯ "
    set_color normal
end

# Alias definitions
alias ll='ls -lah'
alias la='ls -A'
alias l='ls'
alias cp='cp -i'
alias mv='mv -i'
alias v='vim'
alias sl='ls'
alias gl='git log --all --graph --decorate --oneline'
alias gs='git status'
alias gc='git commit'
alias acenv='source .venv/bin/activate'
alias go186='cd /mnt/d/src/etc/CS186'
alias go110='cd /mnt/d/src/etc/CS110L'
alias gong='cd /usr/local/nginx'

# Functions
# Define 'here' function
function here
    if test (count $argv) -eq 1
        set loc (realpath $argv[1])
    else
        set loc (realpath ".")
    end
    ln -sfn "$loc" "$HOME/.shell.here"
    echo "here -> "(readlink $HOME/.shell.here)
end

# Set 'there' variable
set there "$HOME/.shell.here"

# Define 'there' function
function there
    cd (readlink "$there")
end
