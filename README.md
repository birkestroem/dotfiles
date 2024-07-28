# My Dotfiles

These are my dotfiles and preferences in settings. Clone the repository and run `./install.sh` to install these files. Caution: it will overwrite existing files.

Running install will create a symlink to the `~/.zshrc` file that contains common and universal settings. It will also add the `~/.zshrc.local` which is a symlink to a host local zshrc located in this repository.

## Dependencies

- miniconda3
- fzf
- k8s/docker