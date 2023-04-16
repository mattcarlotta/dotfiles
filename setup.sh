#!/bin/bash
#
# Script to automagically set up my dev environment on a Linux OS (Mac OS coming soon™️)
#
# Copyright (c) 2023 by Matt Carlotta
#
# Bugs:
#     - Bug reports can be filed at: https://github.com/mattcarlotta/dotfiles/issues
#        Please provide clear steps to reproduce the bug and the output of the
#        script. Thank you!
#

gCurrentDate=$(/bin/date +"%m/%d/%Y %I:%M %p")

gUserRootDir=/home/$SUDO_USER

gUserCargoRootDir=$gUserRootDir/cargo/.bin

gUserPnpmRootDir=$gUserRootDir/.local/share/pnpm

gBashFiles=('.bash_profile' 'alias.sh' 'custom-fns.sh')

bold=$(tput bold)
underline=$(tput smul)
nounderline=$(tput rmul)
normal=$(tput sgr0)
black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)

function log_empty_line() {
    echo -e " "
}

function log_message() {
    echo -e "🤖 ${bold}${cyan}$1 ${normal}"
}
function log_error() {
    echo -e "\n❌ ${bold}${red}ERROR: $1 ${normal}"
    log_message "I was unable to complete my mission. Self destructing... 💥\n"
    exit 1
}

function log_warning() {
    echo -e "⚠️  ${bold}${yellow}$1 ${normal}"
}

function skip_warning() {
    local bin=$(which $1)
    log_warning "It appears $1 is already installed in $bin. Skipping."
}

function log_info() {
    echo -e "ℹ️  ${bold}${blue}$1 ${normal}"
}

function log_success() {
    echo -e "✅ ${bold}${green}$1 ${normal}"
}

function begin_session() {
    echo -e "${cyan}------------------------------------ SCRIPT STARTED ON $gCurrentDate ----------------------------------${normal}\n"
}

function welcome_message() {
    log_message "Welcome, space traveler, I am 343 Guilty Spark! I am the mission delegator for this installation."
    sleep 3
    log_empty_line
    log_message "Hold one moment while I prepare your mission..."
    sleep 3
    log_empty_line
    log_message "Done!"
    sleep .75
    log_empty_line
    log_message "Yay!"
    sleep .75
    log_empty_line
    log_message "My... \e[3mI\e[23m am a genius."
    sleep 2
    log_empty_line
    log_message "Initializing the mission within your HUD. You should see it in..."
    sleep 2
    log_empty_line
    local messages=("3" "2" "1")
    for message in "${messages[@]}"
    do
        log_message "$message..."
        sleep 1
        log_empty_line
    done
}

function copy_bash_files() {
    log_message "Attempting to copy bash files..."
    for file in "${gBashFiles[@]}"
    do
        cp ./bash/$file $gUserRootDir/$file
        log_success "Copied $file -> $gUserRootDir/$file."
    done
    log_info "You must manually run \e[45m${white} source $gUserRootDir/.bash_profile ${blue}\e[49m as \e[45m${white} $SUDO_USER ${blue}\e[49m to update that bash profile!"
    log_empty_line
}

function install_nvim () {
    log_message "Attempting to install nvim..."
    local nvim_bin=$(which nvim)
    if [ ! -z $nvim_bin ];
    then
        skip_warning nvim
        log_empty_line
        return;
    fi

    add-apt-repository ppa:neovim-ppa/unstable -y
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to add neovim-ppa as an apt repo. Make sure your network connection is active!"
    else
        log_success "Added ppa:neovim-ppa/unstable to apt repository."
    fi

    apt-get update

    apt-get install neovim -y
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install neovim."
    else
        log_success "Installed nvim -> $(which nvim)"
    fi
    log_empty_line
}

