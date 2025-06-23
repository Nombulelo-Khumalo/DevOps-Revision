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

## 🧠Part 1: GIT INTERVIEW: 10 HIGH-VALUE Q\&A

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
---

## 🔥 PART 2: 10 MOST ASKED GIT INTERVIEW QUESTIONS (DEVOPS-FOCUSED)

| #  | ❓ Question                                                 | ✅ Ideal Answer                                                                                                                                      |
| -- | ---------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------- |
| 1  | What is Git, and how is it different from SVN?             | Git is a distributed version control system (VCS); SVN is centralized. Git allows local commits and offline work, and is faster for large projects. |
| 2  | How do you resolve a merge conflict in Git?                | Use `git status` to locate the file, manually edit the conflict markers (`<<<<<<<`), then `git add` and `git commit`.                               |
| 3  | What’s the difference between `git fetch` and `git pull`?  | `fetch` only downloads changes. `pull` = `fetch` + `merge` into current branch.                                                                     |
| 4  | What is `.gitignore` and why is it important?              | It lists files Git should ignore (e.g., logs, secrets, dependencies). Prevents unnecessary or sensitive data in commits.                            |
| 5  | How do you rollback a commit that was already pushed?      | Use `git revert <hash>` to undo changes safely with a new commit.                                                                                   |
| 6  | What is a detached HEAD state?                             | When HEAD points to a commit directly (not a branch). Happens after `git checkout <commit>` instead of a branch.                                    |
| 7  | How do you squash commits before merging a feature branch? | Use `git rebase -i HEAD~n`, mark commits as `squash`, then force-push the branch.                                                                   |
| 8  | How do you revert only one file to a previous commit?      | `git checkout <commit-hash> -- <file>`                                                                                                              |
| 9  | How can you see what changes will be pushed?               | Use `git log origin/main..HEAD` to show commits ahead of remote.                                                                                    |
| 10 | How do you tag a release?                                  | `git tag -a v1.0.0 -m "Release 1.0.0"` then `git push origin v1.0.0`                                                                                |

---

## 🧠 PART 3: 10 ADVANCED + RARE BUT CRUCIAL QUESTIONS

| #  | ❓ Question                                                             | ✅ Expert Answer                                                                                                                |
| -- | ---------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| 1  | How do you clean sensitive data that was committed?                    | Use `git filter-repo` or `filter-branch`, then force-push and invalidate any cloned repos.                                     |
| 2  | Explain Git Internals: what are objects and refs?                      | Git stores content as objects (blobs, trees, commits), and refs point to commits. Every file becomes a hash in `.git/objects`. |
| 3  | How does Git rebase work under the hood?                               | It re-applies commits on top of another base commit, rewriting history. Useful for linear commit history.                      |
| 4  | When should you use `cherry-pick`?                                     | To apply a single commit from another branch into your current branch. Ideal in hotfix or backport situations.                 |
| 5  | Explain `reflog` and when it’s used.                                   | `git reflog` tracks all changes to HEAD. You can recover lost commits with it even after reset.                                |
| 6  | What’s the difference between `reset --mixed`, `--soft`, and `--hard`? | `--soft`: keeps changes staged; `--mixed`: unstages; `--hard`: discards everything.                                            |
| 7  | What is `git bisect` used for?                                         | Binary search through commits to find the one that introduced a bug.                                                           |
| 8  | Explain the difference between annotated and lightweight tags.         | Annotated tags have metadata (author, date), stored as full objects. Lightweight tags are pointers only.                       |
| 9  | What’s the purpose of `git stash` and how do you apply a stash?        | Temporarily saves uncommitted changes. Use `git stash` and `git stash pop` or `git stash apply`.                               |
| 10 | How would you design a Git strategy for a large CI/CD project?         | Use trunk-based or Gitflow with automation: PR checks, feature flags, squashed merges, and protected branches.                 |

---

## 🤝 PART 4: GENERAL DEVOPS-FRIENDLY GIT INTERVIEW QUESTIONS

| #  | ❓ Question                                                   | ✅ Pro Tip                                                                                                        |
| -- | ------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------- |
| 1  | How do you manage Git repos in a multi-developer team?       | Feature branches + pull requests, code reviews, protected branches.                                              |
| 2  | What tools integrate with Git in DevOps?                     | GitHub, GitLab, Bitbucket, Jenkins, GitHub Actions, ArgoCD, Terraform.                                           |
| 3  | How do you manage Git versioning?                            | Semantic versioning with tags, e.g., `v1.2.0`. Tag triggers pipeline builds.                                     |
| 4  | How do you prevent merge conflicts in teams?                 | Frequent pulls, clear ownership of modules, feature flags.                                                       |
| 5  | What is GitOps?                                              | Using Git as the single source of truth for deployments (e.g., ArgoCD or FluxCD reads from Git to deploy infra). |
| 6  | How do you rollback a deployment using GitOps?               | Revert the Git commit that changed the state file (e.g., a YAML manifest), which triggers auto-rollback.         |
| 7  | How do you compare two branches?                             | `git diff branch1..branch2`                                                                                      |
| 8  | What if a teammate force pushes and overwrites your commits? | Use `git reflog` to recover your commits and `git cherry-pick` them back.                                        |
| 9  | How do you archive a Git repo?                               | `git bundle` or create a release zip from GitHub.                                                                |
| 10 | How would you enforce Git policies in CI/CD?                 | Add branch protection rules + pre-commit hooks + linting in GitHub Actions or Jenkins pipelines.                 |

---

