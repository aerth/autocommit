# autocommit

### installation

Copy the files from [./config/](./config/) directory to ~/.config/git/

Edit env with your ollama enviromental variables
example. (is sourced by the main autocommit command)

Need prompt file: `cp -n config/autocommit.prompt.md ~/.config/git/`

Edit the prompt file how you want. YMMV.

Edit `~/.config/git/autocommit.env` with your ollama host details.

OLLAMA_HOST may be any OpenAI-compatible host. Script adds /v1/chat/completions path.

```bash
# ~/.config/git/autocommit.env
OLLAMA_MODEL=gemma4:12b
OLLAMA_THINK=false
OLLAMA_HOST=http://127.0.0.1:11434
# optional
LLM_API_KEY=xx
```

Need environment: OLLAMA_MODEL OLLAMA_HOST OLLAMA_THINK

## usage

- To add+commit a file or path (single arg):
  - `autocommit -y ./foo/`
- To commit multiple files:
  - `git add ./foo ./bar` to stage,
  - then `autocommit -y` to commit staged.
- To commit everything in one go,
  - `autocommit -y .`

Try `acloop 15 1 10`, so commits are being created while you code. (*checking every 15 seconds, and waiting 10 seconds before acting, with 1 cooldown*)

With desktop notifications, you might hide the terminal that runs `acloop`,
and return if there is a popup.

When a new file is added to the repository, acloop warns and does not create a commit.

### In scripts

The `generate_commit` function does not actually create a commit, only the message:


bash  -c 'source scripts/autocommit && make_diff . | generate_commit | jq -rc .message.content'

```bash
source scripts/autocommit
diff /dev/null scripts/ac | generate_commit | jq -r .message.content
```

Outputs the following commit message:

```
scripts/ac: add autocommit script

Create a new bash script to handle automatic commits in chunks.
The script identifies changed files in the work tree or staged area
and executes an 'autocommit' command on each unique directory
containing changes.

It supports various flags including:
- -v: verbose mode
- -q: quiet mode
- -y or -f: force commit

The script uses 'gum' for logging and styling to provide a better
user experience during the commit process.
```
