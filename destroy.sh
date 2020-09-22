#!/usr/bin/env bash

workdir=$(pwd)
cd $workdir/Terraform/GitHub
terraform destroy -auto-approve
cd $workdir/Terraform/Dev
terraform init
terraform destroy -auto-approve
cd $workdir/Terraform/CI
terraform destroy -auto-approve
