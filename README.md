# Frappe Automated Release Pipeline

This repository implements a complete automated release flow for Frappe applications with CI/CD, quality checks, and automated deployments.

## 🚀 Features

- ✅ **Automated PR Checks**: Linting, testing, and SonarQube analysis
- ✅ **DevOps Gatekeeping**: CODEOWNERS ensures DevOps approval required
- ✅ **Fast Release Pipeline**: Lightweight checks + automated deployment
- ✅ **Auto Versioning**: Automatic tag creation and GitHub releases
- ✅ **Notifications**: Slack/Discord/Email webhook support
- ✅ **Branch Protection**: No direct pushes, all checks must pass

## 🎯 Workflow Strategy

This repository uses a **two-stage workflow** for optimal speed and quality:

### Stage 1: PR Checks (Development)
- **Workflow:** `pr-checks.yml`
- **Triggers:** Pull requests to `main`
- **Checks:** Full linting, tests, SonarQube
- **Purpose:** Validate code before merge

### Stage 2: Release Pipeline (Main)
- **Workflow:** `release.yml`
- **Triggers:** Push to `main` (after merge)
- **Jobs:** Lightweight syntax check → Deploy → Release
- **Purpose:** Fast deployment and automated release

**Why?** Since quality checks run in PRs, the main pipeline focuses on deployment speed. See [`.github/WORKFLOW_STRATEGY.md`](.github/WORKFLOW_STRATEGY.md) for details.

## 📋 Workflow Overview

### Step 1: Developers Work in Feature Branches

```bash
# Create feature branch from develop
git checkout develop
git pull origin develop
git checkout -b feat/invoice-update

# Make changes and push
git add .
git commit -m "feat: update invoice functionality"
git push origin feat/invoice-update
```

Then open a Pull Request to `main`.

### Step 2: GitHub Actions Run on PR

When a PR is opened to `main`, the following checks run automatically:

- ✅ **Code Checkout**: Clones the repository
- ✅ **Linting**: Runs flake8 (Python) and ESLint (JavaScript)
- ✅ **Tests**: Runs pytest and Frappe test suite
- ✅ **SonarQube Analysis**: Code quality and security scanning

**PR cannot be merged unless all checks pass.**

### Step 3: DevOps Review + Approval

The `CODEOWNERS` file ensures DevOps team must approve:

```
* @devops-team
```

GitHub branch protection rules require:
- ✅ Status checks to pass
- ✅ DevOps approval
- 🚫 No direct push allowed

### Step 4: PR Merged → Fast Release Pipeline

After PR merge to `main`, GitHub Action automatically:

1. **Lightweight Syntax Check** (catches merge issues)
2. **Deploy to Server:**
   - SSH into production/staging server
   - Navigate to bench directory
   - Pull latest app changes
   - Run `bench update --pull --build`
   - Run `bench migrate`
   - Run `bench restart`
3. **Create Release:**
   - Auto-bump version (minor)
   - Create Git tag
   - Create GitHub Release with notes

**No manual steps required!** ⚡ Fast pipeline (no duplicate checks)

### Step 5: Deployment Logs + Notifications

GitHub Action shows:
- SSH connection status
- App pull status
- Migration status
- Bench restart status

Optional notifications sent to:
- Slack (via webhook)
- Discord (via webhook)
- Email (via webhook)

### Step 6: DevOps Dashboard

Monitor in GitHub Projects or custom dashboard:
- ⏳ Open PRs awaiting review
- ✅ Passed vs failed pipelines
- 🚀 Latest deployments
- 📊 SonarQube quality metrics
- 🧾 Audit trail of approvals

## 🛠️ Setup Instructions

### 1. Configure GitHub Secrets

Run the setup script to see required secrets:

```bash
bash scripts/setup-secrets.sh
```

Or manually add these secrets in **Settings → Secrets and variables → Actions**:

| Secret | Description | Required |
|--------|-------------|----------|
| `SSH_PRIVATE_KEY` | Private SSH key for server access | ✅ Yes |
| `SSH_USER` | SSH username (e.g., `frappe`, `ubuntu`) | ✅ Yes |
| `SERVER_HOST` | Server hostname or IP | ✅ Yes |
| `BENCH_DIRECTORY` | Path to bench directory on server | ✅ Yes |
| `SONAR_TOKEN` | SonarQube authentication token | ❌ Optional |
| `SONAR_HOST_URL` | SonarQube server URL | ❌ Optional |
| `SLACK_WEBHOOK_URL` | Slack webhook for notifications | ❌ Optional |
| `DISCORD_WEBHOOK_URL` | Discord webhook for notifications | ❌ Optional |

