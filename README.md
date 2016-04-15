# repel.nvim

All your favourite REPLs inside NeoVim.

| Command | Description |
| --------|------------- |
| `ReplOpen` | Opens a new or existing REPL. The chosen REPL is based on the current directory and filetype |
| `ReplDo [command]` | Sends the given command to the REPL for evaluation. Shows the REPL if it was hidden |
| `[range]ReplSend` | Sends teh given lines (visual selection) to the REPL for evaluation. Shows the REPL if it was hidden |
| `ReplHide` | Hides the REPL |
| `ReplShow` | Unhides the REPL |

## Supported REPLs

At the moment repel supports:

- haskell (ghci)
- ruby (irb)
- rails (bundle exec rails console)
- elixir (iex OR iex -S mix)
- python (python)
