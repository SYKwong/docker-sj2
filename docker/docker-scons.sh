#!/bin/bash

if [ "$1" == "-h" ] || [ "$1" == "-help" ]; then
    echo "Usage: ./docker-scons.sh [project_name]"
    echo "If project_name is not provided, the default project is lpc40xx_freertos."
    exit 0
fi

# Get the absolute path of the current directory
sj2_directory=$(realpath "$(dirname "$0")")/..

if [ -z "$1" ]; then
    project_name="lpc40xx_freertos"
else
    project_name=$1
    # Check if the project directory exists
    if [ ! -d "$sj2_directory/projects/$project_name" ]; then
        echo "Project $project_name does not exist."
    fi
fi

# Get the number of threads
threads=-j$(nproc --all)

# Execute the Docker run command with the absolute path, using all threads for faster compile time
docker run --rm -v "$sj2_directory:/usr/project" docker-sj2 scons $threads "--project="$project_name
