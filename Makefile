SHELL := /bin/bash

# TERRAFORM_BACKEND_IAM_USER := $(shell ./scripts/decrypt_and_run.sh 'cd terraform_backend && tofu output -raw iam_user_name')
TERRAFORM_BACKEND_IAM_ACCESS_ID := $(shell ./scripts/decrypt_and_run.sh 'cat terraform_backend/terraform.tfstate | jq -r .outputs.iam_access_key_id.value')
# TERRAFORM_BACKEND_IAM_ACCESS_KEY := $(shell ./scripts/decrypt_and_run.sh 'cd terraform_backend && tofu output -raw iam_access_key')
TERRAFORM_BACKEND_IAM_SECRET_KEY := $(shell ./scripts/decrypt_and_run.sh 'cat terraform_backend/terraform.tfstate | jq -r .outputs.iam_access_key_secret.value')

## Terraform backend
_tofu_backend:
	./scripts/decrypt_and_run.sh 'cd terraform_backend && tofu $(COMMAND)'

tofu_backend_init:
	$(MAKE) _tofu_backend COMMAND=init

tofu_backend_plan:
	$(MAKE) _tofu_backend COMMAND=plan

tofu_backend_apply:
	$(MAKE) _tofu_backend COMMAND=apply

tofu_backend_apply_auto:
	$(MAKE) _tofu_backend COMMAND="apply -auto-approve"

## Terraform app
_tofu_app:
	@ export AWS_ACCESS_KEY_ID=$(TERRAFORM_BACKEND_IAM_ACCESS_ID) && \
		export AWS_SECRET_ACCESS_KEY=$(TERRAFORM_BACKEND_IAM_SECRET_KEY) && \
		./scripts/decrypt_and_run.sh 'tofu $(COMMAND)'

tofu_app_init:
	$(MAKE) _tofu_app COMMAND=init

tofu_app_plan:
	$(MAKE) _tofu_app COMMAND=plan

tofu_app_apply:
	$(MAKE) _tofu_app COMMAND=apply

tofu_app_apply_auto:
	$(MAKE) _tofu_app COMMAND="apply -auto-approve"