function copy_nvim_files() {
    log_message "Attempting to copy nvim files..."
    local nvim_dir=$gUserRootDir/.config/nvim
    if [ -d $nvim_dir ];
    then
        log_warning "It appears the nvim config directory $nvim_dir already exists. Skipping."
    else 
        mkdir -p $nvim_dir
        log_success "Created the nvim config directory -> $nvim_dir."
    fi

    local nvim_packer_dir=$gUserRootDir/.local/share/nvim/site/pack/packer/start/packer.nvim
    if [ -d $nvim_packer_dir ];
    then
        log_warning "It appears that the nvim packer directory already exists and may already be installed. Skipping."
    else 
        git clone --depth 1 https://github.com/wbthomason/packer.nvim $nvim_packer_dir
        if [[ $? -ne 0 ]];
        then
            log_error "Failed to install nvim packer. Make sure your network connection is active!"
        else
            log_success "Installed packer nvim -> $nvim_packer_dir."
        fi
    fi

    cp -rf ./nvim $gUserRootDir/.config/nvim
    log_success "Copied all of the nvim config files -> $nvim_dir"
    log_info "You must manually open \e[45m${white} $nvim_dir/lua/m6d/packer.lua ${blue}\e[49m within nvim and run \e[45m${white} :PackerSync ${blue}\e[49m to install nvim dependencies!"
    log_empty_line
}


function install_fzf() {
    log_message "Attempting to install fzf..."
    local fzf_bin=$(which fzf)
    if [ ! -z $fzf_bin ];
    then
        skip_warning fzf
        log_empty_line
        return;
    fi

    apt-get install fzf -y
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install fzf."
    fi

    log_success "Installed fzf -> $(which fzf)"
    log_empty_line
}

function install_ripgrep() {
    log_message "Attempting to install ripgrep..."
    local rg_bin=$(which rg)
    if [ ! -z $rg_bin ];
    then
        skip_warning rg
        log_empty_line
        return;
    fi

    apt-get install ripgrep -y
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install ripgrep."
    fi

    log_success "Installed ripgrep -> $(which rg)"
    log_empty_line
}

function install_tmux() {
    log_message "Attempting to install tmux..."
    local tmux_bin=$(which tmux)
    if [ ! -z $tmux_bin ];
    then
        skip_warning tmux
        log_empty_line
        return;
    fi

    apt-get install tmux -y
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install tmux."
    fi

    log_success "Installed tmux -> $(which tmux)"
    log_empty_line
}