### 2. Generate SSH Key for GitHub Actions

```bash
# Generate SSH key pair
ssh-keygen -t ed25519 -C "github-actions" -f github-actions-key

# Add public key to server
ssh-copy-id -i github-actions-key.pub user@your-server.com

# Add private key to GitHub Secrets as SSH_PRIVATE_KEY
cat github-actions-key
```

### 3. Configure Branch Protection

Follow the instructions in [`.github/BRANCH_PROTECTION.md`](.github/BRANCH_PROTECTION.md) to set up branch protection rules in GitHub.

Key settings:
- ✅ Require pull request before merging
- ✅ Require DevOps approval (via CODEOWNERS)
- ✅ Require status checks to pass
- ✅ No direct pushes allowed

### 4. Set Up CODEOWNERS

The `CODEOWNERS` file is already configured. Make sure the `@devops-team` team exists in your GitHub organization, or update it to match your team name.

### 5. Configure SonarQube (Optional)

1. Create a project in SonarQube/SonarCloud
2. Generate an authentication token
3. Add `SONAR_TOKEN` and `SONAR_HOST_URL` to GitHub Secrets

### 6. Set Up Notifications (Optional)

#### Slack
1. Go to https://api.slack.com/messaging/webhooks
2. Create a webhook URL
3. Add to GitHub Secrets as `SLACK_WEBHOOK_URL`

#### Discord
1. Go to Server Settings → Integrations → Webhooks
2. Create a webhook URL
3. Add to GitHub Secrets as `DISCORD_WEBHOOK_URL`

## 📁 Project Structure

```
.
├── .github/
│   ├── workflows/
│   │   ├── pr-checks.yml      # PR validation workflow
│   │   └── deploy.yml         # Deployment workflow
│   └── BRANCH_PROTECTION.md   # Branch protection guide
├── scripts/
│   ├── deploy.sh              # Deployment script
│   └── setup-secrets.sh       # Secrets setup guide
├── CODEOWNERS                 # DevOps approval requirement
└── README.md                  # This file
```

## 🔍 Workflow Files

### PR Checks Workflow (`.github/workflows/pr-checks.yml`)

Runs on every PR to `main`:
- Code checkout
- Python linting (flake8)
- JavaScript linting (ESLint)
- Python tests (pytest)
- Frappe tests
- SonarQube analysis

### Deployment Workflow (`.github/workflows/deploy.yml`)

Runs on merge to `main`:
- SSH into server
- Update bench
- Run migrations
- Restart services
- Send notifications

## 🧪 Testing the Pipeline

1. Create a feature branch:
   ```bash
   git checkout -b test/ci-pipeline
   ```

2. Make a small change and commit:
   ```bash
   echo "# Test" >> test.md
   git add test.md
   git commit -m "test: verify CI pipeline"
   git push origin test/ci-pipeline
   ```

3. Open a PR to `main` and verify:
   - PR checks run automatically
   - All checks must pass
   - DevOps approval required

4. After merge, verify:
   - Deployment workflow runs
   - Server is updated
   - Notifications are sent

## 🔧 Customization

### Adjust Linting Rules

Edit `.github/workflows/pr-checks.yml` to modify:
- Flake8 configuration
- ESLint rules
- Test commands

### Modify Deployment Steps

Edit `.github/workflows/deploy.yml` to:
- Add pre-deployment steps
- Change bench commands
- Add rollback logic
- Customize notifications

### Environment-Specific Deployments

The workflow uses GitHub Environments. Configure:
- `production` environment for main branch
- `staging` environment for other branches

## 📊 Monitoring

### GitHub Actions Dashboard

View all workflow runs at:
```
https://github.com/YOUR_ORG/YOUR_REPO/actions
```

### SonarQube Dashboard

View code quality metrics at your SonarQube instance.

### GitHub Projects

Create a project board to track:
- PRs awaiting review
- Deployment status
- Quality metrics

## 🐛 Troubleshooting

### PR Checks Failing

1. Check workflow logs in GitHub Actions
2. Run linting/tests locally:
   ```bash
   flake8 .
   pytest tests/
   ```

### Deployment Failing

1. Verify SSH key is correct
2. Check server connectivity
3. Verify bench directory path
4. Check server logs

### Notifications Not Sending

1. Verify webhook URLs are correct
2. Check webhook permissions
3. Review workflow logs for errors

## 📝 License

This project is part of the Frappe release pipeline demo.

## 🤝 Contributing

1. Create a feature branch from `develop`
2. Make your changes
3. Open a PR to `main`
4. Wait for DevOps approval
5. Merge and auto-deploy!

---

**Note**: This is a demo implementation. Adjust configurations according to your specific requirements.

