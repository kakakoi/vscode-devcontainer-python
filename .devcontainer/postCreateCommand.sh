#/bin/bash

# echo .devcontainer >> .git/info/exclude
# echo .vscode >> .git/info/exclude
echo .env >> .git/info/exclude
echo .aws/config >> .git/info/exclude
echo .aws/credentials >> .git/info/exclude

rm -rf .venv
poetry config virtualenvs.in-project true --local
poetry install
poetry run pre-commit install
poetry run pre-commit autoupdate
