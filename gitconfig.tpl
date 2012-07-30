#!/bin/bash

[[ -z ${GIT_NAME+x}     ]] && read -p "Your Name: " GIT_NAME
[[ -z ${GIT_EMAIL+x}    ]] && read -p "Your Email: " GIT_EMAIL
[[ -z ${GITHUB_USER+x}  ]] && read -p "GitHub Username: " GITHUB_USER

cat <<EOF
[user]
  name = $GIT_NAME
  email = $GIT_EMAIL
[core]
  excludesfile = $HOME/.gitignore
  editor = mate -w
[github]
  user = $GITHUB_USER
  token = !security 2>&1 >/dev/null find-generic-password -gs \"Github API Token\" | ruby -e 'print $1 if STDIN.gets =~ /^password: \\\"(.*)\\\"$/'
[merge]
  tool = opendiff
[credential]
  helper = cache --timeout=3600
[color]
  diff = auto
  status = auto
  branch = auto
  interactive = auto
[alias]
  st = status
  ci = commit
  br = branch
  co = checkout
  df = diff
  lg = log -p
  who = shortlog -s --
  slog  = !git --no-pager log --format=oneline --abbrev-commit
  dfnp  = !git --no-pager diff
  up = !sh -c 'git pull --rebase --prune && git log --pretty=format:\"%Cred%ae %Creset- %C(yellow)%s %Creset(%ar)\" HEAD@{1}..'
EOF

# vim: filetype=bash :
