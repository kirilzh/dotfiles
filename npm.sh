alias npm='docker run \
  --rm \
  --user 1000 \
  --volume ~/.npm:/home/node/.npm \
  --volume ~/.npm-global:/home/node/.npm-global \
  --volume "$PWD":/app \
  --env NPM_CONFIG_PREFIX=/home/node/.npm-global \
  --workdir /app \
  node \
  npm'

