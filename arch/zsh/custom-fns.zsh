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
  echo "$(git status --ignore-submodules=all 2>&1)"
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
        echo "\e[0m\e[30;42m\uE0B1\e[0m\e[30;42m  [branch:detached] \e[0m\e[32m\uE0B0\e[0m"
    elif [ ! -z "$unstaged" ]; then
        echo "\e[32;41m\uE0B0\e[0m\e[30;41m [branch:unstaged] \e[0m\e[31m\uE0B0\e[0m"
    elif [ ! -z "$staged" ]; then
        echo "\e[32;105m\uE0B0\e[0m\e[30;105m [branch:staged] \e[0m\e[95m\uE0B0\e[0m"
    elif [ ! -z "$remote_branch" ] && [ ! -z "$unpushed_commits" ]; then
        echo "\e[0m\e[30;42m\uE0B1\e[0m\e[30;42m [branch:desynced(${commit:="unknown"})] \e[0m\e[32m\uE0B0\e[0m"
    else
        echo "\e[0m\e[30;42m\uE0B1\e[0m\e[30;42m [branch:current(${commit:="unknown"})] \e[0m\e[32m\uE0B0\e[0m"
    fi
}

# Parses the parent directories of the current working directory to determine if any are git tracked
function dir_is_tracked() {
    IFS='\/'
    read -rA CWD<<< "$PWD"
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
    local gitbranch="\e[0m\e[33m\uE0B0\e[0m"
    if $(dir_is_tracked); then
        local gitbranchstatus=$(check_branch_status)
        local checkedoutbranch=$(current_branch)
        local detached_head=$(head_detached)

        gitbranch="\e[0m\e[33;42m\uE0B0\e[0m\e[30;42m \uE0A0 [git:${checkedoutbranch:=$detached_head}] \e[0m$gitbranchstatus"
    fi

    local user=$(echo -e "\e[0;34m\uE0B2\e[0m\e[30;44m \u25C8 [%n@%m] \e[0m\e[34;43m\uE0B0\e[0m")
    local directory=$(echo -e "\e[30;43m \u25C9 [%~] ")
    echo -e "\e[34m┌─\e[0m$user$directory$gitbranch \n\e[34m└➤\e[0m "
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
    local selection=$(cat ~/.zsh_history | awk '{$1="";print $0}' | awk '!a[$0]++' | tac | fzf | sed 's/^[[:space:]]*//')
    local selectiontext="${selection:0:40}"

    if [[ ! -z $selection ]]; then
        # if (( ${#selection} > 40 )); then
        #     selectiontext+="... +$(expr length "${selection: 40}") characters" 
        # fi
        echo -e "✨ Invoked \033[35;1m$selection\033[m from zsh history! ✨"
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

# Remove duplicate entries from PATH
function rp() {
    if [[ -x /usr/bin/awk ]]; then
        export PATH="$(echo "$PATH" | /usr/bin/awk 'BEGIN { RS=":"; } { sub(sprintf("%c$", 10), ""); if (A[$0]) {} else { A[$0]=1; printf(((NR==1) ?"" : ":") $0) }}')"
        echo $PATH
    else
        echo "AWK is not located at /usr/bin/awk" # for the truly paranoid
    fi
}
