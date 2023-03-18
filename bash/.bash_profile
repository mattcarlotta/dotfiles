# Prints an error to shell
function print_error() {
    local error=$1
    local error_message="\n⛔ \033[91;1mERROR: $error"

    echo -e "$error_message\033[m"
}

# Prints not a git tracked folder to stdout
function print_not_git_tracked() {
  print_error "Unable to locate git status -- you may be not in a git tracked folder"
}

# Git status
function g_stat() {
  echo "$(git status 2>&1)"
}

# Check if git tracked
function not_git_tracked() {
  echo "$(g_stat | grep "not a git repository")"
}

# Current branch
function current_branch() {
  echo "$(g_stat | grep -e "On branch" | awk '{ print $3 }')"
}

# Detached head
function head_detached() {
  echo "$(g_stat | grep -e "HEAD detached" | awk '{ print $4 }')"
}

# Deletes staging branch
function delete_staging_branch() {
  git branch -D staging &>/dev/null
}

# Displays the file status of a git branch 
function check_branch_status() {
    local unstaged=$(g_stat | grep -e "Changes not staged" -e "Untracked files")
    local staged=$(g_stat | grep -e "Changes to be committed")
    local branch=$(current_branch)
    local detached_head=$(head_detached)
    local remote_branch=$(git remote -v)
    local unpushed_commits=$(git log origin/$branch..$branch 2>&1)
    local commit=$(git rev-parse --short HEAD 2>/dev/null)

    if [ ! -z "$detached_head" ]; then
        echo " ✂️  \[\033[96m\][branch:detached]"
    elif [ ! -z "$unstaged" ]; then
        echo " 🔴 \[\033[91m\][branch:unstaged]"
    elif [ ! -z "$staged" ]; then
        echo " 🟣 \[\033[95m\][branch:staged]"
    elif [ ! -z "$remote_branch" ] && [ ! -z "$unpushed_commits" ]; then
        echo " 📤 \[\033[96m\][branch:desynced(${commit:="unknown"})]"
    else
        echo " 🌱 \[\033[32m\][branch:current(${commit:="unknown"})]"
    fi
}

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

# Displays the status of a git branch if a parent folder is git tracked
function check_git_status() {
    local gitbranch=""
    if $(dir_is_tracked); then
        local gitbranchstatus=$(check_branch_status)
        local checkedoutbranch=$(current_branch)
        local detached_head=$(head_detached)

        gitbranch="🌿 \[\033[32m\][git:${checkedoutbranch:=$detached_head}]$gitbranchstatus"
    fi

    PS1="\[\033[34m\]┌─\[\033[m\] 🌀 \[\033[34m\][\u@\h] 📂 \[\033[33;1m\][\w\]]\[\033[m\] $gitbranch\[\033[m\]\n\[\033[34m\]└➤\[\033[m\] "
}

# Checks outs selected branch
function gbs() {
    if [[ ! -z $(not_git_tracked) ]]; then
        print_not_git_tracked
        return
    fi

    local branch=$(git branch -a | awk '{ print $0 }' | sed -e 's/\*/ /g' -e 's/[[:space:]]//g' | fzf)

    if [[ ! -z "$branch" ]]; then
        git checkout $branch
    fi
}

# Pushes commits up to origin using currently selected branch
function gpush() {
    local branch=$(current_branch)

    if [[ ! -z $(not_git_tracked) || -z $branch ]]; then
        print_not_git_tracked
        return
    fi


    git push $1 origin $branch
}

