#!/usr/bin/env bash
cd /home/hjalmar/nixos-config && git pull && sudo nixos-rebuild switch --flake .#p52s
