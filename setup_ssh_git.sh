#!/bin/bash

# Prompt for user email and GitHub username
read -p "Enter your GitHub email: " github_email
read -p "Enter your GitHub username: " github_username

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -C "$github_email" -f ~/.ssh/id_rsa -N ""

# Start the SSH agent
eval "$(ssh-agent -s)"

# Add the SSH private key to the SSH agent
ssh-add ~/.ssh/id_rsa

# Copy the public key to the clipboard (for Linux)
if command -v xclip &> /dev/null; then
    xclip -sel clip < ~/.ssh/id_rsa.pub
    echo "Public key copied to clipboard."
# For macOS
elif command -v pbcopy &> /dev/null; then
    pbcopy < ~/.ssh/id_rsa.pub
    echo "Public key copied to clipboard."
# For Windows (using WSL)
elif command -v clip &> /dev/null; then
    clip < ~/.ssh/id_rsa.pub
    echo "Public key copied to clipboard."
else
    echo "Please copy the following public key manually:"
    cat ~/.ssh/id_rsa.pub
fi

# Instructions for user
echo "Add the SSH key to your GitHub account:"
echo "1. Go to GitHub.com and log in."
echo "2. Click on your profile picture -> Settings."
echo "3. Click on 'SSH and GPG keys' -> 'New SSH key'."
echo "4. Paste your public key and give it a title."
echo "5. Click 'Add SSH key'."

# Prompt for the repository URL
read -p "Enter the GitHub repository URL (e.g., yourusername/repo): " repo_name

# Change the remote URL to use SSH
git remote set-url origin git@github.com:"$github_username"/"$repo_name".git

# Confirm setup
echo "SSH key setup complete! You can now push and pull without a password."