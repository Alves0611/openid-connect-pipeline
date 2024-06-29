# Terraform Deployment Pipeline

This repository contains a pipeline configuration for deploying infrastructure using Terraform on GitHub Actions.

## Pipeline Structure

The pipeline is configured to run on the following events:
- Push to the `main` branch
- Manually via `workflow_dispatch`

## Jobs

### Terraform Deploy

This job deploys the infrastructure defined with Terraform. It includes the following steps:

1. **Checkout**: Checks out the repository code.
2. **Configure AWS Credentials**: Configures AWS credentials using secrets stored in GitHub.
3. **Setup Terraform**: Sets up the Terraform version to be used.
4. **Terraform Init**: Initializes Terraform.
5. **Terraform Validate**: Validates the Terraform configuration.
6. **Terraform Format**: Checks the format of the Terraform configuration.
7. **Terraform Plan**: Generates the Terraform execution plan.
8. **Terraform Apply**: Applies the Terraform execution plan, only for pushes to the `main` branch.
9. **Cleanup**: Removes the execution plan file (`tfplan`).

## GitHub Actions Configuration

```yaml
on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  terraform-deploy:
    name: "Terraform Deploy"
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Configure aws credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: Setup terraform
        uses: hashicorp/setup-terraform@v3
        with:
          terraform_version: 1.8.4

      - name: Terraform Init
        run: terraform init

      - name: Terraform Validate
        run: terraform validate

      - name: Terraform Format
        run: terraform fmt -check

      - name: Terraform Plan
        run: terraform plan -out=tfplan

      - name: Terraform Apply
        if: github.ref == 'refs/heads/main' && github.event_name == 'push'
        run: terraform apply -auto-approve tfplan

      - name: Cleanup
        run: rm -f tfplan
        if: always()
```
## Variables and Secrets
To ensure the pipeline works correctly, make sure to configure the following secrets in GitHub:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

## Prerequisites
Terraform >= 1.8.4
AWS account configured with the necessary permissions to deploy the infrastructure

## Running the Pipeline
To run the pipeline, simply push to the main branch or manually trigger it via GitHub Actions.