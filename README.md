# vim-chezmoi
vim-chezmoi is a plugin for vim to apply the dotfile you are editing to [chezmoi](https://github.com/twpayne/chezmoi), on `:w`.

It does not currently work with opening the source files directly(i.e `vim ~/.local/share/dotfile`), only `chezmoi edit dotfile`.

# Install with vim-plug

```vimscript
" .~/.vimrc
Plug 'Lilja/vim-chezmoi'
```

and then
```vimscript
" .~/.vimrc
let g:chezmoi = "enabled"
```

## Arguments
`vim-chezmoi` has two options. You will very likely not need it.


* `g:chezmoi_executable` the binary for chezmoi, a string. Default is `"chezmoi"`
* `g:chezmoi_debug_mode` a debug mode for the plugin. Default value is off.
