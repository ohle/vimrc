# vim configuration and plugins

## Installation
clone into `~/.vim`, then create symlinks to `vimrc` and one of the
`gvimrc`-files to `~/.vimrc` and `~/.gvimrc`:
```bash
$ cd ~
$ git clone https://github.com/ohle/vimrc.git ~/.vim
$ ln -s ~/.vim/vimrc ~/.vimrc
$ ln -s ~/.vim/gvimrc-mac ~/.vimrc
$ cd ~/.vim
$ git submodule init
$ git submodule update
```

## Installing plugins
Plugins are managed by the [`vimplug` plugin](https://github.com/junegunn/vim-plug/).
Unmanaged plugins go into `unmanaged-plugins/` and are registered with the
`Plug` command:

    Plug ~/.vim/unmanaged-plugins/pluginname

Most plugins live on github and are registered by their github ID and
automatically managed by `vimplug` in `bundle/`

## Configuration
Basic configuration happens in `vimrc`.

GUI stuff is configured in `gvimrc-${OS}`.

filetype-specific configuration should be put in `ftplugin/filetype.vim`.

Simple plugin configurations live in a fold in `vimrc`; more complex stuff
should go into `after/plugin/pluginname.vim`
