#!/usr/bin/env bash

workdir=$(pwd)

# Delete environments created by Terraform
cd $workdir/Terraform/GitHub
terraform destroy -auto-approve
cd $workdir/Terraform/Dev
terraform init
terraform destroy -auto-approve
cd $workdir/Terraform/CI
terraform destroy -auto-approve

# Delete images created during infrastructure work.
gcloud compute images list --filter="family=petclinic" --format="value(name)" | xargs gcloud compute images delete
# Delete disks created by packer.
gcloud compute disks list --filter="packer" --format="value(name)" | xargs gcloud compute disks delete
