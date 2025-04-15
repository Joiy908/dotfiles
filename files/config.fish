if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_prompt --description 'Write out the prompt'
    # Capture the exit status of the last command
    set last_status $status

    set_color cyan
    echo -n "╭─"

    # Show user
    set_color green
    echo -n $USER
    set_color white
    echo -n '❙'

    # Display current directory
    set_color yellow
    echo -n (prompt_pwd)

    # Display last process return code if non-zero
    if test $last_status -ne 0
        set_color red
        echo -n " [$last_status]"
    end

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
alias v='nvim'
alias sl='ls'
alias gl='git log --all --graph --decorate --oneline'
alias gs='git status'
alias gc='git commit'
alias acenv='source .venv/bin/activate'
alias go186='cd /mnt/d/src/etc/CS186'
alias go110='cd /mnt/d/src/etc/CS110L'
alias gong='cd /usr/local/nginx'

alias antlr4='java -cp /usr/local/lib/antlr-4.13.1-complete.jar org.antlr.v4.Tool'
alias grun='java -cp .:/usr/local/lib/antlr-4.13.1-complete.jar org.antlr.v4.gui.TestRig'

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

# set go path
set -x GOROOT /usr/local/go
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $GOROOT/bin $PATH

# set proxy
set -x https_proxy http://127.0.0.1:7890
set -x http_proxy http://127.0.0.1:7890
set -x all_proxy http://127.0.0.1:7890
