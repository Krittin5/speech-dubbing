#!/bin/bash

# Script to set up GitHub repository and push code
# Usage: ./setup_github.sh <your-github-username> <repo-name>

if [ $# -lt 2 ]; then
    echo "Usage: ./setup_github.sh <your-github-username> <repo-name>"
    echo "Example: ./setup_github.sh krittinnagar speech-dubbing"
    exit 1
fi

GITHUB_USER=$1
REPO_NAME=$2

echo "Setting up GitHub repository..."
echo "Repository: https://github.com/${GITHUB_USER}/${REPO_NAME}"

# Add remote
git remote add origin https://github.com/${GITHUB_USER}/${REPO_NAME}.git

# Set main branch
git branch -M main

# Push to GitHub
echo "Pushing to GitHub..."
git push -u origin main

echo "Done! Your repository is now available at:"
echo "https://github.com/${GITHUB_USER}/${REPO_NAME}"

