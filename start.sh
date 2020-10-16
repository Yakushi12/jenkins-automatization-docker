#!/usr/bin/env bash

# if [ -z "${1}" ]; then
#   echo "Please, specify path to directory as 1st argument."
#   exit 5
# fi

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

SECONDS=0

workdir=$(pwd)
key_path=$(cd ../jenkins-automatization-docker-files && echo `pwd`)
bucket_name="tf-backup"
commit_id=$(echo $(git log --pretty="%h" -1))

# Provide path to directory where stores all credential files.
# sed -i '' "s#^key_path.*#key_path : \"${key_path}\"#" ${workdir}/Ansible/group_vars/All.yml
# sed -i '' "s#credentials.*#credentials = \"${key_path}/account.json\"#" /Users/dzakharchenko/WhoAmI/Study/GIT/Repos/jenkins-automatization-docker/Terraform/CI/versions.tf
# sed -i '' "s#credentials.*#credentials = \"${key_path}/account.json\"#" /Users/dzakharchenko/WhoAmI/Study/GIT/Repos/jenkins-automatization-docker/Terraform/GitHub/versions.tf

# Creating bucket for terraform state files.
# gsutil mb -p gd-gcp-internship-kha-koh -c STANDARD -l US gs://${bucket_name}
# Creating Service Accoint Key for managing GCP.
# gcloud iam service-accounts keys create "${key_path}/account.json" --iam-account 442661604643-compute@developer.gserviceaccount.com

# Creating VM's images.
# cd ${workdir}/Ansible
# packer build -var "path=${key_path}/vault_password" -var "acc_key=${key_path}/account.json" -var "commit_id=${commit_id}" jenkins_image.json
# packer build -var "path=${key_path}/vault_password" -var "acc_key=${key_path}/account.json" -var "commit_id=${commit_id}" nexus_image.json

# Set up CI infrastructure.
cd ${workdir}/Terraform/CI
# terraform init
# terraform plan -var "credentials_file=${key_path}/account.json"
# terraform apply -var "credentials_file=${key_path}/account.json" -auto-approve
jenkins_ip=$(terraform output -json jenkins_ip | jq --raw-output "")
nexus_ip=$(terraform output -json nexus_ip | jq --raw-output "")

# If necessary you can uncomment below comands for writting IP's to the Ansible global var file.
#sed -i '' "s/nexus_url.*/nexus_url     : ${nexus_ip}/" ${workdir}/Ansible/group_vars/All.yml
#sed -i '' "s/jenkins_url.*/jenkins_url   : ${jenkins_ip}/" ${workdir}/Ansible/group_vars/All.yml

# Configure CI VM's.
cd ${workdir}/Ansible/
# ansible-playbook playbooks/nexus_playbook.yml --vault-password-file="${key_path}/vault_password" --tags="nexus-configure" --extra-vars "nexus_url=${nexus_ip}"
ansible-playbook playbooks/jenkins_playbook.yml --vault-password-file="${key_path}/vault_password" --tags="jenkins-configure" --extra-vars "jenkins_url=${jenkins_ip}"

# Create GitHub webhook.
cd ${workdir}/Terraform/GitHub
terraform init
terraform plan -var "jenkins_ip=${jenkins_ip}" -var "token=${key_path}/token"
terraform apply -var "jenkins_ip=${jenkins_ip}" -var "token=${key_path}/token" -auto-approve

duration=${SECONDS}
echo "Script execution time: $((${duration} / 60)):$((${duration} % 60))"
