#!/usr/bin/env bash

cd ./jenkins-automatization-docker/Terraform/CI

key_path="$HOME/.ssh"
bucket_name="tf-backup"
commit_id=$(echo $(git log --pretty="%h" -1))
jenkins_ip=$(terraform output -json instances_ip | jq ".[0]")
nexus_ip=$(terraform output -json instances_ip | jq ".[1]")

gsutil mb -p gd-gcp-internship-kha-koh -c STANDARD -l US gs://$bucket_name
gcloud iam service-accounts keys create ${key_path}/account.json --iam-account 442661604643-compute@developer.gserviceaccount.com

packer build -var 'path=/Users/dzakharchenko/vpass' -var 'commit_id=$commit_id' ../../Ansible/jenkins_image.json
packer build -var 'path=/Users/dzakharchenko/vpass' -var 'commit_id=$commit_id' ../../Ansible/nexus_image.json

cd ./Terraform/CI
terraform apply -auto-approve
sed -i '' "s/nexus_url.*/nexus_url                     : $nexus_ip/" /Users/dzakharchenko/WhoAmI/Study/GIT/Repos/jenkins-automatization-docker/group_vars/All.yml
sed -i '' "s/jenkins_url.*/jenkins_url                   : $jenkins_ip/" /Users/dzakharchenko/WhoAmI/Study/GIT/Repos/jenkins-automatization-docker/group_vars/All.yml
cd ../../Ansible/
# cd /Users/dzakharchenko/WhoAmI/Study/GIT/Repos/jenkins-automatization-docker
ansible-playbook playbooks/nexus_playbook.yml   --vault-password-file="/Users/dzakharchenko/vpass" --tags="nexus-configure" --extra-vars '{"nexus_url":"${nexus_ip}"}'
ansible-playbook playbooks/jenkins_playbook.yml --vault-password-file="/Users/dzakharchenko/vpass" --tags="jenkins-configure" --extra-vars '{"jenkins_url":"${jenkins_ip}"}'

ansible-playbook playbooks/jenkins_playbook.yml --vault-password-file="/Users/dzakharchenko/vpass" --tags="jenkins-configure" --extra-vars "{\"jenkins_url\":\"${jenkins_ip}\"}"
