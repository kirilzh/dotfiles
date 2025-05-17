gcloud() {
  docker run --rm -it \
    -v "$HOME/.config/gcloud":/root/.config/gcloud \
    -v "$PWD":/workspace \
    -w /workspace \
    google/cloud-sdk:latest \
    gcloud "$@"
}
