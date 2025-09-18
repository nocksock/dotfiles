# POON

A quick-access buffer to quickly jump between important files and run scripts.

## What it's like

### Navigating

- `<c-p>`: open poon
- jump to the file path
- `<cr>`

### Managing your poons

It's a normal, editable buffer. Just in a floating window.

- `<c-p>`: open poon
- jump to the file path you want to delete
- `<dd>`

### Running commands

Lines that start with `:` are 

## How poons are stored

In a `.poon` file that can be in the current working directory or any of its parents.

## What's different from Harpoon?

Inspired by Primeagen's Harpoon, but I only ever used that little buffer window.
So I wrote a small plugin with just *that* subset and optimised for that.
For example it looks for `.poon` files in the current or in a parent folder. 
So it works with `:cd some/subfolder`
