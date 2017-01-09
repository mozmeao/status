#!/bin/bash
REPOSITORY=$1

if [[ -z "${REPOSITORY}" ]]; then
    echo "Set REPOSITORY"
    exit 1;
fi

if [[ -z "${GITHUB_AUTH_TOKEN}" ]]; then
    echo "Set GITHUB_AUTH_TOKEN"
    exit 1;
fi

rm -rf docs
git clone https://github.com/${REPOSITORY}.git ./docs/

# Build site
pushd ./local-dev
npm run build
npm run finalize
popd

pushd ./docs
git config user.email "statusbot@mozmar.org"
git config user.name "mozmar-statusbot"
git add -f --all .
git commit -m "Site update"
git remote add origin-rw https://${GITHUB_AUTH_TOKEN}@github.com/${REPOSITORY}.git
# Push only if there are commit changes.
if [[ $? == 0 ]];
then
    git push origin-rw master 2> /dev/null
fi
