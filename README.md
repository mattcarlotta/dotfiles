# dotfiles

My setup to get a DE up and running.

![](https://raw.githubusercontent.com/mattcarlotta/dotfiles/main/nvim.png)

## Editor

- nvim

```DOSINI
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install neovim
```

- nvim packer

```DOSINI
mkdir ~/.config/nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
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

## JS/TS

- [nodejs](https://nodejs.org/en/)

```DOSINI
sudo apt-get install curl python-software-properties software-properties-common
(change 'xx.x' to current LTS version)
curl -sL https://deb.nodesource.com/setup_xx.x | sudo bash -
sudo apt-get install nodejs
```

- diagnosticls/eslint/tsserver/astro

```DOSINI
sudo npm install -g typescript typescript-language-server diagnostic-languageserver eslint_d @astrojs/language-server
```

## Rust

- cargo/rust

```DOSINI
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

- lsd

```DOSINI
cargo install lsd
```

- bat

```DOSINI
cargo install bat
```

- stylua

```DOSINI
cargo install stylua
```
