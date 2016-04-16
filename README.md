# repel.nvim

Interact with REPLs and the Shell more easily.

| Command | Description |
| --------|------------- |
| `Ropen {command}` | Opens a new or existing REPL. The chosen REPL is based on the current directory and filetype. If given a command, it runs it. |
| `Rdo [command]` | Sends the given command to the REPL for evaluation (without switching focus to it). Shows the REPL if it was hidden |
| `[range]Rsend` | Sends the given lines (visual selection) to the REPL for evaluation. Shows the REPL if it was hidden |
| `Rhide` | Hides the REPL |
| `Rshow` | Unhides the REPL |
| `Rclear`| Clears the REPL |
| `Rload` | Loads the current file into the REPL's context |

There is also support for the Shell:

- `Sopen {command}`
- `Sdo [command]`
- `Sclear`
- `Shide`
- `Sshow`

## Supported REPLs

At the moment repel supports:

- haskell (ghci)
- ruby (irb)
- rails (bundle exec rails console)
- elixir (iex OR iex -S mix)
