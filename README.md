# WSL2 NEOVIM CONFIG

[Follow this Playlist from Christian Chiarulli for Guides](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ).

## Before setting this up ⚠️ **FORK AT YOUR OWN RISK**  ⚠️

- I use this configurations mainly on my Pengwin distro under WSL2.

  **Make sure you really know what you're doing**

- All plugins are up to date. Fixed also outdated plugins specifications.

## Without further ado Lezzgaw!

➡️  Install [Neovim v0.6.0](https://github.com/neovim/neovim/releases/tag/v0.6.0) or [Nightly](https://github.com/neovim/neovim/releases/tag/nightly). Using `linuxbrew`

```
brew install neovim
```

➡️  Remove or move your current `nvim` directory
 
➡️  If you have packers.nvim installed remove it
 
➡️  Clone
 
```
git clone https://github.com/LunarVim/Neovim-from-scratch.git ~/.config/nvim
```

➡️  Run `nvim` and wait for the plugins to be installed 

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim) 

## Check NVIM health status


➡️  Open `nvim` and enter the following:

```
:checkhealth
```

**IF ALL IS WELL. YOU'RE GOOD TO GO. GOOD LUCK, COMRADE!**
