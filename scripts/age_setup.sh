#!/bin/bash
mkdir -p ${XDG_CONFIG_HOME-$HOME/.config}/sops/age
age-keygen -o ${XDG_CONFIG_HOME-$HOME/.config}/sops/age/keys.txt