#!/bin/bash
# sops -e -i terraform_backend/terraform.tfvars
cd $(git rev-parse --show-toplevel)

files=(terraform_backend/terraform.*)
for file in ${files[@]}; do
    sops -d -i $file
done

tofu ${@}

for file in ${files[@]}; do
    sops -e -i $file
done