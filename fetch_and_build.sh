#!/bin/bash

DOCKER_NAME="$1"
SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
LAST_COMMIT_FILE="./last_commit.txt"

pushd "$SCRIPT_DIR"
OLD_COMMIT=$(cat "$LAST_COMMIT_FILE")
git pull
NEW_COMMIT=$(git rev-parse HEAD)

if [ "$OLD_COMMIT" != "$NEW_COMMIT" ]; then
    echo "Changes detected! Pulling and running script..."
    bun run prod
    docker restart "$DOCKER_NAME"
    git rev-parse HEAD > "$LAST_COMMIT_FILE"
else
    echo "No changes."
fi

popd
