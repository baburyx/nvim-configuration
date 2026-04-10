# Neovim Cheatsheet

## Splits (side-by-side editing like Kiro)

| Command         | Action                        |
| --------------- | ----------------------------- |
| `:vs file.py`   | Vertical split (side by side) |
| `:sp file.py`   | Horizontal split (top/bottom) |
| `<C-h/j/k/l>`   | Move focus between splits     |
| `<C-S-h/j/k/l>` | Move the split window itself  |
| `:q`            | Close current split           |
| `<C-w>=`        | Make all splits equal size    |
| `<C-w>>`        | Increase width                |
| `<C-w><`        | Decrease width                |

## File Navigation

| Key                | Action                          |
| ------------------ | ------------------------------- |
| `<leader>sf`       | Find files (Cmd+P equivalent)   |
| `<leader>sg`       | Grep across files (Cmd+Shift+F) |
| `<leader><leader>` | Switch between open buffers     |
| `<leader>s.`       | Recent files                    |
| `<leader>sf`       | Search files in cwd             |
| `<leader>sn`       | Search Neovim config files      |
| `<leader>/`        | Fuzzy search in current buffer  |

## Bufferline (Tabs)

| Key          | Action            |
| ------------ | ----------------- |
| `<leader>bn` | Next tab          |
| `<leader>bp` | Previous tab      |
| `<leader>bd` | Close current tab |

## Neo-tree (File Explorer)

