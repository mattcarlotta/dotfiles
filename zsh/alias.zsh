#### MISC ALIASES
alias c='clear'                                                                                                     # c:            Clear terminal display
alias c.='code .'                                                                                                   # c.:           Opens VSCode at directory
alias e='exit'                                                                                                      # e:            Exit terminal
alias cat='bat'                                                                                                     # cat:          Replace cat with bat

#### BASH PROFILE ALIASES
alias bp='nvim ~/.bash_profile'                                                                                     # bp:           Edit bash profile
alias bb='cp ~/.bash_profile ~/Documents/dotfiles/bash/.bash_profile; echo Backed up bash profile'                  # bb:           Backup bash profile
alias bab='cp ~/alias.sh ~/Documents/dotfiles/bash/alias.sh; echo Backed up bash alias'                             # ba:           Backup bash alias script
alias bcb='cp ~/custom-fns.sh ~/Documents/dotfiles/bash/custom-fns.sh; echo Backed up bash custom fns'              # bcb:          Backup bash custom fns script
alias sp='source ~/.bash_profile'                                                                                   # sp:           Sources bash profile

#### ZSH PROFILE ALIASES
alias zp='nvim ~/.zshrc'                                                                                            # zp:           Edit zsh profile
alias bz='cp ~/.zshrc ~/Documents/dotfiles/zsh/.zshrc; echo Backed up zsh profile'                                  # bz:           Backup zsh profile
alias bza='cp ~/alias.zsh ~/Documents/dotfiles/zsh/alias.zsh; echo Backed up zsh alias'                             # bza:          Backup zsh alias script
alias bzc='cp ~/custom-fns.sh ~/Documents/dotfiles/zsh/custom-fns.zsh; echo Backed up zsh custom fns'               # bzc:          Backup zsh custom fns script
alias sz='source ~/.zshrc'                                                                                          # sz:           Sources zsh profile

### DIRECTORY ALIASES
alias ..='cd ../'                                                                                                   # ..:           Go back 1 directory level
alias ...='cd ../../'                                                                                               # ...:          Go back 2 directory levels
alias cdd="cd ~/Documents"                                                                                          # cdd:          Change directory in Documents
alias cdde="cd ~/Desktop"                                                                                           # cdde:         Change directory in Desktop
alias cddw="cd ~/Downloads"                                                                                         # cddw:         Change directory in Downloads
alias ls='ls -AGFhl --color=auto'                                                                                   # ls:           List all files in current directory
alias lsd='lsd -a'                                                                                                  # lsd:          List all files in current directory

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
alias gcan='git commit --amend --no-edit'                                                                           # gcan:         Ammends staged changes to last commits without editing commit message
alias gcan='git commit --amend --no-edit && gpush -f'                                                               # gcan:         Ammends staged changes to last commits without editing commit message and pushes up to remote
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
alias gs='git status --ignore-submodules=all'                                                                       # gs:           Displays status of git tracking
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
#alias y='npm i'                                                                                                     # y:            Run npm install
#alias ya='npm install -S'                                                                                           # ya:           Add dependency to project
#alias yad='npm install -D'                                                                                          # yad:          Add dev dependency to project
#alias yr='npm uninstall -S'                                                                                         # yr:           Remove dependency from project
#alias yo='npm outdated'                                                                                             # yo:           Check for outdated project dependencies
#alias yui='npm update -S'                                                                                           # yui:          Upgrade outdated project dependencies interactively
#alias yb='npm run build'                                                                                            # yb:           Runs npm run build script command
#alias yd='npm run dev'                                                                                              # yd:           Runs npm run dev script command
#alias ys='npm start'                                                                                                # ys:           Runs npm start script command
#alias yrun='npm run'                                                                                                # yrun:         Runs npm start script command

alias y='pnpm i'                                                                                                     # y:            Run npm install
alias ya='pnpm add'                                                                                                  # ya:           Add dependency to project
alias yad='pnpm add -D'                                                                                              # yad:          Add dev dependency to project
alias yr='pnpm rm'                                                                                                   # yr:           Remove dependency from project
alias yo='pnpm outdated'                                                                                             # yo:           Check for outdated project dependencies
alias yui='pnpm update -i'                                                                                           # yui:          Upgrade outdated project dependencies interactively
alias yb='pnpm run build'                                                                                            # yb:           Runs npm run build script command
alias yd='pnpm run dev'                                                                                              # yd:           Runs npm run dev script command
alias ys='pnpm start'                                                                                                # ys:           Runs npm start script command
alias yrun='pnpm run'                                                                                                # yrun:         Runs npm start script command

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

