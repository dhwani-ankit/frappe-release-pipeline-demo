# Workflow Strategy

## Overview

This repository uses a **two-stage workflow strategy** to optimize for speed and quality:

1. **Development/PR Stage** - Comprehensive quality checks
2. **Release Stage** - Fast deployment and release

## 🔹 Development Branch (PR Checks)

**Workflow:** `.github/workflows/pr-checks.yml`

**Triggers:** Pull requests to `main`

**Purpose:** Validate code correctness, quality, and coverage during feature development

**Checks:**
- ✅ **Linting**: flake8 (Python), ESLint (JavaScript)
- ✅ **Unit Tests**: pytest, Frappe test suite
- ✅ **SonarQube**: Code quality and security scanning
- ✅ **Peer Reviews**: Required via CODEOWNERS

**Result:** PR cannot be merged unless all checks pass

## 🔹 Main Branch (Release Pipeline)

**Workflow:** `.github/workflows/release.yml`

**Triggers:** Push to `main` (after PR merge)

**Assumption:** Code is already tested & approved, quality gates have passed

**Purpose:** Fast deployment and automated release

**Jobs:**

### 1. Smoke Check (Lightweight)
- ✅ Python syntax validation (catches merge conflicts)
- ✅ JSON/YAML file validation
- ⚡ Fast - runs in seconds
- 🚫 No linting, no tests, no SonarQube

### 2. Deploy
- ✅ SSH to server
- ✅ Pull latest changes
- ✅ `bench update --pull --build`
- ✅ `bench migrate`
- ✅ `bench restart`

### 3. Release
- ✅ Auto-version bump (minor version)
- ✅ Create Git tag
- ✅ Create GitHub Release with notes

## ✂️ Why This Strategy?

### Benefits

1. **Speed** ⚡
   - Main branch pipeline is fast (no heavy checks)
   - Deployments happen quickly after merge

2. **Quality** ✅
   - All quality checks happen in PR stage
   - No code reaches main without passing checks

3. **Efficiency** 🎯
   - No duplicate work (checks run once in PR)
   - Focused pipeline for each stage

4. **Reliability** 🛡️
   - Smoke check catches merge issues
   - Deployment is streamlined and predictable

### What's Removed from Main Workflow

❌ **Removed:**
- Full flake8 linting
- pytest test suite
- SonarQube analysis
- ESLint checks

✅ **Kept:**
- Lightweight syntax check
- Deployment job
- Tag + Release job

## 🔁 Complete Flow

```
Developer
    ↓
Feature Branch
    ↓
Open PR to main
    ↓
PR Checks Workflow (pr-checks.yml)
    ├── Lint (flake8, ESLint)
    ├── Tests (pytest)
    └── SonarQube
    ↓
DevOps Review + Approval
    ↓
Merge to main
    ↓
Release Workflow (release.yml)
    ├── Smoke Check (syntax only)
    ├── Deploy to Server
    └── Create Release
    ↓
✅ Production Updated + Tagged
```

## 📊 Workflow Comparison

| Check | PR Stage | Main Stage |
|-------|----------|------------|
| Linting | ✅ Full | ❌ None |
| Tests | ✅ Full | ❌ None |
| SonarQube | ✅ Full | ❌ None |
| Syntax Check | ✅ (via lint) | ✅ Lightweight |
| Deployment | ❌ | ✅ |
| Release | ❌ | ✅ |

## 🎯 Best Practices

1. **Always use PRs** - Never push directly to main
2. **Fix issues in PR** - Don't merge failing PRs
3. **Trust the process** - If PR checks pass, main pipeline will succeed
4. **Monitor deployments** - Check GitHub Actions logs for deployment status

## 🔧 Customization

### To add more checks to main pipeline:

Edit `.github/workflows/release.yml` and add steps to `smoke-check` job.

### To modify PR checks:

Edit `.github/workflows/pr-checks.yml`.

### To change version bumping strategy:

Edit the `Bump Minor Version` step in `release.yml`.

