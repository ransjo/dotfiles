# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh
# ZSH_CUSTOM=/path/to/new-cusom-folder

ZSH_THEME="af-magic"

# CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git archlinux virtualenv npm fasd tmux history-substring-search zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.shpath

# Functions
mkcd() { mkdir $1; cd $1 }
swap() { mv $1 $1._tmp; mv $2 $1; mv $1._tmp $2; }

# checkout prev (older) revision
git_prev() {
    git checkout HEAD~
}

# checkout next (newer) commit
git_next() {
    BRANCH=`git show-ref | grep $(git show-ref -s -- HEAD) | sed 's|.*/\(.*\)|\1|' | grep -v HEAD | sort | uniq`
    HASH=`git rev-parse $BRANCH`
    PREV=`git rev-list --topo-order HEAD..$HASH | tail -1`
    git checkout $PREV
}

# mpv youtube functions
mm () { youtube-dl ytsearch:"$@" -q -f bestaudio --ignore-config --console-title --print-traffic --max-downloads 1 --no-call-home --no-playlist -o - | mpv --no-terminal --no-video --cache=256 -; }
yts () { youtube-dl ytsearch:"$@" -q -f bestaudio --ignore-config --console-title --print-traffic --max-downloads 1 --no-call-home --no-playlist -o - | mpv --cache=256 -; }
yt () { youtube-dl -q -f bestaudio --ignore-config --console-title --print-traffic --max-downloads 1 --no-call-home --no-playlist -o - | mpv --cache=256 -; }

# fasd (uses plugin instead)
# eval "$(fasd --init auto)"
