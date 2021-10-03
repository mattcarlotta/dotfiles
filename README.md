# dotfiles

## Requirements

### Editor

- nvim

```DOSINI
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl
git clone --branch release-0.5 git@github.com:neovim/neovim.git
make CMAKE_BUILD_TYPE=Release
sudo make install
```

- vim plugged

```DOSINI
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

- fzf

```DOSINI
sudo apt-get install fzf
```

- ripgrep

```DOSINI
sudo apt-get install ripgrep
```

- tmux

```DOSINI
sudo apt-get install tmux
```

### JS/TS

- [nodejs](https://nodejs.org/en/)

```DOSINI
sudo apt-get install curl python-software-properties software-properties-common
(change 'xx.x' to current LTS version)
curl -sL https://deb.nodesource.com/setup_xx.x | sudo bash -
sudo apt-get install nodejs
```

- diagnosticls/eslint/tsserver/yarn

```DOSINI
sudo npm install -g yarn typescript typescript-language-server diagnostic-languageserver eslint_d
```

### Rust

- cargo/rust

```DOSINI
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup default nightly
```
