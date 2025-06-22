#!/bin/bash

if [[ "$1" == "--dry-run" ]]; then
  echo "🧪 [DRY RUN] Commit message would be:"
  echo "$commit_message"
  exit 0
fi


if git diff --cached --quiet; then
	echo "No staged files found. Please run 'git add <filename>'"
	exit 1
else 
	echo "Stages file detected. Proceeding...."
fi

#Load API Key
if [ -f .env ]; then
	export $(grep -v '^#' .env | xargs)
else
	echo ".env file not found. Exiting"
	exit 1
fi

#Get staged diff
diff_data=$(git diff --cached)

#Call OpenAI API
response=$(curl -s https://api.groq.com/openai/v1/chat/completions \
	-H "Authorization: Bearer $GROO_API_KEY" \
	-H "Content-Type: application/json" \
	-d @- <<EOF

	{
		"model":"llama3-70b-8192",
		"messages": [{
			"role":"user",
			"content": "Generate a concise, conventional commit message for the following Git diff:\n$diff_data"
		}]
	}
EOF
)


#Extract commit message from response
commit_message=$(echo "$response" | jq -r '.choice[0].message.content' 2>/dev/null)

#Ensure message was generated
if [ -z "$commit_message" ] || [ "$commit_message" == "null" ]; then
	echo "Failed to generate commit message. Aborting action"
	#Fallback: extract filename and generate a safe default
	staged_file=$(git diff --cached --name-only | head -n 1)
  	commit_message="chore: update ${staged_file:-files}"
fi

echo "✅ Using commit message:"
echo "$commit_message"

#Log and Commit
echo "Commiting with message: "
echo "$commit_message"
echo "$(date): $commit_message" >> log.txt
git commit -m "$commit_message"

# Auto-push to the current branch

auto_push() {
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

  if git remote get-url origin &>/dev/null; then
    echo "🚀 Pushing to remote branch: $branch"
    git push origin "$branch"
    echo "✅ Code pushed successfully to GitHub."
  else
    echo "⚠️  No remote 'origin' configured. Skipping push."
  fi
}

auto_push
# when running: bash ai-commit.sh --dry-run
