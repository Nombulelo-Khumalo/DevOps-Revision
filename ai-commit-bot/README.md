# ✅ `README.md` for GitHub Repo: `ai-commit-bot`
---
![Shell Script](https://img.shields.io/badge/script-bash-blue?style=flat-square)
![Powered by Groq](https://img.shields.io/badge/AI-Groq_LLaMA3-yellowgreen?style=flat-square)
![GitHub Repo stars](https://img.shields.io/github/stars/Nombulelo-Khumalo/DevOps-Revision?style=social)
---
## AI-powered Git automation tool
---
* Explains what this tool is
* Shows how to use it
* Lists errors users may encounter (and how we solved them)
* Positions you as a serious cloud innovator
---
````markdown
# 🤖 AI Commit Bot — Automate Git Commits Using AI (with Fallbacks)

A futuristic Git automation script that generates **commit messages using AI**, gracefully handles **API errors**, and **auto-pushes** your changes to GitHub.

Built with DevOps best practices in mind — no more writing dull commit messages, no more skipping `git push`, and no breaking on API limits.

---

## 📦 Features

- ✅ Generates commit messages using [Groq's LLaMA3](https://console.groq.com/)
- ✅ Fallbacks to conventional messages if API fails
- ✅ Logs all commits to `log.txt`
- ✅ Auto-pushes to your current Git branch
- ✅ Configured via a simple `.env` file
- ✅ Written entirely in **bash** — no dependencies (besides `curl` and `jq`)

---

## 🛠️ Setup

1. Clone the repo:

```bash
git clone https://github.com/Nombulelo-Khumalo/DevOps-Revision/tree/main/ai-commit-bot
cd DevOps-Revision
cd ai-commit-bot
````

2. Install `jq` (used for parsing JSON):

```bash
# On Ubuntu/Debian:
sudo apt install jq

# On macOS:
brew install jq
```

3. Create a `.env` file with your [Groq API key](https://console.groq.com/keys):

```env
GROQ_API_KEY=gsk_your_actual_key_here
```

4. Make the script executable:

```bash
chmod +x ai-commit.sh
```

---

## 🚀 Usage

1. Stage your files:

```bash
git add .
```

2. Run the script:

```bash
./ai-commit.sh
```

You’ll see output like:

```
Stages file detected. Proceeding....
Committing with message:
feat: add new login validator for user auth
🚀 Pushing to remote branch: main
✅ Code pushed successfully to GitHub.
```

---

## 🧠 Example Commit Message (from AI)

> `feat: add test2.py with initial content`

---

## ⚠️ Known Errors + How We Solved Them

| Problem                 | Fix                                                          |
| ----------------------- | ------------------------------------------------------------ |
| `No staged files found` | Make sure you `git add` your files first                     |
| `jq: command not found` | Install `jq` as shown above                                  |
| `Invalid API Key`       | Use **Groq** key, not OpenAI; set `GROQ_API_KEY` in `.env`   |
| `model_not_found`       | Use supported model like `llama3-70b-8192`                   |
| `EOF` block error       | Ensure `EOF` is on its own line with no spaces               |
| Script doesn’t push     | You must **call** the `auto_push` function after defining it |

---

## 🔐 API Notes

This project uses:

* Endpoint: `https://api.groq.com/openai/v1/chat/completions`
* Model: `llama3-70b-8192` (as of June 2025)
* Format: OpenAI-compatible JSON

---

## 📂 File Structure

```bash
.
├── ai-commit.sh     # Main automation script
├── .env             # Stores API key
├── log.txt          # Tracks commit history
└── README.md        # You're here
```

---

## 🌍 Built By

**Nombulelo Khumalo (Lelo)**
💼 [LinkedIn Profile](https://www.linkedin.com/in/nombulelo-khumalo-97821b315/)
🚀 DevOps | Cloud Innovator | Future Tech Leader
🌐 [GitHub Profile](https://github.com/Nombulelo-Khumalo)

---

## 💡 Next Up(Upcoming)

* Add GitHub Actions to run `ai-commit.sh` before every PR ✅
* Extend to support **AI PR descriptions** and **release notes**
* Publish this as a **CLI tool**: `commitai`

---

## 🙌 Contribute

Want to add support for OpenAI, Together AI, or local LLMs? Fork it, improve it, and PR!

---

## 📜 License

MIT — use it freely, improve it proudly.

