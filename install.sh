#!/bin/bash
# Intended to run on x64 Ubuntu 18.04

# Install terraform
curl https://releases.hashicorp.com/terraform/0.12.12/terraform_0.12.12_linux_amd64.zip > /tmp/terraform.zip
unzip /tmp/terraform.zip
sudo mv -f terraform /usr/bin/terraform
