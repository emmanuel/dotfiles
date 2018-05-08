#!/bin/bash

[[ -z ${GIT_NAME+x}     ]] && read -p "(gitconfig) Your Name: " GIT_NAME
[[ -z ${GIT_EMAIL+x}    ]] && read -p "(gitconfig) Your Email: " GIT_EMAIL
[[ -z ${GITHUB_USER+x}  ]] && read -p "(gitconfig) GitHub Username: " GITHUB_USER

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
  di = diff
  dc = diff --cached
  amend = commit --amend
  aa = add --all
  ff = merge --ff-only
  pullff = pull --ff-only
  noff = merge --no-ff
  fa = fetch --all
  pom = push origin master
  b = branch
  ds = diff --stat=160,120
  dh1 = diff HEAD~1

  lg = log -p
  who = shortlog -s --
  up = !sh -c 'git pull --rebase --prune && git log --pretty=format:\"%Cred%ae %Creset- %C(yellow)%s %Creset(%ar)\" HEAD@{1}..'

  # Divergence (commits we added and commits remote added)
  div = divergence

  # Goodness (summary of diff lines added/removed/total)
  gn = goodness
  gnc = goodness --cached

  # Fancy logging.
  #   h = head
  #   hp = head with patch
  #   r = recent commits, only current branch
  #   ra = recent commits, all reachable refs
  #   l = all commits, only current branch
  #   la = all commits, all reachable refs
  head = !git l -1
  h = !git head
  hp = "!source ~/.githelpers && show_git_head"
  r = !git l -30
  ra = !git r --all
  l = "!source ~/.githelpers && pretty_git_log"
  la = !git l --all

  slog  = !git --no-pager log --format=oneline --abbrev-commit
  dfnp  = !git --no-pager diff
  # Use SSH instead of HTTPS for Github
  [url "ssh://git@github.com/"]
  	insteadOf = https://github.com/
EOF
