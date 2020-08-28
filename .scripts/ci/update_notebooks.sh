#!/usr/bin/env bash

ORIGIN="https://github.com/theislab/cellrank_notebooks"
DIRNAME="cellrank_notebooks"
FILE="README.rst"


git clone "$ORIGIN" "$DIRNAME"
cd "$DIRNAME"

cp "../$FILE" .

git add -f "$FILE"
# don't use [ci skip] and allow empty because we want to regenerate the notebooks
git commit --allow-empty -m "Update README.rst: $TRAVIS_BUILD_NUMBER"

if [[ $? -eq 0 ]]; then
    git push "https://$DEPLOY_TOKEN@${ORIGIN:8}" --quiet
else
    echo "Committing returned non-zero exit status, this shouldn't have happened"
fi

cd ..
rm -rf "$DIRNAME"
