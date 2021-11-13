# Parses the parent directories of the current working directory to determine if any are git tracked
function dir_is_tracked() {
    IFS='\/'
    read -ra CWD<<< "$PWD"
    IFS=''

    local parentdir=""
    local gittracked=false
    for dir in "${CWD[@]}"; do
        parentdir+=$dir/
        if [ -d "$parentdir/.git" ]; then
            gittracked=true
            break;
        fi
    done

    echo $gittracked
}

# Displays the file status of a git branch 
function check_branch_status() {
    local gitstatus=$(git status)
    local unstaged=$(echo $gitstatus | grep -e "Changes not staged" -e "Untracked files")
    local staged=$(echo $gitstatus | grep -e "Changes to be committed")
    local branch=$(git branch | grep -e "*" | cut -c3-)
    local remote_branch=$(git remote -v)
    local pushed=$(git log origin/$branch..$branch)

    if [ ! -z "$unstaged" ]; then
        echo " 🔴 \[\033[91m\][branch:unstaged]"
    elif [ ! -z "$staged" ]; then
        echo " 🟣 \[\033[95m\][branch:staged]"
    elif [ ! -z "$pushed" ] && [ ! -z "$remote_branch" ]; then
        echo " 🟡 \[\033[95m\][branch:unsynced]"
    else
        echo " 🌱 \[\033[32m\][branch:current($(git rev-parse --short HEAD))]"
    fi
}

# Displays the status of a git branch if a parent folder is git tracked
function check_git_status() {
    local gitbranch=""
    if $(dir_is_tracked); then
        local gitbranchstatus=$(check_branch_status)
        local checkedoutbranch=$(git branch | grep -e "*" | cut -c3-)

        gitbranch="🌿 \[\033[32m\][git:$checkedoutbranch]$gitbranchstatus"
    fi

    PS1="\[\033[34m\]┌─\[\033[m\] 🌀 \[\033[34m\][\u@\h] 📂 \[\033[33;1m\][\w\]]\[\033[m\] $gitbranch\[\033[m\]\n\[\033[34m\]└➤\[\033[m\] "
}

# Fuzzy finder for searching through bash history and copying selection to the clipboard
function search_bash_history() {
    local selection=$(history | awk '{$1="";print $0}' | awk '!a[$0]++' | tac | fzf | sed 's/^[[:space:]]*//')
    local selectiontext="${selection:0:40}"
    if [[ ! -z $selection ]]; then
        if (( ${#selection} > 40 )); then
            selectiontext+="... +$(expr length "${selection: 40}") characters" 
        fi
        echo -e "✨ Invoked \033[35;1m$selectiontext\033[m from bash history! ✨"
        eval "$selection"
    fi   
}


PROMPT_COMMAND=check_git_status

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

alias ..='cd ../'                                                                                                   # ..:           Go back 1 directory level
alias ...='cd ../../'                                                                                               # ...:          Go back 2 directory levels
alias c='clear'                                                                                                     # c:            Clear terminal display
alias cdd="cd ~/Documents"                                                                                          # cdd:          Change directory in Documents
alias cdde="cd ~/Desktop"                                                                                           # cdde:         Change directory in Desktop
alias bp='nvim ~/.bash_profile'                                                                                     # bp:           Access bash profile
alias bback='cp ~/.bash_profile ~/Documents/dotfiles/bash/.bash_profile; echo Backed up bash profile'               # bback:        Backup bash profile
alias sp='source ~/.bash_profile'                                                                                   # sp:           Sources bash profile
alias shc='nvim ~/.ssh/config'                                                                                      # shc:          SSH config
alias pg='psql -U postgres'                                                                                         # pg:           Connects to postgreSQL
alias initDB='psql -U postgres -f'                                                                                  # initsql:      Initializes a specified SQL database
alias c.='code .'                                                                                                   # c.:           Opens code at directory
alias e='exit'                                                                                                      # e:            Exit terminal
alias sbh=search_bash_history                                                                                       # sbh:          Searches bash history using fzf
alias ls='ls -AGFhl --color=auto'                                                                                   # ls:           List all files in current directory
alias mys='ssh myserver'                                                                                            # mys:          SSH into my server
alias sjsapp='ssh sjsapp'                                                                                           # sjsapp:       SSH into my client server

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

alias nga='sudo nvim /etc/nginx/sites-available/mattcarlotta.sh'                                                    # nga:          Edit app nginx config
alias ngi='sudo nvim /etc/nginx/sites-available/static.mattcarlotta.sh'                                             # ngi:          Edit static images nginx config
alias ngt='sudo nginx -t'                                                                                           # ngt:          Test nginx configs
alias ngres='sudo systemctl restart nginx'                                                                          # ngres:        Restart nginx
alias ngrel='sudo systemctl reload nginx'                                                                           # ngrel:        Reload nginx

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
alias cbld='cargo build --release'                                                                                  # cbld:         Cargo build
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
alias tw='tmux neww'                                                                                                # tw:           New window
alias twn='tmux neww -n'                                                                                            # twn:          New named window
alias twdc='tmux nnew -d -c'                                                                                        # twdc:         New window at directory
alias tl='tmux list-sessions'                                                                                       # tl:           Lists active tmux sessions 
alias ts='tmux-sessionizer'                                                                                         # f:            Runs tmux-sessioner script
alias tconf='nvim ~/.tmux.conf'                                                                                     # tconf:        Edit tmux config
alias tback='cp ~/.tmux.conf ~/Documents/dotfiles/tmux; echo Backed up tmux conf'                                   # tback:        Back up tmux conf
