#!/bin/bash

current_dir=$(realpath "$(dirname "$0")" )
docker build -t docker-sj2 "$current_dir"