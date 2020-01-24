# Template for a VPS with Ubuntu 18.04 on Hetzner.com via terraform

## Requirements

Disclaimer: I have only tested this on an Ubuntu laptop, some commands may not
work as described. Furthermore I can not guarantee for security nor stability.

- Get your **hcloud_token**
    - Have an account at [Hetzner.com](hetzner.com)
    - Create a new project
    - In the project screen go to the sidebar -> Access -> API Tokens
    - Generate a new API token and save it for later
- Install terraform
    - e.g. by running **install.sh**
- Generate an ssh key (with a strong passphrase!)
    - ```sh
      ssh-keygen
      ```

## Change the values in `terraform.tfvars`:

```
username = "your_username"
sshkey_location = "/path/to/key.pub"
```

## Create a `secrets.tfvars` file

Create a file called **secrets.tfvars** and fill it with your token:

```
hcloud_token = "-----------------YOUR-TOKEN-OF-THIS-LENGTH-HERE-----------------"
```

This file is kept in the `.gitignore` file in order to avoid leaking.

## Run terraform

```bash
terraform init
terraform apply -var-file=secrets.tfvars
```

The creation might be quick, but keep in mind that everything in `cloud-init.yaml`
takes time to apply (ssh restart, package upgrades, ..).
