#!/usr/bin/env bash

echo "#####################"
echo "# DEBUG OUTPUT START"
echo "#####################"
echo ""
echo "Print all current environment variables:"
echo ""

env

echo ""
echo "---"
echo ""

CURRENT_USER="$(whoami)"
echo "Current user: ${CURRENT_USER}"

echo ""
echo "###################"
echo "# DEBUG OUTPUT END"
echo "###################"
echo -e "\n\n"
