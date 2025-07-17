# Azure OIDC Setup for GitHub Actions

This guide walks through setting up OpenID Connect (OIDC) authentication between GitHub Actions and Azure for secure, secret-free deployments.

## Prerequisites

- Azure CLI installed and authenticated (`az login`)
- GitHub repository created
- Admin access to both Azure subscription and GitHub repository

## Step 1: Get Your Azure Information

```bash
# Get your subscription ID
az account show --query id --output tsv

# Get your tenant ID
az account show --query tenantId --output tsv
```

Save these values - you'll need them later.

## Step 2: Create App Registration

```bash
# Create the app registration
az ad app create --display-name "github-actions-hello-world"
```

Save the `appId` from the output - this is your `AZURE_CLIENT_ID`.

## Step 3: Create Service Principal

```bash
# Create service principal (replace {app-id} with appId from step 2)
az ad sp create --id {app-id}
```

## Step 4: Assign Azure Permissions

```bash
# Assign Contributor role to the service principal
az role assignment create \
  --assignee {app-id} \
  --role Contributor \
  --scope /subscriptions/{subscription-id}
```

Replace `{subscription-id}` with your subscription ID from Step 1.

## Step 5: Create Federated Credential Configuration

Create a file called `federated-credential.json`:

```json
{
  "name": "github-actions-federated-credential",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:{github-username}/{repository-name}:ref:refs/heads/main",
  "description": "GitHub Actions federated credential",
  "audiences": [
    "api://AzureADTokenExchange"
  ]
}
```

Replace `{github-username}` and `{repository-name}` with your actual GitHub username and repository name.

## Step 6: Create Federated Credential

```bash
# Create the federated credential
az ad app federated-credential create \
  --id {app-id} \
  --parameters federated-credential.json
```

## Step 7: Add GitHub Repository Secrets

In your GitHub repository, go to Settings → Secrets and variables → Actions, and add these secrets:

- `AZURE_CLIENT_ID`: The `appId` from Step 2
- `AZURE_TENANT_ID`: The tenant ID from Step 1  
- `AZURE_SUBSCRIPTION_ID`: The subscription ID from Step 1

## Step 8: Test Authentication

Add this to your GitHub Actions workflow to test:

```yaml
- name: Azure Login
  uses: azure/login@v1
  with:
    client-id: ${{ secrets.AZURE_CLIENT_ID }}
    tenant-id: ${{ secrets.AZURE_TENANT_ID }}
    subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

- name: Test Azure CLI
  run: az account show
```

## Troubleshooting

- Ensure the `subject` in federated-credential.json matches your repo and branch exactly
- Verify all three secrets are added to GitHub with correct names
- Check that the service principal has Contributor role on the subscription
- For pull requests, you may need additional federated credentials with `pull_request` subject

## Security Benefits

- No long-lived secrets stored in GitHub
- Tokens are short-lived (1 hour)
- Clear audit trail of authentication requests
- Reduced attack surface compared to service principal secrets