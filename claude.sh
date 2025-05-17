# Put this in your ~/.zshrc file

claude() {
  if [ "$1" = "update" ]; then
    docker run --rm -it \
      -u 1000 \
      -e NPM_CONFIG_PREFIX=/home/node/.npm-global \
      -v ~/.npm-global:/home/node/.npm-global \
      node \
      npm install -g @anthropic-ai/claude-code
  else
    # Ensure config file and directory exist
    [ -f "$HOME/.claude.json" ] || touch "$HOME/.claude.json"
    [ -d "$HOME/.claude" ] || mkdir -p "$HOME/.claude"

    # Run the claude tool
    docker run --rm -it \
      -u 1000 \
      -e NPM_CONFIG_PREFIX=/home/node/.npm-global \
      -v ~/.npm-global:/home/node/.npm-global \
      -v "$PWD":"$PWD" \
      -v "$HOME/.claude.json":/home/node/.claude.json \
      -v "$HOME/.claude":/home/node/.claude \
      -w "$PWD" \
      node \
      node /home/node/.npm-global/lib/node_modules/@anthropic-ai/claude-code/cli.js "$@"
  fi
}
