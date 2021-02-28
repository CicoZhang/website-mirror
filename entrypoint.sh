#!/bin/bash

echo 'Initiaing website mirroring'
apt-get update
apt install wget curl git -y
export LANG=en_US.UTF-8
REPO=$( echo "$URL" | sed -e "s/\([^/]*\/\/\)\?\(www\.\)\?\([^.]*\)\..*/\3/")
wget -mkEpnp ./LOCAL $URL
cd LOCAL
cd $(ls)
curl \
	-H "Authorization: token $_GITHUB_TOKEN" https://api.github.com/user/repos \
	-d '{"name":"'$REPO'-website","private":false}'
git init
git config --global user.name "$USER_NAME"
git config --global user.email "$USER_EMAIL"
git add .
git commit -m "initialize website repo"
git push -f https://$_GITHUB_TOKEN:x-oauth-basic@github.com/$USER_NAME/$REPO-website.git master