# Fuzzy finder for searching through bash history and invokes selection
function sbh() {
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

# Rebases current branch with upstream
function rbb() {
    local branch=$(current_branch)
    local stream=${1:-"origin"}

    if [[ ! -z $(not_git_tracked) || -z $branch ]]; then
        print_not_git_tracked
        return
    fi

    git fetch $stream
    if [[ $? -ne 0 ]]; then
        print_error "Failed to fetch $stream $branch"
        return
    fi

    git rebase $stream/$branch
    if [[ $? -ne 0 ]]; then
        print_error "Failed to rebase $stream $branch"
        return
    fi
}

# Rebases the forked headless branch and pushes updates to Github
function rbm() {
    git checkout main

    rbb

    git push origin main -f
    if [[ $? -ne 0 ]]; then
        print_error "Failed to push rebase commits to remote origin main"
        return
    fi
}

# Pulls in a remote PR branch into local repo
function pulldown() {
   local pull_id=$1 
   local branch=$2

   if [[ -z $pull_id ]]; then
      print_error "You must include a pull request number"
      return
   fi

   if [[ -z $branch ]]; then
      print_error "You must include a local branch to create"
      return
   fi

   git fetch upstream pull/$pull_id/head:$branch
   if [[ $? -ne 0 ]]; then
      print_error "Failed fetch PR#$pull_id from upstream"
      return
   fi

   git checkout $branch
}

# Deletes a local branch
function gbd() {
    if [[ ! -z $(not_git_tracked) ]]; then
        print_not_git_tracked
        return
    fi

    local branch=$(git branch | awk '{ print $0 }' | sed -e 's/\*/ /g' -e 's/[[:space:]]//g' | fzf)

    if [[ ! -z "$branch" ]]; then
       git checkout main 
       git branch -D $branch
    fi
}

# Checks out a remote branch and creates a local branch
function gchrb() {
    if [[ ! -z $(not_git_tracked) ]]; then
        print_not_git_tracked
        return
    fi

    local branch=$(git branch -a | awk '{ print $0 }' | sed -e 's/\*/ /g' -e 's/[[:space:]]//g' | grep -e 'remotes/upstream' | fzf)

    if [[ ! -z "$branch" ]]; then
       local remote_branch=$(echo $branch | sed 's/remotes\/upstream\///g') 
       git checkout -b $remote_branch upstream/$remote_branch
    fi
}

PROMPT_COMMAND=check_git_status

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=/usr/local/bin/nvim
export HISTSIZE=20000
shopt -s histappend

### BASH PROFILE ALIASES
alias c='clear'                                                                                                     # c:            Clear terminal display
alias c.='code .'                                                                                                   # c.:           Opens VSCode at directory
alias e='exit'                                                                                                      # e:            Exit terminal
alias bp='nvim ~/.bash_profile'                                                                                     # bp:           Access bash profile
alias bback='cp ~/.bash_profile ~/Documents/dotfiles/bash/.bash_profile; echo Backed up bash profile'               # bback:        Backup bash profile
alias sp='source ~/.bash_profile'                                                                                   # sp:           Sources bash profile

### DIRECTORY ALIASES
alias ..='cd ../'                                                                                                   # ..:           Go back 1 directory level
alias ...='cd ../../'                                                                                               # ...:          Go back 2 directory levels
alias cdd="cd ~/Documents"                                                                                          # cdd:          Change directory in Documents
alias cdde="cd ~/Desktop"                                                                                           # cdde:         Change directory in Desktop
alias cddw="cd ~/Downloads"                                                                                         # cddw:         Change directory in Downloads
alias ls='ls -AGFhl --color=auto'                                                                                   # ls:           List all files in current directory

### PROCESS ALIASES
alias fpid='lsof -i'                                                                                                # fpid:         Finds the process id running on specified port
alias k9='kill -9'                                                                                                  # k9:           Kills specified process id

### NVIM ALIASES
alias vinit='nvim ~/.config/nvim/init.lua'                                                                          # vinit:        Edit vim init
alias v.="nvim ."                                                                                                   # v.            Open vim in current directory
alias vim="nvim"                                                                                                    # vim:          Nvim alias
alias vback='cp -r ~/.config/nvim ~/Documents/dotfiles/; echo Backed up nvim files'                                 # vback:        Backup vim to ~/Documents/.dotfiles
alias vconf='cd ~/.config/nvim && vim .'                                                                            # vconf:        CD to nvim config and enter vim

### POSTGRESQL ALIASES
alias pg='psql -U postgres'                                                                                         # pg:           Connects to postgreSQL
alias initDB='psql -U postgres -f'                                                                                  # initsql:      Initializes a specified SQL database

### SSH ALIASES
alias shc='nvim ~/.ssh/config'                                                                                      # shc:          Edits SSH config
alias myw='ssh mywebsite'                                                                                           # myw:          SSH into my website
alias mys='ssh myserver'                                                                                            # mys:          SSH into my server
alias sjsapp='ssh sjsapp'                                                                                           # sjsapp:       SSH into my client server
alias rmssh='ssh-add -D'                                                                                            # rmmssh:       Remove all ssh keys from manager
alias noshot='ssh-add ~/.ssh/id_ed25519'                                                                            # noshot:       SSH with noshot
alias matt='ssh-add ~/.ssh/id_rsa'                                                                                  # matt:         SSH with matt

### GIT ALIASES
alias ga='git add .'                                                                                                # ga:           Tracks new files for git
alias gb='git branch'                                                                                               # gb:           Lists all local branches
alias gba='git branch -a'                                                                                           # gba:          Lists all local and remote branches
alias gc='git commit -am'                                                                                           # gc:           Commits new files for git
alias gca='git commit --amend'                                                                                      # gca:          Ammends staged changes to last commits
alias gcan='git commit --amend --no-edit'                                                                           # gcan:         Ammends staged changes to last commits and doesn't edit commit message
alias gchb='git checkout -b'                                                                                        # gchb:         Checks out a new branch
alias gx='git clean -df'                                                                                            # gx:           Removes untracked git files
alias gi='git init'                                                                                                 # gi:           Initialize directory for git
alias gd='git diff'                                                                                                 # gd:           Git diff
alias gds='git diff --staged'                                                                                       # gds:          Git diff staged
alias gfu='git fetch upstream'                                                                                      # gfu:          Fetches upstream commits/branches
alias gl='git log'                                                                                                  # gl:           Displays git logs
alias gp='git pull'                                                                                                 # gp:           Pulls from git branch
alias gpsh='git push origin'                                                                                        # gpsh:         Pushes commits to remote
alias gch='git checkout'                                                                                            # gch:          Checks out branch
alias gchb='git checkout -b'                                                                                        # gchb:         Creates and checks out branch
alias gchm='git checkout main'                                                                                      # gchm:         Checks out main branch
alias gs='git status'                                                                                               # gs:           Displays status of git tracking
alias gclr='git clean -f -d'                                                                                        # gclr:         Remove untracked git files
alias gt='git ls-files | xargs -I{} git log -1 --format="%ai {}" {}'                                                # gt:           Displays tracked files
alias clone='git clone'                                                                                             # clone:        Clone remote repo

### NGINX ALIASES
alias nga='sudo nvim /etc/nginx/sites-available/mattcarlotta.sh'                                                    # nga:          Edit app nginx config
alias ngi='sudo nvim /etc/nginx/sites-available/static.mattcarlotta.sh'                                             # ngi:          Edit static images nginx config
alias ngt='sudo nginx -t'                                                                                           # ngt:          Test nginx configs
alias ngres='sudo systemctl restart nginx'                                                                          # ngres:        Restart nginx
alias ngrel='sudo systemctl reload nginx'                                                                           # ngrel:        Reload nginx

#### YARN ALIASES
#alias y='yarn'                                                                                                      # y:            Run yarn install
#alias ya='yarn add'                                                                                                 # ya:           Add dependency to project
#alias yad='yarn add -D'                                                                                             # yad:          Add dev dependency to project
#alias yr='yarn remove'                                                                                              # yr:           Remove dependency from project
#alias yo='yarn outdated'                                                                                            # yo:           Check for outdated project dependencies
#alias yui='yarn upgrade-interactive --latest'                                                                       # yui:          Upgrade outdated project dependencies interactively
#alias ybr='yarn build && yarn start'                                                                                # ybr:          Runs yarn build and yarn start scripts
#alias yd='yarn dev'                                                                                                 # yd:           Runs yarn dev script command
#alias yb='yarn build'                                                                                               # yb:           Runs yarn build script command
#alias ys='yarn start'                                                                                               # ys:           Runs yarn start script command

### NPM (FORMERLY YARN) ALIASES
alias y='npm i'                                                                                                     # y:            Run npm install
alias ya='npm install -S'                                                                                           # ya:           Add dependency to project
alias yad='npm install -D'                                                                                          # yad:          Add dev dependency to project
alias yr='npm uninstall -S'                                                                                         # yr:           Remove dependency from project
alias yo='npm outdated'                                                                                             # yo:           Check for outdated project dependencies
alias yui='npm update -S'                                                                                          # yui:          Upgrade outdated project dependencies interactively
alias yb='npm run build'                                                                                            # yb:           Runs npm run build script command
alias yd='npm run dev'                                                                                              # yd:           Runs npm run dev script command
alias ys='npm start'                                                                                                # ys:           Runs npm start script command
alias yrun='npm run'                                                                                                # yrun:         Runs npm start script command

### CARGO ALIASES
alias crun='cargo run'                                                                                              # crun:         Cargo run
alias cbld='cargo build --release'                                                                                  # cbld:         Cargo build
alias crel='cargo run --release'                                                                                    # crel:         Cargo run with release
alias cwat='cargo watch -x run'                                                                                     # cwat:         Cargo watch
alias cclp='cargo clippy'                                                                                           # cclp:         Cargo clippy

### CONKY
alias cconf='sudo nvim /etc/conky/conky.conf'                                                                       # cconf:        Edit conky conf

### TMUX ALIASES
alias t='tmux'                                                                                                      # t:            Runs tmux
alias ta='tmux a'                                                                                                   # ta:           Runs tmux attach
alias tk='tmux kill-server'                                                                                         # tk:           Kills tmux server
alias tw='tmux neww'                                                                                                # tw:           New window
alias twdc='tmux nnew -d -c'                                                                                        # twdc:         New window at directory
alias tl='tmux list-sessions'                                                                                       # tl:           Lists active tmux sessions 
alias ts='tmux-sessionizer'                                                                                         # f:            Runs tmux-sessioner script
alias tconf='nvim ~/.tmux.conf'                                                                                     # tconf:        Edit tmux config
alias tback='cp ~/.tmux.conf ~/Documents/dotfiles/tmux; echo Backed up tmux conf'                                   # tback:        Back up tmux conf
