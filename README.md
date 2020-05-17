# vim-chezmoi
vim-chezmoi is a plugin for vim to apply the dotfile you are editing to [chezmoi](https://github.com/twpayne/chezmoi), on `:w`.

It does not currently work with opening the source files directly(i.e `vim ~/.local/share/dotfile`), only `chezmoi edit dotfile`.

# Install with vim-plug

```vim
" ~/.vimrc
Plug 'Lilja/vim-chezmoi'
```

and then
```vim
" ~/.vimrc
let g:chezmoi = "enabled"
```

## Usage
First install it using your favorite plugin manager. Then, to edit a dotfile, run `chezmoi edit <dotfile>`, where `<dotfile>` is a dotfile, like `~/.bashrc`. Now, all writes being done to that file are applied(`chezmoi apply`) automatically.

## Arguments
`vim-chezmoi` has two options. You will very likely not need it.


* `g:chezmoi_executable` the binary for chezmoi, a string. Default is `"chezmoi"`
* `g:chezmoi_debug_mode` a debug mode for the plugin. Default value is off.
