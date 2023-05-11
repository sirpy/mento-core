#!/bin/bash
##############################################################################
# Show the storage layout of a contract.
# Usage: yarn storage:show <contract-name> <version>
# Example: yarn storage:show StableToken
##############################################################################

CONTRACT=$1
VERSION=${2:-"0.5"}

case $VERSION in 
  0.5)
    PROFILE="v05"
    ;;
  0.8)
    PROFILE="v08"
    ;;
  *)
    echo "Invalid version: $VERSION"
    exit 1
    ;;
esac

env FOUNDRY_PROFILE=$PROFILE forge inspect $CONTRACT storage-layout \
  | jq ".storage | map(\"\(.slot):\(.offset):\(.label):\(.type)\") | .[]" -r \
  | column -s: -t
