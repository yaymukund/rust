#!/bin/bash
# Ensure commits in beta are on master.
set -euo pipefail
IFS=$'\n\t'

source "$(cd "$(dirname "$0")" && pwd)/../shared.sh"

cherry_file="$(dirname "$0")/cherries/beta-master"
git cherry master | sort > $cherry_file

if ! git diff --quiet $cherry_file; then
  echo "Found commits that are not in master."
  git diff $cherry_file
  exit 1
fi
