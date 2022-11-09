# ls aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls'

# Aliases to protect against overwriting
alias cp='cp -i'
alias mv='mv -i'

# vim
alias v="vim"

# 手误打错命令也没关系
alias sl=ls

# 重新定义一些命令行的默认行为
alias mkdir="mkdir -p"     # -p make parent dirs as needed

alias gl="git log --all --graph --decorate --oneline"
alias gs="git status"
alias gc="git commit"

# only for wsl2
#alias acenv="source .venv/bin/activate"
#alias go186="cd /mnt/d/src/etc/CS186"
#alias go110="cd /mnt/d/src/etc/CS110L"
