#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

workdir=$(pwd)
key_path=$(cd ../jenkins-automatization-docker-files && echo `pwd`)

# Delete environments created by Terraform
cd $workdir/Terraform/GitHub
terraform destroy -auto-approve -var "token=${key_path}/token"
cd $workdir/Terraform/Dev
terraform init
terraform destroy -auto-approve
cd $workdir/Terraform/CI
terraform destroy -auto-approve -var "credentials_file=${key_path}/account.json"

# Delete images created during infrastructure work.
gcloud compute images list --filter="family=petclinic" --format="value(name)" | xargs gcloud compute images delete
# Delete disks created by packer.
gcloud compute disks list --filter="packer" --format="value(name)" | xargs gcloud compute disks delete