| Key       | Action                              |
| --------- | ----------------------------------- |
| `\`       | Toggle neo-tree                     |
| `a`       | Create file (add `/` for directory) |
| `d`       | Delete                              |
| `r`       | Rename                              |
| `y`       | Copy to clipboard                   |
| `x`       | Cut (for move)                      |
| `p`       | Paste                               |
| `H`       | Toggle hidden files                 |
| `?`       | Show all neo-tree keybindings       |
| `<space>` | Toggle expand/collapse              |
| `<cr>`    | Open file                           |
| `s`       | Open in vertical split              |

## Flash (Jump Navigation)

| Key | Action                                |
| --- | ------------------------------------- |
| `s` | Flash jump — type chars, pick label   |
| `S` | Flash treesitter — select code blocks |

## Harpoon (Bookmarked Files)

| Key         | Action                   |
| ----------- | ------------------------ |
| `<leader>a` | Add current file         |
| `<leader>e` | Open harpoon menu        |
| `<leader>1` | Jump to harpooned file 1 |
| `<leader>2` | Jump to harpooned file 2 |
| `<leader>3` | Jump to harpooned file 3 |
| `<leader>4` | Jump to harpooned file 4 |

## Undotree

| Key         | Action          |
| ----------- | --------------- |
| `<leader>u` | Toggle undotree |

## LSP (Code Intelligence)

| Key   | Action                 |
| ----- | ---------------------- |
| `grd` | Go to definition       |
| `grr` | Go to references       |
| `gri` | Go to implementation   |
| `grt` | Go to type definition  |
| `grn` | Rename symbol          |
| `gra` | Code action (quickfix) |
| `gO`  | Document symbols       |
| `gW`  | Workspace symbols      |
| `K`   | Hover documentation    |

## Git (Gitsigns)

| Key          | Action              |
| ------------ | ------------------- |
| `]c`         | Next git change     |
| `[c`         | Previous git change |
| `<leader>hs` | Stage hunk          |
| `<leader>hr` | Reset hunk          |
| `<leader>hS` | Stage entire buffer |
| `<leader>hR` | Reset entire buffer |
| `<leader>hp` | Preview hunk        |
| `<leader>hb` | Blame line          |
| `<leader>hd` | Diff against index  |
| `<leader>tb` | Toggle inline blame |

## Editing Essentials

| Key          | Action                       |
| ------------ | ---------------------------- |
| `<leader>f`  | Format buffer                |
| `<leader>q`  | Open diagnostics quickfix    |
| `<leader>th` | Toggle inlay hints           |
| `<Esc>`      | Clear search highlights      |
| `sa`         | Surround add (mini.surround) |
| `sd`         | Surround delete              |
| `sr`         | Surround replace             |

## Terminal

| Command          | Action                       |
| ---------------- | ---------------------------- |
| `:term`          | Open terminal in buffer      |
| `:sp \| term`    | Terminal in horizontal split |
| `:vs \| term`    | Terminal in vertical split   |
| `<Esc><Esc>`     | Exit terminal mode           |
| `i` or `a`       | Enter terminal mode          |
| `exit` or `:bd!` | Close terminal               |

## General

| Key          | Action                   |
| ------------ | ------------------------ |
| `<leader>sh` | Search help              |
| `<leader>sk` | Search keymaps           |
| `<leader>sd` | Search diagnostics       |
| `<leader>sr` | Resume last search       |
| `:Lazy`      | Plugin manager           |
| `:Mason`     | LSP/tool installer       |
| `:LspInfo`   | Check active LSP servers |
| `?`          | Help in any plugin panel |

---

# Practice Exercises

Work through these in order. Each one builds on the previous.

## Exercise 1: Basic Movement & Editing

Open this cheatsheet in Neovim and try:

1. Move to the word "Neovim" using `s` + type `Ne` + pick the label
2. Go to the top of the file with `gg`, bottom with `G`
3. Jump to line 50 with `50G`
4. Move by words: `w` (forward), `b` (back), `e` (end of word)
5. Delete a word: `dw`. Delete a line: `dd`. Undo: `u`. Redo: `<C-r>`
6. Copy a line: `yy`. Paste below: `p`. Paste above: `P`
7. Change a word: `cw` (deletes word and puts you in insert mode)
8. Select a paragraph: `vip`. Delete it: `d`. Undo: `u`

## Exercise 2: Surround (mini.surround)

Create a file: `:e /tmp/surround_practice.py`

Type this:

```python
name = hello
message = world
html = div class=main
```

Now practice:

1. Put cursor on `hello`, type `saiw"` → surrounds word with `"` → `"hello"`
2. Put cursor on `world`, type `saiw'` → `'world'`
3. On `"hello"`, type `sr"'` → changes `"` to `'` → `'hello'`
4. On `'hello'`, type `sd'` → deletes surrounding `'` → `hello`
5. Select `div class=main` with `v`, then `sa<` → `<div class=main>`

## Exercise 3: Splits & Multiple Files

1. Open any file: `nvim ~/.config/nvim/init.lua`
2. Vertical split: `:vs ~/.config/nvim/CHEATSHEET.md`
3. You now see two files side by side
4. Move to left split: `<C-h>`, right split: `<C-l>`
5. Open a third file in horizontal split: `:sp /tmp/surround_practice.py`
6. Navigate all three with `<C-h/j/k/l>`
7. Close one split: `:q`
8. Make splits equal: `<C-w>=`
9. Close all splits except current: `<C-w>o`

## Exercise 4: File Navigation Workflow

1. Open Neovim from a project directory: `cd ~/lab && nvim`
2. `<leader>sf` → find a file by name
3. `<leader>sg` → search for text across all files
4. Open 3-4 files, then `<leader><leader>` to switch between open buffers
5. Use `<leader>bn` and `<leader>bp` to cycle tabs at the top
6. Close a tab: `<leader>bd`

## Exercise 5: Harpoon Workflow

1. Open file A, press `<leader>a` to harpoon it
2. Open file B, press `<leader>a`
3. Open file C, press `<leader>a`
4. Now: `<leader>1` → file A, `<leader>2` → file B, `<leader>3` → file C
5. `<leader>e` → open harpoon menu, delete a line to remove a bookmark
6. This is faster than telescope for files you keep going back to

## Exercise 6: LSP & Code Intelligence

Create a file: `:e /tmp/lsp_practice.py`

```python
class Calculator:
    def add(self, a: int, b: int) -> int:
        return a + b

    def subtract(self, a: int, b: int) -> int:
        return a - b

calc = Calculator()
result = calc.add(1, 2)
print(result)
```

Now try:

1. Put cursor on `add` in `calc.add(1, 2)`, press `grd` → jumps to definition
2. Put cursor on `add` in the method definition, press `grr` → shows all references
3. Put cursor on `add`, press `grn` → rename it everywhere
4. Put cursor on `Calculator`, press `K` → hover docs
5. Press `gra` on any warning → code actions / quickfix
6. `<leader>f` → format the file with ruff

## Exercise 7: Git Workflow

1. Make changes to a tracked file
2. `]c` and `[c` → jump between changed hunks
3. `<leader>hp` → preview what changed in this hunk
4. `<leader>hs` → stage this hunk
5. `<leader>hb` → blame this line (who wrote it)
6. `<leader>hd` → diff the file against the index
7. `<leader>tb` → toggle inline blame on every line

## Exercise 8: Terminal + Run Script

1. Write a Python script: `:e /tmp/test_run.py`
2. Add: `print("it works")`
3. Save: `:w`
4. Open terminal below: `:sp | term`
5. Run it: `python3 /tmp/test_run.py`
6. `<Esc><Esc>` to exit terminal mode
7. `<C-k>` to go back to your code
8. Edit the script, `:w`, `<C-j>` to terminal, `i` to enter terminal mode
9. Up arrow + enter to re-run
10. When done: `exit` to close terminal

## Exercise 9: Flash Power Moves

Open any file with lots of code and try:

1. `s` + type 2 chars of any visible word → pick label → you're there
2. `ds` + flash to a target → deletes from cursor to that point
3. `ys` + flash to a target → yanks from cursor to that point
4. `S` → treesitter select → pick a label to select an entire code block
5. Try `S` on a Python file → select a whole function, then `d` to delete it, `u` to undo

## Exercise 10: Undotree Recovery

1. Open a file, make 5 edits, save
2. Undo 3 times (`uuu`)
3. Make 2 different edits (this creates a branch)
4. `<leader>u` → open undotree
5. Navigate the tree with `j/k`, press `<cr>` to jump to any state
6. You can recover the edits from step 1 even though you branched off
7. `<leader>u` to close

## Daily Workflow Summary

```
nvim .                          # open neovim in project root
\                               # toggle file explorer
<leader>sf                      # find and open files
<leader>a                       # harpoon files you work on
<leader>1/2/3/4                 # jump between harpooned files
:vs file.py                     # side-by-side editing
s + chars                       # flash jump anywhere
<leader>f                       # format code
:w                              # save
:sp | term                      # quick terminal
<leader>u                       # undo history if you mess up
<leader>sg                      # search across project
```
