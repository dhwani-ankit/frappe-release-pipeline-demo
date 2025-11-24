## 📋 PR Checklist for DevOps Review

### Pre-Merge Requirements

Please verify the following before approving this PR:

#### ✅ Code Quality
- [ ] All CI checks are passing (Lint, Tests, SonarQube)
- [ ] No merge conflicts
- [ ] Code follows project standards and conventions
- [ ] SonarQube quality gate passed (if applicable)

#### ✅ Testing
- [ ] Unit tests pass locally
- [ ] Integration tests pass (if applicable)
- [ ] Manual testing completed (if required)
- [ ] No breaking changes (or breaking changes documented)

#### ✅ Security & Compliance
- [ ] No sensitive data exposed (API keys, passwords, etc.)
- [ ] Dependencies are up to date and secure
- [ ] Security scan passed (if applicable)
- [ ] Compliance requirements met

#### ✅ Documentation
- [ ] Code is properly commented
- [ ] README updated (if needed)
- [ ] Changelog updated (if applicable)
- [ ] Migration notes added (if database changes)

#### ✅ Deployment Readiness
- [ ] Database migrations are backward compatible (if applicable)
- [ ] Environment variables documented (if new ones added)
- [ ] No hardcoded configuration values
- [ ] Rollback plan considered (if major changes)

#### ✅ Review Notes
- [ ] All review comments addressed
- [ ] No outstanding discussions
- [ ] PR description is clear and complete

---

## 📝 PR Details

**Type:** <!-- Bug fix / Feature / Hotfix / Refactor / Documentation -->

**Description:**
<!-- Describe what this PR does -->

**Related Issues:**
<!-- Link to related issues: Closes #123, Fixes #456 -->

**Testing Instructions:**
<!-- How to test this PR -->

**Screenshots (if applicable):**
<!-- Add screenshots here -->

**Deployment Notes:**
<!-- Any special deployment instructions or considerations -->

---

## ⚠️ DevOps Approval Required

This PR requires DevOps team approval before merging (see CODEOWNERS).

**Reviewer:** @your-devops-team

**Status:** ⏳ Pending Review

---

## 📌 Post-Merge Checklist (Auto-filled after merge)

- [ ] Deployment triggered automatically
- [ ] Release tag created
- [ ] GitHub release published
- [ ] Manual deployment completed (if required)
- [ ] Post-deployment verification completed

