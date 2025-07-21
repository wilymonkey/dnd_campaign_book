#!/bin/bash

DOCKER_NAME="$1"
SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
pushd "$SCRIPT_DIR"
OLD_COMMIT=$(git rev-parse HEAD)
git pull
NEW_COMMIT=$(git rev-parse HEAD)

if [ "$OLD_COMMIT" != "$NEW_COMMIT" ]; then
    echo "Changes detected! Pulling and running script..."
    bun run prod
    docker restart "$DOCKER_NAME"
else
    echo "No changes."
fi

