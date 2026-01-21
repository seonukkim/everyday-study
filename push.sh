#!/bin/bash

# Git push script for seonukkim-blog
echo "Starting git push process..."

# Remove Zone.Identifier files
find . -name "*:Zone.Identifier" -type f -delete

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not in a git repository"
    exit 1
fi

# Add all changes
echo "Adding all changes..."
git add .

# Check if there are any changes to commit
if git diff --cached --quiet; then
    echo "No changes to commit"
    exit 0
fi

# Get commit message from user input or use default
if [ -z "$1" ]; then
    echo "Enter commit message (or press Enter for default): "
    read -r commit_message
    if [ -z "$commit_message" ]; then
        commit_message="Update: $(date '+%Y-%m-%d %H:%M:%sS')"
    fi
else
    commit_message="$1"
fi

# Commit changes
echo "Committing changes..."
git commit -m "$commit_message"

# Check if commit was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to commit changes"
    exit 1
fi

# Push to remote repository
echo "Pushing to remote repository..."
git push

# Check if push was successful
if [ $? -eq 0 ]; then
    echo "Successfully pushed to remote repository"
    echo "Process completed"
else
    echo "Error: Failed to push to remote repository"
    exit 1
fi 