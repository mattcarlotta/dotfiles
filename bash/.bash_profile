checkgitstatus() {
    local gitbranch=""
    if [ -d "$PWD/.git" ]; then
        local branchstatus=""
        local branch=$(git branch 2>&1 | grep -e "*" | cut -c3-)
        local status=$(git status 2>&1 | grep -e "Changes not staged" -e "Untracked files")
        if [ ! -z "$status" ]; then
            branchstatus=" 🔴 \[\033[91m\][unstaged]"
        fi
        gitbranch="🌿 \[\033[32m\][git:$branch]$branchstatus"
    fi
    PS1="\[\033[34m\]┌─\[\033[m\] 🌀 \[\033[34m\][\u@\h] 📂 \[\033[33;1m\][\w\]]\[\033[m\] $gitbranch\[\033[m\]\n\[\033[34m\]└➤\[\033[m\] "
}


PROMPT_COMMAND=checkgitstatus

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

alias ..='cd ../'                                                                                                   # ..:           Go back 1 directory level
alias ...='cd ../../'                                                                                               # ...:          Go back 2 directory levels
alias c='clear'                                                                                                     # c:            Clear terminal display
alias cdd="cd ~/Documents"                                                                                          # cdd:          Change directory in Documents
alias bp='nvim ~/.bash_profile'                                                                                     # bp:           Access bash profile
alias bback='cp ~/.bash_profile ~/Documents/dotfiles/bash/.bash_profile; echo Backed up bash profile'               # bback:        Backup bash profile
alias sp='source ~/.bash_profile'                                                                                   # sp:           Sources bash profile
alias pg='psql -U postgres'                                                                                         # pg:           Connects to postgreSQL
alias initDB='psql -U postgres -f'                                                                                  # initsql:      Initializes a specified SQL database
alias pia='/opt/pia/run.sh --startup'                                                                               # pia:          Start PIA client 
alias c.='code .'                                                                                                   # c.:           Opens code at directory
alias e='exit'                                                                                                      # e:            Exit terminal
alias bh='history 2>&1 | sort -rn | fzf'                                                                            # bh:           Searches bash history using fzf
alias ls='ls -AGFh --color=auto'                                                                                    # ls:           List all files in current directory

alias ga='git add .'                                                                                                # ga:           Tracks new files for git
alias gc='git commit -am'                                                                                           # gc:           Commits new files for git
alias gx='git clean -df'                                                                                            # gx:           Removes untracked git files
alias gi='git init'                                                                                                 # gi:           Initialize directory for git
alias gd='git diff'                                                                                                 # gd:           Git diff
alias gds='git diff --staged'                                                                                       # gds:          Git diff staged
alias gl='git log'                                                                                                  # gl:           Displays git logs
alias gp='git pull'                                                                                                 # gp:           Pulls from git branch
alias gpsh='git push origin'                                                                                        # gpsh:         Pushes commits to remote
alias gs='git status'                                                                                               # gs:           Displays status of git tracking
alias gclr='git clean -f -d'                                                                                        # gclr:         Remove untracked git files
alias gt='git ls-files | xargs -I{} git log -1 --format="%ai {}" {}'                                                # gt:           Displays tracked files

alias y='yarn'                                                                                                      # y:            Run yarn install
alias ya='yarn add'                                                                                                 # ya:           Add dependency to project
alias yad='yarn add -D'                                                                                             # yad:          Add dev dependency to project
alias yr='yarn remove'                                                                                              # yr:           Remove dependency from project
alias yo='yarn outdated'                                                                                            # yo:           Check for outdated project dependencies
alias yd='yarn dev'                                                                                                 # yd:           Runs yarn dev script command
alias ys='yarn start'                                                                                               # ys:           Runs yarn start script command

alias rmssh='ssh-add -D'                                                                                            # rmmssh:       Remove all ssh keys from manager
alias noshot='ssh-add ~/.ssh/id_ed25519'                                                                            # noshot:       SSH with noshot
alias matt='ssh-add ~/.ssh/id_rsa'                                                                                  # matt:         SSH with matt

alias crun='cargo run'                                                                                              # crun:         Cargo run
alias crel='cargo run --release'                                                                                    # crel:         Cargo run with release
alias cwat='cargo watch -x run'                                                                                     # cwat:         Cargo watch
alias cclp='cargo clippy'                                                                                           # cclp:         Cargo clippy

alias vinit='nvim ~/.config/nvim/init.vim'                                                                          # vinit:        Edit vim init
alias v.="nvim ."                                                                                                   # v.            Open vim in current directory
alias vim="nvim"                                                                                                    # vim:          Nvim alias
alias vback='cp -r ~/.config/nvim ~/Documents/dotfiles/; echo Backed up dot files'                                  # vback:        Backup vim to ~/Documents/.dotfiles

alias t='tmux'                                                                                                      # t:            Runs tmux
alias ta='tmux a'                                                                                                   # ta:           Runs tmux attach
alias tk='tmux kill-server'                                                                                         # tk:           Kills tmux server
alias tl='tmux list-sessions'                                                                                       # tl:           Lists active tmux sessions 
alias ts='tmux-sessionizer'                                                                                         # f:            Runs tmux-sessioner script
alias tconf='nvim ~/.tmux.conf'                                                                                     # tconf:        Edit tmux config
alias tback='cp ~/.tmux.conf ~/Documents/dotfiles/tmux; echo Backed up tmux conf'                                   # tback:        Back up tmux conf
