# blackbubble

_Very simple Vim plugin for creating presentations_

---

![](screenshot.png)

`blackbubble` turns Vim into a simple presentation tool, using plain text files and ad-hoc syntax highlighting to make slides stand out.
It can also use [toilet](https://github.com/cacalabs/toilet) to create banners from text.
[goyo.vim](https://github.com/junegunn/goyo.vim) is a great plugin that will make blackbubble presentations look much better.

A presentation consists of multiple files with the `.bbb` extension.
Presentations should typically have their own dedicated directory.
Every file in the directory is a slide, and presentations can be started by opening all `.bbb` files in the directory: `vim *.bbb`.

Files will be in alphanumeric order, so it is important to name slide files accordingly.
Numbering files is a good idea (`01.bbb`, `02.bbb`, `03.bbb`...)

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
| `<Leader><Leader>`     | Start presentation on the current slide                    |
| `<Right>`              | Next slide                                                 |
| `<Left>`               | Previous slide                                             |
| `<Leader>t1`           | Create a big title from the current line (uses `toilet`)   |
| `<Leader>t2`           | Create a small title from the current line (uses `toilet`) |
| `<Leader>t3`           | Create a fancy title from the current line (uses `toilet`) |
| `<Leader>b1`           | Draw borders around the current line (uses `toilet`)       |
| `<Leader>co`           | Colorize the selection                                     |
| `<Leader>ft`           | Change the font of the selection (B/I/U)                   |
