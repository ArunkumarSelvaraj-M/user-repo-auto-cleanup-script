#!/bin/bash

# GitHub username
GITHUB_USERNAME="<ENTER YOUR USERNAME>"

# Personal access token
TOKEN="<ENTER YOUR TOKEN>"

# Get the names of all your PUBLIC repositories on your Github account
public_repos=$(curl -s "https://api.github.com/users/$GITHUB_USERNAME/repos?per_page=100&page=1" | jq -r '.[] | select(.owner.login == "'$GITHUB_USERNAME'") | .full_name')

# Get the names of all your PRIVATE repositories on your Github account
private_repos=$(curl -s -H "Authorization: token $TOKEN" "https://api.github.com/user/repos?visibility=private" | jq -r '.[] | select(.owner.login == "'$GITHUB_USERNAME'") | .full_name')

# Combine public and private repos into a single list
all_repos=$(echo -e "$public_repos\n$private_repos")

# Display the list of public and private repositories to be deleted
echo "The following repositories will be deleted:"
echo -e "\nPublic Repositories:"
echo "$public_repos"
echo -e "\nPrivate Repositories:"
echo "$private_repos"

# Ask for confirmation to proceed
read -p "Are you sure you want to delete all these repositories? This action cannot be undone! (yes/no): " confirm

if [[ "$confirm" == "yes" || "$confirm" == "y" ]]; then
    # Save repo names to a temporary file
    echo "$all_repos" > repo_list.txt

    # Delete all repositories
    while read repo; do
        response=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE -H "Authorization: token $TOKEN" "https://api.github.com/repos/$repo")
        if [[ "$response" == "204" ]]; then
            echo "Repository '$repo' has been deleted."
        else
            echo "Failed to delete repository '$repo'. HTTP response code: $response"
        fi
    done < repo_list.txt

    # Clean up temporary file
    rm repo_list.txt

    echo "All selected repositories have been deleted."
else
    echo "Operation canceled. No repositories were deleted."
fi
