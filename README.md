# BlackBubble

_Very simple Vim plugin for creating presentations_

---

![](https://raw.github.com/skurtulmus/img/main/blackbubble.png)

__BlackBubble__ turns Vim into a simple presentation tool, using plain text files and ad-hoc syntax highlighting to make slides stand out.
Highlighting selections can be made using the current word under the cursor, or using visual mode.
It can also use [toilet](https://github.com/cacalabs/toilet) to create banners/titles from text.
[goyo.vim](https://github.com/junegunn/goyo.vim) is a great plugin that will make blackbubble presentations look much better.

A presentation consists of multiple files with the `.bbb` extension.
Presentations should typically have their own dedicated directory.
Every file in the directory is a slide, and presentations can be started by opening all `.bbb` files in the directory: `vim *.bbb`.

Files will be opened in alphanumeric order, so it is important to name slide files accordingly.
Numbering files is recommended (`01.bbb`, `02.bbb`, `03.bbb`...).

Syntax rules are saved in the `bbb.vim` file in the same directory, which is then sourced every time the presentation file is opened.

### Installation

Native:

+ Clone into `~/.vim/pack/plugins/start/blackbubble`

`vim-plug`:

+ Add `Plug 'https://github.com/skurtulmus/blackbubble'` to your vimrc
+ Run `:PlugInstall`

### Dependencies

+ `toilet` (optional)

### Shortcuts

| Key Combination        | Action                                                     |
| :--------------------- | --------------------------------------:                    |
| `<Right>`              | Next slide                                                 |
| `<Left>`               | Previous slide                                             |
| `<Down>`               | First slide                                                |
| `<Up>`                 | Last slide                                                 |
| `<CTRL>` + `F`         | Use an ASCII font for the current line (titles/banners)    |
| `<CTRL>` + `C`         | Change the color of the selection                          |
| `<CTRL>` + `B`         | Change the formatting of the selection (B/I/U)             |