function copy_tmux_files() {
    log_message "Attempting to copy tmux files..."

    cp -rf ./tmux/* $gUserRootDir
    log_success "Copied all of the tmux config files -> $gUserRootDir"
    log_empty_line
}


function install_conky() {
    log_message "Attempting to install conky..."
    local conky_bin=$(which conky)
    if [ ! -z $conky_bin ];
    then
        skip_warning conky
        log_empty_line
        return;
    fi

    apt-get install conky conky-all lm-sensors hddtemp -y
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install conky."
    fi

    log_success "Installed conky -> $(which conky)"
    cp -rf ./conky.conf /etc/conky/
    log_success "Copied the conky config file to /etc/conky/"
    log_empty_line
}

function install_node() {
    log_message "Attempting to install node..."
    local node_bin=$(which node)
    if [ ! -z $node_bin ];
    then
        skip_warning node
        log_empty_line
        return;
    fi

    local curl_bin=$(which curl)
    if [ -z $curl_bin ];
    then
        log_info "It appears curl is missing. Installing..."

        apt install -y curl
        if [[ $? -ne 0 ]];
        then
          log_error "Failed to install curl."
        else
          log_success "Installed curl -> $(which curl)"
        fi
    fi

    read -p "💬 ${cyan}Attempting to install node. Which version of node would you like to install? (eg: 16, 18, 20... etc)? " choice
    curl -fsSL https://deb.nodesource.com/setup_$choice.x | sudo -E bash -
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to add node ppa key."
    else
        log_success "Installed node ppa key"
    fi

    apt-get install node -y
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install node."
    fi

    log_success "Installed node -> $(which node)"
    log_empty_line
}

function install_pnpm() {
    log_message "Attempting to install pnpm..."
    local pnpm_user_bin=$gUserCargoRootDir/pnpm
    local pnpm_bin=$(which pnpm)
    if [ -f $pnpm_user_bin ] || [ ! -z pnpm_bin ];
    then
        log_warning "It appears pnpm is already installed in ${pnpm_user_bin:-$pnpm_bin}. Skipping."
        log_empty_line
        return;
    fi

    curl -fsSL https://get.pnpm.io/install.sh | sh -
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install pnpm."
    fi

    pnpm_bin=$(which pnpm)
    log_success "Installed pnpm -> ${pnpm_user_bin:-$pnpm_bin}."
    log_empty_line
}

function install_lsps() {
    log_message "Attempting to install language servers..."
    local lang_server=(tsc typescript-language-server diagnostic-languageserver eslint_d astro-ls)

    local install_lang_servers=""
    for lang in "${lang_server[@]}"
    do
        local lang_bin=$(which $lang) 
        if [ ! -z $lang_bin ];
        then
            skip_warning "$lang"
        else 
            local lsp_name=$lang
            local lsp=$lang
            case $lang in 
                "tsc")
                    lsp_name="typescript"
                    ;;
                "astro-ls")
                    lsp_name="astro"
                    lsp="@astrojs/language-server"
                    ;;
                *)
                    ;;
            esac

            log_info "It appears $lsp_name is not installed yet."
            install_lang_servers+="$lsp "
        fi
    done

    if [[ ! -z $install_lang_servers ]];
    then
        npm install -g $install_lang_servers
        if [[ $? -ne 0 ]];
        then
            log_error "Failed to install $install_lang_servers."
        else
            log_success "Installed the following LSPs -> $install_lang_servers"
        fi
    else
        log_warning "It appears all of the required LSPs are already installed."
    fi
    log_empty_line
}

function install_cargo_rust() {
    log_message "Attempting to install cargo rust..."
    local cargo_user_bin=$gUserCargoRootDir/cargo
    local cargo_bin=$(which cargo)
    if [ -f $cargo_user_bin ] || [ ! -z $cargo_bin ];
    then
        log_warning "It appears cargo rust is already installed in ${cargo_user_bin:-$cargo_bin}. Skipping."
        log_empty_line
        return;
    fi

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install cargo rust."
    fi

    cargo_bin=$(which cargo)
    log_success "Installed rust -> ${cargo_user_bin:-$cargo_bin}."
    log_empty_line
}

function install_lsd() {
    log_message "Attempting to install lsd..."
    local lsd_bin=$gUserCargoRootDir/lsd
    if [ -f $lsd_bin ];
    then
        log_warning "It appears that lsd is already installed in $lsd_bin. Skipping."
        log_empty_line
        return;
    fi

    cargo install lsd
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install lsd."
    fi

    log_success "Installed lsd -> $lsd_bin."
    log_empty_line
}

function install_stylua() {
    log_message "Attempting to install stylua..."
    local stylua_bin=$gUserCargoRootDir/stylua
    if [ -f $stylua_bin ];
    then
        log_warning "It appears that stylua is already installed in $stylua_bin. Skipping."
        log_empty_line
        return;
    fi

    cargo install stylua
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install stylua."
    fi

    log_success "Installed stylua -> $stylua_bin."
    log_empty_line
}

function success_message() {
    local sign_off_messages=("Oh wow... We actually made it." "We actually made it." "I didn't believe we could do it. But we did..." "My... \e[3mI\e[23m am a genius." "I leave you with these parting words..." "\e[3mOne man's crappy software is another man's full time job.\e[23m")
    for message in "${sign_off_messages[@]}"
    do
        log_message "$message"
        sleep 2
        log_empty_line
    done
    log_message "See you again, space traveler!"
    sleep 1
}

function end_session() {
    echo -e "${cyan}\n---------------------------------------------- END OF SCRIPT ------------------------------------------------${normal}\n"
}

function main() {
    local skip_beginning_message=$1
    local skip_ending_message=$2
    clear
    begin_session
    if [ -z $skip_beginning_message ];
    then
        welcome_message
    fi
    copy_bash_files
    install_nvim
    copy_nvim_files
    install_fzf
    install_ripgrep
    install_tmux
    copy_tmux_files
    install_conky
    install_node
    install_pnpm
    install_lsps
    install_cargo_rust
    install_lsd
    install_stylua
    if [ -z $skip_ending_message ];
    then
        success_message
    fi
    end_session
    exit 0
}

trap '{ exit 1; }' INT

if [ "$(id -u)" -ne 0 ];
  then
    log_warning "This script must be run as a ${underline}ROOT USER${nounderline}!\n"
    sudo "$0" $1 $2
  else
    main $1 $2
fi
