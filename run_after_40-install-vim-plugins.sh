#!/usr/bin/env bash

echo "Installing and Updating vim plugins..."
vim -c "PlugInstall | q | q"
vim -c "PlugUpdate | q | q"
