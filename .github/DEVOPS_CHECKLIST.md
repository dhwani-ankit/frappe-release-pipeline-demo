# DevOps PR Review Checklist

This document provides a comprehensive checklist for DevOps team members when reviewing Pull Requests.

## 🔍 Pre-Review

- [ ] Verify PR is targeting the correct branch (`main`)
- [ ] Check that all required CI checks are passing
- [ ] Review PR description for clarity and completeness

## ✅ Code Quality Checks

### Linting & Formatting
- [ ] All linting checks pass (flake8, ESLint)
- [ ] Code follows project style guidelines
- [ ] No syntax errors or warnings

### Code Review
- [ ] Code is readable and well-structured
- [ ] No obvious bugs or logic errors
- [ ] Error handling is appropriate
- [ ] No security vulnerabilities identified

### SonarQube Analysis
- [ ] SonarQube scan completed successfully
- [ ] Code quality gate passed
- [ ] No critical or blocker issues
- [ ] Code coverage maintained (if applicable)

## 🧪 Testing Verification

### Automated Tests
- [ ] All unit tests pass
- [ ] Integration tests pass (if applicable)
- [ ] Test coverage is adequate
- [ ] No flaky tests

### Manual Testing (if required)
- [ ] Feature works as described
- [ ] Edge cases handled
- [ ] UI/UX is acceptable (if applicable)
- [ ] Performance is acceptable

## 🔒 Security Review

### Data Security
- [ ] No sensitive data in code (API keys, passwords, tokens)
- [ ] Secrets are properly managed (environment variables, secrets manager)
- [ ] No hardcoded credentials
- [ ] Input validation implemented

### Dependencies
- [ ] Dependencies are up to date
- [ ] No known security vulnerabilities in dependencies
- [ ] Dependency versions are pinned (if applicable)

### Access Control
- [ ] Proper authentication/authorization checks
- [ ] No privilege escalation risks
- [ ] API endpoints are secured (if applicable)

## 📚 Documentation

### Code Documentation
- [ ] Code is properly commented
- [ ] Complex logic is explained
- [ ] Function/method docstrings present (if applicable)

### Project Documentation
- [ ] README updated (if needed)
- [ ] Changelog updated
- [ ] Migration guide added (if database changes)
- [ ] API documentation updated (if applicable)

## 🚀 Deployment Readiness

### Configuration
- [ ] No hardcoded configuration values
- [ ] Environment variables documented
- [ ] Configuration is environment-agnostic

### Database Changes
- [ ] Migrations are backward compatible
- [ ] Rollback migrations exist
- [ ] Migration scripts tested
- [ ] Data migration plan (if needed)

### Infrastructure
- [ ] No infrastructure changes without approval
- [ ] Resource requirements documented
- [ ] Scaling considerations addressed

### Deployment Plan
- [ ] Deployment steps are clear
- [ ] Rollback plan exists
- [ ] Deployment timing considered
- [ ] Impact assessment completed

## 📋 Compliance & Standards

### Project Standards
- [ ] Follows project coding standards
- [ ] Follows Git commit message conventions
- [ ] Branch naming conventions followed

### Compliance
- [ ] Regulatory requirements met (if applicable)
- [ ] Data privacy considerations addressed
- [ ] Audit trail maintained

## ✅ Final Checks

### Review Process
- [ ] All review comments addressed
- [ ] No outstanding discussions
- [ ] PR is ready for merge
- [ ] Approval given

### Post-Merge
- [ ] Deployment will trigger automatically
- [ ] Release will be created automatically
- [ ] Manual deployment steps documented (if needed)
- [ ] Team notified (if required)

## 🚨 Red Flags (Do NOT Approve If)

- ❌ CI checks are failing
- ❌ Security vulnerabilities present
- ❌ Breaking changes without migration plan
- ❌ Sensitive data exposed
- ❌ Tests are failing
- ❌ Code quality is poor
- ❌ Documentation is missing for complex changes
- ❌ No rollback plan for risky changes

## 📝 Approval Decision

**Decision:** <!-- Approve / Request Changes / Comment -->

**Notes:**
<!-- Add any additional notes or concerns -->

**Approved by:** @your-devops-team
**Date:** <!-- Auto-filled -->

---

## Quick Reference

### Common Issues to Watch For

1. **Security Issues**
   - Hardcoded secrets
   - SQL injection risks
   - XSS vulnerabilities
   - Insecure API endpoints

2. **Performance Issues**
   - N+1 queries
   - Missing indexes
   - Inefficient algorithms
   - Memory leaks

3. **Maintainability Issues**
   - Code duplication
   - Complex logic without comments
   - Missing error handling
   - Poor naming conventions

4. **Deployment Issues**
   - Missing migrations
   - Environment-specific code
   - Missing environment variables
   - Breaking changes

---

**Last Updated:** 2024
**Maintained by:** DevOps Team

