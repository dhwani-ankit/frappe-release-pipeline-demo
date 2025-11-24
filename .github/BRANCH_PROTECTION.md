# Branch Protection Rules for Main Branch

This document describes the branch protection rules that should be configured in GitHub Settings.

## Required Settings

Navigate to: **Settings → Branches → Branch protection rules → Add rule**

### Rule Name
`main`

### Branch name pattern
`main`

### Protection Settings

#### ✅ Require a pull request before merging
- **Require approvals:** 1
- **Dismiss stale pull request approvals when new commits are pushed:** ✅ Enabled
- **Require review from Code Owners:** ✅ Enabled
- **Restrict who can dismiss pull request reviews:** DevOps Team only

#### ✅ Require status checks to pass before merging
- **Require branches to be up to date before merging:** ✅ Enabled
- **Status checks that are required:**
  - `linting` (Linting job)
  - `tests` (Tests job)
  - `sonarqube` (SonarQube Analysis job)
  - `all-checks` (All Checks Status job)

#### ✅ Require conversation resolution before merging
- ✅ Enabled

#### ✅ Do not allow bypassing the above settings
- ✅ Enabled (even for administrators)

#### ✅ Restrict who can push to matching branches
- **Allow specified actors to bypass required pull requests:** None (or only DevOps Team)

#### ✅ Lock branch
- ❌ Disabled (we need to allow merges)

## Additional Settings

### Allow force pushes
- ❌ Disabled

### Allow deletions
- ❌ Disabled

## Summary

With these settings:
- ✅ No direct pushes to main allowed
- ✅ All PRs require DevOps approval (via CODEOWNERS)
- ✅ All status checks must pass
- ✅ PRs must be up to date with main
- ✅ No bypassing allowed (even for admins)

