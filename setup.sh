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

printf "All the necessary tools are installed.\n\n"

mkdir -p chain-end
cd chain-end
forge init . --no-commit
cd ../front-end
pnpm install

printf "\npnpm start to start the react server.\nRun the helper functions from the 'front-end' directory.\nFor a list of the helper functions, check out the GitHub repository.\n\n"

