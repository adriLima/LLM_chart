#!/bin/bash

# Prompt for project information
read -p "Enter your project name: " project_name
read -p "Enter your GitHub username: " git_username
read -sp "Enter your GitHub personal access token: " git_token
echo

# Create project directory
mkdir "$project_name"
cd "$project_name" || exit

# Initialize Node.js project
npx npm init -y

# Install required packages
#npm install puppeteer axios

# Create screenshot.js file
cat <<EOL > screenshot.js
console.log("hello");
EOL

# Create .gitignore file
cat <<EOL > .gitignore
node_modules
.env
EOL

# Create README.md file
cat <<EOL > README.md
# $project_name

A Node.js application that takes screenshots of websites and sends them to the OpenAI API for analysis.

## Installation

\`\`\`bash
npm install
\`\`\`

## Usage

\`\`\`bash
node screenshot.js "https://example.com" "Your prompt here"
\`\`\`

## License

This project is licensed under the MIT License.
EOL

# Initialize Git repository
git init

# Add files to Git
git add .

# Commit changes
git commit -m "Initial commit: setup screenshot and OpenAI integration"

# Create remote repository on GitHub
curl -u "$git_username:$git_token" https://api.github.com/user/repos -d "{\"name\":\"$project_name\"}"

# Add remote origin with token
git remote add origin https://"$git_username":"$git_token"@github.com/"$git_username"/"$project_name".git

# Push changes to remote repository
git push -u origin master

echo "Project setup complete! Your project is now available at: https://github.com/$git_username/$project_name"