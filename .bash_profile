# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# enable **
shopt -sq globstar 2> /dev/null > /dev/null

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000000
HISTFILESIZE=200000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export EDITOR="vim -p"

### Marks {

export MARKPATH=$HOME/.marks
export PROJECTPATH=$HOME/.projects

function project {
  mkdir -p "$PROJECTPATH/$1"; rm "$MARKPATH"; ln -s "$PROJECTPATH/$1" "$MARKPATH"
}
function projects {
    ls -1 "$PROJECTPATH/"
}

function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH/" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH/ -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

_completeprojects() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $PROJECTPATH/ -mindepth 1 -type d -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark cdj
complete -F _completeprojects project
alias cdj="jump"
### } Marks


alias twgr='grep -R -i -I . -e '
alias twgs='grep -R -I . -e '


#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape sequences.
#  I don't remember where I found this.  o_O

# Reset
Color_Off="\[\033[0m\]"       # Text Reset

# Regular Colors
Black="\[\033[0;30m\]"        # Black
Red="\[\033[0;31m\]"          # Red
Green="\[\033[0;32m\]"        # Green
Yellow="\[\033[0;33m\]"       # Yellow
Blue="\[\033[0;34m\]"         # Blue
Purple="\[\033[0;35m\]"       # Purple
Cyan="\[\033[0;36m\]"         # Cyan
White="\[\033[0;37m\]"        # White

# Bold
BBlack="\[\033[1;30m\]"       # Black
BRed="\[\033[1;31m\]"         # Red
BGreen="\[\033[1;32m\]"       # Green
BYellow="\[\033[1;33m\]"      # Yellow
BBlue="\[\033[1;34m\]"        # Blue
BPurple="\[\033[1;35m\]"      # Purple
BCyan="\[\033[1;36m\]"        # Cyan
BWhite="\[\033[1;37m\]"       # White

# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

human_time() {
  local s=$1
  local days=$((s / (60*60*24)))
  s=$((s - days*60*60*24))
  local hours=$((s / (60*60)))
  s=$((s - hours*60*60))
  local min=$((s / 60))
  if [ "$days" != 0 ]
  then
    local day_string="${days}d "
  fi
  printf "$day_string%02d:%02d\n" $hours $min
}

set_begin() {
    begin="$(date +"%s %N" | sed 's/N$/0/')"
}

calc_elapsed() {
  local elapsed
  read begin_s begin_ns <<< "$begin"
  begin_ns="${begin_ns##+(0)}"
  # PENDING - date takes about 11ms, maybe could do better by digging in
  # /proc/$$.  
  read end_s end_ns <<< $(date +"%s %N" | sed 's/N$/0/')
  end_ns="${end_ns##+(0)}"
  local s=$((end_s - begin_s))
  local ms
  if [ "$end_ns" -ge "$begin_ns" ]
  then
    ms=$(((end_ns - begin_ns) / 1000000))
  else
    s=$((s - 1))
    ms=$(((1000000000 + end_ns - begin_ns) / 1000000))
  fi
  elapsed="$(printf " %u.%03u" $s $ms)"
  if [ "$s" -ge 300 ]
  then
    elapsed="$elapsed [$(human_time $s)]"
  fi
  echo $elapsed
}

export PROMPT_COMMAND=__prompt_command

function __prompt_command() {
  local EXIT="$?"

  if [ $EXIT != 0 ]; then
    STATUS="${Red}✘"
  else
    STATUS="${Green}✓"
  fi
  
  PS1=""
  PS1+=$STATUS" " # status code
  PS1+="$IBlack$(calc_elapsed) " # time
  PS1+="$IBlack$Time12h " # time
  PS1+="$BGreen[$BYellow\u$Red@$Green\h$BGreen]" # host
  PS1+="$BYellow\w" # working dir
  PS1+="$BBlue$(parse_git_branch)\n" # git branch
  PS1+="$BWhite$" # prompt
  PS1+="$Color_Off "
  history -a
  return 0
}

### exec before command

preexec () { 
  set_begin
}
preexec_invoke_exec () {
  [ -n "$COMP_LINE" ] && return  # do nothing if completing
  [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return # don't cause a preexec for $PROMPT_COMMAND
  local this_command=`history 1 | sed -e "s/^[ ]*[0-9]*[ ]*//g"`;
  preexec "$this_command"
}
trap 'preexec_invoke_exec' DEBUG

alias vim='vim -p'
alias vimu='vim -u ~/.vimrc-fast --noplugin'
export TERM=screen-256color

alias gdb_dump_stacks='gdb -ex "set pagination 0" -ex "thread apply all bt" --batch -p'
function tmux_detach_all() {
  for sess in `tmux ls | grep attached | sed -e 's/:.*//g'`; do tmux detach -s "$sess"; done
}
alias gam='git add -u && git commit --amend --no-edit'
alias gn='git show --name-only'

### disable Ctrl-S
stty stop ''
stty start ''
stty -ixon
stty -ixoff


if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

## machine specific stuff
if [ -f ~/.bash_profile_custom ]; then
  . ~/.bash_profile_custom
fi
