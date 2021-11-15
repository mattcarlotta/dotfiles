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
    local unpushed_commits=$(git log origin/$branch..$branch 2>&1)
    local commit=$(git rev-parse --short HEAD)

    if [ ! -z "$unstaged" ]; then
        echo " 🔴 \[\033[91m\][branch:unstaged]"
    elif [ ! -z "$staged" ]; then
        echo " 🟣 \[\033[95m\][branch:staged]"
    elif [ ! -z "$remote_branch" ] && [ ! -z "$unpushed_commits" ]; then
        echo " 📤 \[\033[96m\][branch:desynced($commit)]"
    else
        echo " 🌱 \[\033[32m\][branch:current($commit)]"
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

# Fuzzy finder for searching through bash history and invokes selection
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

# Prints a success message to shell
function print_success() {
    local action=$1
    local input_file=$2
    local output_file=$3

    echo -e "\n✨ Successfully $action \033[35;1m$input_file\033[m and saved the result to \033[35;1m$output_file\033[m ✨"
}

# Prints an error to shell
function print_error() {
    local error_code=$1
    local error=$2
    local error_message="\n⛔ \033[91;1mERROR: "

    case $error_code in
    1)
        error_message+="You must include an input file to $error!" 
        ;;
    2)
        error_message+="You must include an output file to save the $error result!"
        ;;
    *)
        error_message+="$error"
        ;;
    esac

    echo -e "$error_message\033[m"
}

# Invokes openssl with arguments
function openssl_proc() {
    local error=$(openssl enc -base64 -aes-256-cbc -md sha256 $1 -salt -pbkdf2 -in $2 -out $3 2>&1)
    echo "$error"
}

# Encrypts a file using OpenSSL with a password (asked upon execution) and saves it to a new file
function encrypt_file() {
    local input_file=$1
    local output_file=$2

    if [[ -z $input_file ]]; then
        print_error 1 "encrypt"
        return
    fi

    if [[ -z $output_file ]]; then
        print_error 2 "encrypted"
        return
    fi

    local error=$(openssl_proc -e $input_file $output_file)
    if [[ -z $error ]]; then
        print_success "encrypted" "$input_file" "$output_file"
    else
        print_error 3 "Unable to encrypt $input_file because...\n$error"
    fi
}


# Decrypts a file using OpenSSL with a password (asked upon execution) and saves it to a new file
function decrypt_file() {
    local input_file=$1
    local output_file=$2

    if [[ -z $input_file ]]; then
        print_error 1 "decrypt"
        return
    fi

    if [[ -z $output_file ]]; then
        print_error 2 "decrypted"
        return
    fi

    local error=$(openssl_proc -d $input_file $output_file)
    if [[ -z $error ]]; then
        print_success "decrypted" "$input_file" "$output_file"
    else
        print_error 3 "Unable to decrypt $input_file because...\n$error"
    fi
}


PROMPT_COMMAND=check_git_status

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

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
alias ls='ls -AGFhl --color=auto'                                                                                   # ls:           List all files in current directory

### PROCESS ALIASES
alias fpid='lsof -i'                                                                                                # fpid:         Finds the process id running on specified port
alias k9='kill -9'                                                                                                  # k9:           Kills specified process id

### NVIM ALIASES
alias vinit='nvim ~/.config/nvim/init.vim'                                                                          # vinit:        Edit vim init
alias v.="nvim ."                                                                                                   # v.            Open vim in current directory
alias vim="nvim"                                                                                                    # vim:          Nvim alias
alias vback='cp -r ~/.config/nvim ~/Documents/dotfiles/; echo Backed up dot files'                                  # vback:        Backup vim to ~/Documents/.dotfiles

### POSTGRESQL ALIASES
alias pg='psql -U postgres'                                                                                         # pg:           Connects to postgreSQL
alias initDB='psql -U postgres -f'                                                                                  # initsql:      Initializes a specified SQL database

### SSH ALIASES
alias shc='nvim ~/.ssh/config'                                                                                      # shc:          Edits SSH config
alias mys='ssh myserver'                                                                                            # mys:          SSH into my server
alias sjsapp='ssh sjsapp'                                                                                           # sjsapp:       SSH into my client server
alias rmssh='ssh-add -D'                                                                                            # rmmssh:       Remove all ssh keys from manager
alias noshot='ssh-add ~/.ssh/id_ed25519'                                                                            # noshot:       SSH with noshot
alias matt='ssh-add ~/.ssh/id_rsa'                                                                                  # matt:         SSH with matt

### CUSTOM FUNCTION ALIASES
alias enc=encrypt_file                                                                                              # enc:          Encrypts file, usage: enc input.txt output.enc
alias dec=decrypt_file                                                                                              # dec:          Decrypts file, usage: dec input.dat output.txt
alias sbh=search_bash_history                                                                                       # sbh:          Searches bash history using fzf

### GIT ALIASES
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

### NGINX ALIASES
alias nga='sudo nvim /etc/nginx/sites-available/mattcarlotta.sh'                                                    # nga:          Edit app nginx config
alias ngi='sudo nvim /etc/nginx/sites-available/static.mattcarlotta.sh'                                             # ngi:          Edit static images nginx config
alias ngt='sudo nginx -t'                                                                                           # ngt:          Test nginx configs
alias ngres='sudo systemctl restart nginx'                                                                          # ngres:        Restart nginx
alias ngrel='sudo systemctl reload nginx'                                                                           # ngrel:        Reload nginx

### YARN ALIASES
alias y='yarn'                                                                                                      # y:            Run yarn install
alias ya='yarn add'                                                                                                 # ya:           Add dependency to project
alias yad='yarn add -D'                                                                                             # yad:          Add dev dependency to project
alias yr='yarn remove'                                                                                              # yr:           Remove dependency from project
alias yo='yarn outdated'                                                                                            # yo:           Check for outdated project dependencies
alias yd='yarn dev'                                                                                                 # yd:           Runs yarn dev script command
alias ys='yarn start'                                                                                               # ys:           Runs yarn start script command

### CARGO ALIASES
alias crun='cargo run'                                                                                              # crun:         Cargo run
alias cbld='cargo build --release'                                                                                  # cbld:         Cargo build
alias crel='cargo run --release'                                                                                    # crel:         Cargo run with release
alias cwat='cargo watch -x run'                                                                                     # cwat:         Cargo watch
alias cclp='cargo clippy'                                                                                           # cclp:         Cargo clippy

### TMUX ALIASES
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
