# user-repo-auto-cleanup-script
## Auto Repo Deleter with Detailed Confirmation

This repository contains a shell script that deletes all public and private repositories associated with your GitHub account. Before deletion, the script lists both public and private repositories separately and asks for confirmation to proceed.

## Prerequisites

- **jq**: A command-line JSON processor. Install it using your package manager:
  - On Ubuntu/Debian: `sudo apt-get install jq`
  - On macOS: `brew install jq`
  
- **curl**: A command-line tool to transfer data from or to a server. Most systems come with `curl` pre-installed.

## Setup

1. Clone this repository:

    ```bash
    git clone https://github.com/your-username/auto-repo-deleter.git
    cd auto-repo-deleter
    ```

2. Open the script file (`delete_all_repos.sh`) and set the following variables:

    - `GITHUB_USERNAME`: Your GitHub username.
    - `TOKEN`: Your GitHub Personal Access Token. Ensure the token has the necessary permissions to delete repositories.

    ```bash
    GITHUB_USERNAME="your-github-username"
    TOKEN="your-github-token"
    ```

3. Save the file.

## Usage

1. Run the script:

    ```bash
    bash delete_all_repos.sh
    ```

2. The script will display the list of public and private repositories under your GitHub account:

    ```bash
    The following repositories will be deleted:

    Public Repositories:
    username/public-repo-name

    Private Repositories:
    username/private-repo-name
    ```

3. You will then be asked for confirmation before the deletion process begins:

    ```bash
    Are you sure you want to delete all these repositories? This action cannot be undone! (yes/no):
    ```

4. Enter `yes` or `y` to delete the repositories, or `no` to cancel the operation.

5. If you confirm, the script will delete the repositories and display a message for each one:

    ```bash
    Repository 'username/repo-name' has been deleted.
    ```

6. Once all selected repositories have been deleted, a final message will be displayed:

    ```bash
    All selected repositories have been deleted.
    ```

## Important Notes

- **Detailed Confirmation**: This script lists both public and private repositories separately before asking for deletion confirmation. Ensure you review the list carefully before proceeding.
- **Personal Access Token**: Be careful with your Personal Access Token. Do not share it publicly or commit it to a public repository.
- **Script Scope**: This script only deletes repositories under your personal GitHub account. It does not affect repositories under organizations.

## License

This project is licensed under the MIT License.

