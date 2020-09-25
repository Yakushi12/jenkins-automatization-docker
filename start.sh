#!/usr/bin/env bash
SECONDS=0
set -o errexit
set -o nounset
set -o pipefail

workdir=$(pwd)
key_path="$HOME/.ssh"
bucket_name="tf-backup"
commit_id=$(echo $(git log --pretty="%h" -1))

#gsutil mb -p gd-gcp-internship-kha-koh -c STANDARD -l US gs://$bucket_name
#gcloud iam service-accounts keys create ${key_path}/account.json --iam-account 442661604643-compute@developer.gserviceaccount.com

cd $workdir/Ansible
packer build -var 'path=/Users/dzakharchenko/vpass' -var "acc_key=$HOME/.ssh/account.json" -var "commit_id=$commit_id" jenkins_image.json
packer build -var 'path=/Users/dzakharchenko/vpass' -var "acc_key=$HOME/.ssh/account.json" -var "commit_id=$commit_id" nexus_image.json

cd $workdir/Terraform/CI
terraform init
terraform apply -auto-approve
jenkins_ip=$(terraform output -json jenkins_ip | jq -r "")
nexus_ip=$(terraform output -json nexus_ip | jq -r "")
#sed -i '' "s/nexus_url.*/nexus_url     : $nexus_ip/" $workdir/Ansible/group_vars/All.yml
#sed -i '' "s/jenkins_url.*/jenkins_url   : $jenkins_ip/" $workdir/Ansible/group_vars/All.yml

until $(nc -z -G 3 $jenkins_ip 22 &> /dev/null || echo $?); do
  printf '.'
  sleep 3
done
cd $workdir/Ansible/
ansible-playbook playbooks/nexus_playbook.yml --vault-password-file="/Users/dzakharchenko/vpass" --tags="nexus-configure" --extra-vars "nexus_url=$nexus_ip"
ansible-playbook playbooks/jenkins_playbook.yml --vault-password-file="/Users/dzakharchenko/vpass" --tags="jenkins-configure" --extra-vars "jenkins_url=$jenkins_ip"

while [[ $(curl -s -w "%{http_code}" http://jenkins:pass@$jenkins_ip:8080 -o /dev/null) != "200" ]]; do
  printf '.'
  sleep 3
done
cd $workdir/Terraform/GitHub
terraform init
terraform apply -var "jenkins_ip=$jenkins_ip" -auto-approve

duration=$SECONDS
echo "Script execution time: $(($duration / 60)):$(($duration % 60))"
