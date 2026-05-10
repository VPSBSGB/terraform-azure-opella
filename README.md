# Terraform Azure Infrastructure - Opella Challenge

## Project Overview

This project is created using Terraform to deploy Azure infrastructure.

I used reusable Terraform code and separated the environments into dev and prod folders.

The project includes:

- Resource Group
- Virtual Network (VNET)
- Subnets
- Network Security Group (NSG)
- Public IP
- Network Interface
- Storage Account
- Blob Container

---

## Folder Structure

```text
terraform-azure-opella/

├── environments/
│   ├── dev/
│   └── prod/
│
├── modules/
│   └── vnet/
│
├── .github/workflows/
│   └── terraform.yml
│
└── README.md
```

---

## Reusable Module

I created a reusable VNET module inside:

```text
modules/vnet
```

This module can be reused for different environments and regions.

The module supports:
- VNET creation
- subnet creation
- tags
- outputs

---

## Environments

I created two environments:

- dev
- prod

Both environments use different:
- names
- address spaces
- tags

This makes the setup easier to scale in future.

---

## Terraform Commands

### Login to Azure

```bash
az login
```

### Initialize Terraform

```bash
terraform init
```

### Validate

```bash
terraform validate
```

### Plan

```bash
terraform plan
```

### Apply

```bash
terraform apply
```

---

## GitHub Actions

I added GitHub Actions pipeline for:

- terraform init
- terraform fmt
- terraform validate
- terraform plan

Pipeline file location:

```text
.github/workflows/terraform.yml
```

---

## Security and Best Practices

I used:
- reusable Terraform code
- tags
- separate environments
- NSG for basic security
- clean folder structure

Future improvements:
- remote backend
- tfsec
- tflint
- Key Vault

---

## Terraform Plan Output

Terraform plan output is added in:

```text
plan.txt
```

---

## Azure Free Tier Issue

While creating the virtual machine, Azure Free Tier had VM size availability issues in multiple regions.

Other infrastructure resources were deployed successfully.
