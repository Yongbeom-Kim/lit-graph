#!/bin/bash
# sops -e -i terraform_backend/terraform.tfvars
cd $(git rev-parse --show-toplevel)

files=(terraform_backend/terraform.*)

cleanup() {
    cd $(git rev-parse --show-toplevel)
    for file in ${files[@]}; do
        # echo "Encrypting $file"
        sops -e -i $file
    done
}
trap cleanup INT EXIT

for file in ${files[@]}; do
    # echo "Decrypting $file"
    # Sometimes the cleanup function runs twice on some files, so decrypt x2.
    # sops can't decrypt a file that's already decrypted.
    sops -d -i $file 2>/dev/null
    sops -d -i $file 2>/dev/null
done

# echo "Running $@"

bash -c "${@}"
