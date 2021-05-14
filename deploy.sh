#!/bin/bash

set -e

GITHUB_TOKEN="${1}"
GITHUB_REPO="ImMathanR/immathan.dev-public"
GITHUB_BRANCH="main"

printf "\033[0;32mClean up public folder...\033[0m\n"
cd public
git checkout ${GITHUB_BRANCH}
git pull origin ${GITHUB_BRANCH}
shopt -s extglob
rm -rf -- !(CNAME|.git|.|..)
cd ..

printf "\033[0;32mBuilding website...\033[0m\n"
hugo

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"
cd public

MESSAGE="rebuilding site $(date)"
git add .

git config --global user.email "mathan.raj43@gmail.com"
git config --global user.name "Mathan"
printf "added git user config"
git commit -m "$MESSAGE"
printf "commited"
git push origin "${GITHUB_BRANCH}"
printf "pushed"

# if [[ -z "${GITHUB_TOKEN}" || -z "${GITHUB_REPO}" ]]; then
#   git config --global user.email "ci@github"
#   git config --global user.name "GitHub Actions CI"
#   git commit -m "$MESSAGE"
#   git push origin "${GITHUB_BRANCH}"
# else
#   git config --global user.email "ci@github"
#   git config --global user.name "GitHub Actions CI"
  
#   git commit -m "$MESSAGE"
  
#   git push --quiet "https://${GITHUB_TOKEN}:x-oauth-basic@github.com/${GITHUB_REPO}.git" "${GITHUB_BRANCH}"
# fi
