### 🎤 INTERVIEW SCENARIO PRACTICE
**“Your teammate pushed broken code. How do you fix this?”**

1. You check logs: git log --oneline

2. Revert or reset the commit: git revert <hash> or git reset

3. Push fix: git push origin main --force (only if allowed!)

**“How do you use Git in CI/CD?”**

* Use feature branches, PR triggers (e.g., on: pull_request)

* Tag releases with git tag -a v1.0.0 -m "Release"

* Automate versioning and changelogs

---

## 🧠 GIT INTERVIEW: 10 HIGH-VALUE Q\&A

| ❓Question                                                            | ✅ Smart Answer                                                                                                            |
| -------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| **What is Git and why use it in DevOps?**                            | Git is a distributed version control system that enables collaboration, rollbacks, and audit history in DevOps pipelines. |
| **How do you revert a bad deploy using Git?**                        | Revert the deploy commit using `git revert <hash>`, then push to trigger rollback pipeline.                               |
| **What’s the difference between `reset`, `revert`, and `checkout`?** | `reset` changes history, `revert` makes a new opposite commit, `checkout` lets you move to branches/commits.              |
| **Explain a merge conflict. How do you fix it?**                     | It happens when Git can't auto-merge changes. You manually fix the file, `add`, and `commit`.                             |
| **What is `.gitignore`?**                                            | It's a file that tells Git which files/folders not to track. Essential for keeping secrets/configs out of repos.          |
| **What is a tag?**                                                   | A snapshot label for a release. E.g. `v1.0.0`. Useful for CI/CD triggers.                                                 |
| **What happens if you push to the wrong branch?**                    | Use `git reset` or `git revert`, then force-push if needed (`--force-with-lease` preferred).                              |
| **How do you squash commits?**                                       | Use `git rebase -i HEAD~n` to combine commits before merging PRs.                                                         |
| **What’s a pull request?**                                           | A GitHub-based way to propose, review, and merge code into main branches.                                                 |
| **How do you handle Git in CI/CD pipelines?**                        | Use feature branches, tag releases, trigger jobs on push/pull requests using GitHub Actions or Jenkins.                   |

---

## 💥 REAL DEVOPS SCENARIOS & CHALLENGES

### 📦 Scenario 1: Team Member Pushed Secrets

**Problem:** `.env` file with credentials pushed

**Fix:**

```bash
git rm --cached .env
echo ".env" >> .gitignore
git commit -m "fix: remove secrets"
```

If already in history:

```bash
git filter-branch --force --index-filter \
"git rm --cached --ignore-unmatch .env" \
--prune-empty --tag-name-filter cat -- --all
```

---

### 🛠️ Scenario 2: Fix Broken Main Branch

**Symptoms:**

* Main has failing pipeline
* Feature was force pushed

**Resolution Plan:**

1. Check `git log` to identify last good commit
2. `git revert` bad commits OR
3. `git reset --hard <last-good-hash>` (if team-approved)
4. Force push with `--force-with-lease`

---

### 🧩 Scenario 3: Broken Merge – Fix History

**How to squash commits before merging:**

```bash
git rebase -i HEAD~4
# Change 'pick' to 'squash' on extra commits
git push --force-with-lease
```
