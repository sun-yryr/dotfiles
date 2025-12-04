# 登録してあるssh先を楽に選択する
function sshselect() {
  local selected=$(grep -E "^Host " ~/.ssh/config | sed -e 's/^.*\*.*$//g' | grep -E "." | sed -e 's/Host[ ]*//g' | fzf)
  if [ -n "$selected" ]; then
    BUFFER="ssh ${selected}"
    zle reset-prompt
    zle end-of-line
  fi
}
zle -N sshselect
bindkey '^s' sshselect

# git switchを楽にする
function _git_switch() {
  git fetch > /dev/null 2>&1
  if [ $? = 0 ]; then
    local selected=$(git branch -a |  grep -v "*" | grep -v "\->" | sed -e 's/^ *//g' | sed  -e 's/^remotes\/origin\///g' | fzf)
    if [ -n "$selected" ]; then
      git switch ${selected}
    fi
  else
    return 1
  fi
}

# gcloud config configuration choice
function _gcloud-activate() {
  name="$1"
  project="$2"
  echo "export CLOUDSDK_ACTIVE_CONFIG_NAME=${name}"
  export CLOUDSDK_ACTIVE_CONFIG_NAME=${name}
}
function _gx-complete() {
  _values $(gcloud config configurations list | awk '{print $1}')
}
function gx() {
  name="$1"
  if [ -z "$name" ]; then
    line=$(gcloud config configurations list | fzf --header-lines=1 --exact --layout=reverse)
    name=$(echo "${line}" | awk '{print $1}')
  else
    line=$(gcloud config configurations list | grep "$name")
  fi
  if [ -n "$line" ]; then
    project=$(echo "${line}" | awk '{print $4}')
    _gcloud-activate "${name}" "${project}"
  fi
}
compdef _gx-complete gx

# aws profile choice
function _aws-activate() {
  profile="$1"
  echo "aws-vault exev ${profile}"
  aws-vault exec ${profile}
}
function _ax-complete() {
  _values $(aws-vault list | awk 'NR > 1 {print $1}')
}
function ax() {
  profile="$1"
  if [ -z "$profile" ]; then
    line=$(aws-vault list | fzf --header-lines=2 --exact --layout=reverse)
    profile=$(echo "${line}" | awk '{print $1}')
  fi
  if [ -n "$profile" ]; then
    _aws-activate "${profile}"
  fi
}
compdef _ax-complete ax

# Need to install safe-chain
source ~/.safe-chain/scripts/init-posix.sh # Safe-chain Zsh initialization script
