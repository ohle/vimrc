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

    Plug ~/.vim/unmanaged-plugins/foo


### Archive format
Unpack into `.vim/bundle/pluginname`
### Vimball

```bash
$ mkdir ~/.vim/bundle/pluginname
$ vim plugin.vba
```
then
```vim
:UseVimball ~/.vim/bundle/pluginname
```
### github
```bash
$ cd ~/.vim
$ git submodule add https://github.com/foo/bar bundle/bar
```
To update submodules from github:
```bash
$ git submodule foreach git pull origin master
```

## Configuration
Basic configuration happens in `vimrc`.
GUI stuff is configured in `gvimrc-${OS}`.
filetype-specific configuration should be put in `ftplugin/filetype.vim`
Plugins should be configured by creating a file according to the scheme
`bundle/pluginname-options/plugin/pluginnamerc.vim`.
