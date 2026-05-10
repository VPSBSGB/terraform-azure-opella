# Terraform Azure Infrastructure

## About This Project

This project is created using Terraform to deploy Azure infrastructure.

I created separate folders for dev and prod environments.

In this project I used:
- Resource Group
- Virtual Network (VNET)
- Subnets
- Network Security Group (NSG)
- Public IP
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

I created reusable VNET module inside:

```text
modules/vnet
```

This module can be reused for other environments also.

---

## Environments

I created:
- dev environment
- prod environment

Both environments use different:
- names
- IP ranges
- tags

---

## Terraform Commands

Login to Azure:

```bash
az login
```

Initialize Terraform:

```bash
terraform init
```

Validate Terraform:

```bash
terraform validate
```

Terraform Plan:

```bash
terraform plan
```

Terraform Apply:

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

Pipeline file:

```text
.github/workflows/terraform.yml
```

---

## Good Practices Used

- reusable Terraform code
- separate environments
- tags
- clean folder structure
- NSG for basic security

---

## Terraform Plan Output

Terraform plan output is added in:

```text
plan.txt
```

---

## Note

While creating Azure VM, Azure Free Tier had VM size availability issues in some regions.

Other infrastructure resources were created successfully.
