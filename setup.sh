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

function log_error() {
    echo -e "\n❌ ${bold}${red}ERROR: $1 ${normal}\n"
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

function copy_bash_files() {
    for file in "${gBashFiles[@]}"
    do
        cp ./bash/$file $gUserRootDir/$file
        log_success "Copied $file -> $gUserRootDir/$file."
    done

    source "$gUserRootDir/${gBashFiles[0]}"
    log_success "Sourced $gUserRootDir/${gBashFiles[0]}"
}

function install_nvim () {
    local nvim_bin=$(which nvim)
    if [ ! -z $nvim_bin ];
    then
        skip_warning nvim
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
}

function copy_nvim_files() {
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

    cp -rf ./nvim $gUserRootDir/nvim
    log_success "Copied all of the nvim config files -> $nvim_dir"
    log_info "You must manually open $nvim_dir/lua/m6d/packer.lua within nvim and run :PackerSync to install nvim dependencies!"
}

function install_fzf() {
    local fzf_bin=$(which fzf)
    if [ ! -z $fzf_bin ];
    then
        skip_warning fzf
        return;
    fi

    apt-get install fzf -y
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install fzf."
    fi

    log_success "Installed fzf -> $(which fzf)"
}

function install_ripgrep() {
    local rg_bin=$(which rg)
    if [ ! -z $rg_bin ];
    then
        skip_warning rg
        return;
    fi

    apt-get install ripgrep -y
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install ripgrep."
    fi

    log_success "Installed ripgrep -> $(which rg)"
}


function install_tmux() {
    local tmux_bin=$(which tmux)
    if [ ! -z $tmux_bin ];
    then
        skip_warning tmux
        return;
    fi

    apt-get install tmux -y
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install tmux."
    fi

    log_success "Installed tmux -> $(which tmux)"
}

function install_node() {
    local node_bin=$(which node)
    if [ ! -z $node_bin ];
    then
        skip_warning node
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
}

function install_lsps() {
    local lang_server=(tsc typescript-language-server diagnostic-languageserver eslint_d)

    local install_lang_servers=""
    for lang in "${lang_server[@]}"
    do
        local lang_bin=$(which $lang) 
        if [ ! -z $lang_bin ];
        then
            skip_warning "$lang"
        else 
            log_info "It appears $lang is not installed yet."
            install_lang_servers+="$lang "
        fi
    done

    if [ ! -z $install_lang_servers ];
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
}

function install_cargo_rust() {
    local cargo_user_bin=$gUserCargoRootDir/cargo
    local cargo_bin=$(which cargo)
    if [ -f $cargo_user_bin ] || [ ! -z cargo_bin ];
    then
        log_warning "It appears that cargo rust is already installed in ${cargo_user_bin:-$cargo_bin}. Skipping."
        return;
    fi

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install cargo rust."
    fi

    cargo_bin=$(which cargo)
    log_success "Installed rust -> ${cargo_user_bin:-$cargo_bin}."
}

function install_lsd() {
    local lsd_bin=$gUserCargoRootDir/lsd
    if [ ! -z $lsd_bin ];
    then
        log_warning "It appears that lsd is already installed in $lsd_bin. Skipping."
        return;
    fi

    cargo install lsd
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install lsd."
    fi

    log_success "Installed lsd -> $lsd_bin."
}

function install_stylua() {
    local stylua_bin=$gUserCargoRootDir/stylua
    if [ ! -z $stylua_bin ];
    then
        log_warning "It appears that stylua is already installed in $stylua_bin. Skipping."
        return;
    fi

    cargo install stylua
    if [[ $? -ne 0 ]];
    then
        log_error "Failed to install stylua."
    fi

    log_success "Installed stylua -> $stylua_bin."
}

function success_message() {
    local set_foreground=$(tput setaf 7)
    local set_background=$(tput setab 4)

    echo -ne "\n🚀 \e[3m${bold}${set_foreground}${set_background} One man’s crappy software is another man’s full time job. Enjoy! ${normal}\e[0m\n"
}

function end_session() {
    echo -e "${cyan}\n---------------------------------------------- END OF SCRIPT ------------------------------------------------${normal}\n"
}

function main() {
    begin_session
    copy_bash_files
    install_nvim
    copy_nvim_files
    install_fzf
    install_ripgrep
    install_tmux
    install_node
    install_lsps
    install_cargo_rust
    install_lsd
    install_stylua
    success_message
    end_session
    exit 0
}

trap '{ end_session; exit 1; }' INT


if [ "$(id -u)" -ne 0 ];
  then
    log_warning "This script must be run as a ${underline}ROOT USER${nounderline}!\n"
    sudo "$0"
  else
    main $1
fi
