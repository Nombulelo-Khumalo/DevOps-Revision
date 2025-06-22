### 🎤 INTERVIEW SCENARIO PRACTICE
**“Your teammate pushed broken code. How do you fix this?”

1. You check logs: git log --oneline

2. Revert or reset the commit: git revert <hash> or git reset

3. Push fix: git push origin main --force (only if allowed!)

**“How do you use Git in CI/CD?”

* Use feature branches, PR triggers (e.g., on: pull_request)

* Tag releases with git tag -a v1.0.0 -m "Release"

* Automate versioning and changelogs
