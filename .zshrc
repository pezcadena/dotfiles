export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# Codigo insertado manualmente por PEZCADENA:
if [[ "$(uname)" == "Darwin" ]]; then
  # macOS
  eval "$(/opt/homebrew/bin/brew shellenv)"
  BREW_BIN="/opt/homebrew/bin"
  # Se invoca a ohmyposh
  eval "$(oh-my-posh init zsh --config ~/dev/oh-my-posh-themes/.mytheme.omp.json)"
elif [[ "$(uname)" == "Linux" ]]; then
  # WSL o Linux con Homebrew instalado en ruta Linuxbrew
  export PATH=$PATH:/home/pezcadena/.local/bin
  # Mas path de homebrew
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
  # Se pone la dirección en una costante donde se ubican las cosas instaladas por homebrew
  BREW_BIN="/home/linuxbrew/.linuxbrew/bin"
  # Se invoca a ohmyposh
  eval "$(oh-my-posh init zsh --config ~/oh-my-posh-themes/.mytheme.omp.json)"
fi


# Aliases
alias zshconfig="nvim ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"
alias winexp='cd /mnt/c/Users/xxher/'
alias start-docker="sudo systemctl start docker.socket docker.service"
alias config="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
# PLUGGINS
eval "$($BREW_BIN/brew shellenv)"
eval "$(zoxide init zsh)"
# CARAPACE
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

source $(dirname $BREW_BIN)/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source $(dirname $BREW_BIN)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(dirname $BREW_BIN)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
plugins=(command-not-found)

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_DEFAULT_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exlude .git"

# TEMUX
WM_VAR="/$TMUX"
WM_CMD="tmux"
function start_if_needed() {
    if [[ $- == *i* ]] && [[ -z "${WM_VAR#/}" ]] && [[ -t 1 ]]; then
        exec $WM_CMD
    fi
}
start_if_needed

# GIT
function config_add_nvim() {
  echo "Untracked en .config/nvim:"
  config ls-files -o --exclude-standard .config/nvim
  echo "¿Los agrego? (y/N)"
  read -r yn
  if [ "$yn" = "y" ]; then
    config ls-files -z -o --exclude-standard .config/nvim \
      | xargs -0 -r git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add
  fi
}

# Load Angular CLI autocompletion.
#source <(ng completion script)
