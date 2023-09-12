#!/bin/bash

function doesExist() {
	if ! command -v $1 > /dev/null; then
		echo "$1 is not installed. Please install it before continueing."
		exit 1
	fi
}

doesExist curl
doesExist git
doesExist forge
doesExist cast
doesExist node
doesExist pnpm

mkdir -p chain-end
cd chain-end
forge init . --no-commit
cd ../front-end
pnpm install
