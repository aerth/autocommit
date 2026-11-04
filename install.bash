#!/bin/bash
bin_dir=~/bin
mkdir -p ~/.config/git
cp -nv ./config/* ~/.config/git/
mkdir -p "$bin_dir"/
cp -nvi scripts/* "$bin_dir"/
