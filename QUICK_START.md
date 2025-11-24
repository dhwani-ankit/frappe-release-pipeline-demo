# Quick Start Guide

## For Developers

### Creating a Feature Branch

```bash
# Start from develop
git checkout develop
git pull origin develop

# Create feature branch
git checkout -b feat/your-feature-name

# Make changes, commit, and push
git add .
git commit -m "feat: your feature description"
git push origin feat/your-feature-name
```

### Opening a Pull Request

1. Go to GitHub and click "New Pull Request"
2. Select your feature branch → `main`
3. Fill in PR description
4. Wait for automated checks to pass:
   - ✅ Linting
   - ✅ Tests
   - ✅ SonarQube Analysis
5. Request DevOps review
6. Once approved, merge!

**Note**: PR cannot be merged until:
- All checks pass ✅
- DevOps approves ✅
- Branch is up to date ✅

## For DevOps Team

### Setting Up the Pipeline

1. **Configure GitHub Secrets** (Settings → Secrets → Actions):
   ```
   SSH_PRIVATE_KEY
   SSH_USER
   SERVER_HOST
   BENCH_DIRECTORY
   ```

2. **Set Up Branch Protection**:
   - Follow `.github/BRANCH_PROTECTION.md`
   - Or manually configure in Settings → Branches

3. **Verify CODEOWNERS**:
   - Ensure `@devops-team` exists in your GitHub org
   - Or update `CODEOWNERS` file with your team name

4. **Test the Pipeline**:
   - Create a test PR
   - Verify all checks run
   - Approve and merge
   - Verify deployment runs

### Monitoring Deployments

- **GitHub Actions**: View all runs at `/actions`
- **Deployment Logs**: Check workflow run logs
- **Notifications**: Monitor Slack/Discord channels
- **SonarQube**: Check code quality dashboard

## Common Issues

### PR Checks Failing

**Linting errors:**
```bash
# Run locally to see errors
flake8 .
eslint .
```

**Test failures:**
```bash
# Run tests locally
pytest tests/
bench --site all run-tests
```

### Deployment Failing

1. Check SSH connectivity:
   ```bash
   ssh $SSH_USER@$SERVER_HOST
   ```

2. Verify bench directory exists:
   ```bash
   ls -la $BENCH_DIRECTORY
   ```

3. Check GitHub Actions logs for specific errors

### Notifications Not Working

1. Verify webhook URLs in GitHub Secrets
2. Test webhook manually:
   ```bash
   curl -X POST $WEBHOOK_URL -d '{"text":"test"}'
   ```

## Workflow Summary

```
Developer → Feature Branch → PR to main
    ↓
GitHub Actions (PR Checks)
    ↓
DevOps Review & Approval
    ↓
Merge to main
    ↓
GitHub Actions (Deploy)
    ↓
Server Updated ✅
```

## Need Help?

- Check `README.md` for detailed documentation
- Review workflow files in `.github/workflows/`
- Check GitHub Actions logs for errors

