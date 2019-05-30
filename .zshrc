export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

### PowerLevel9k configs:
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(kube_ps1 ssh context dir vcs status root_indicator)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(history time)
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY=Default
POWERLEVEL9K_DIR_SHOW_WRITABLE=true
ZSH_THEME="powerlevel9k/powerlevel9k"

### Zsh configs:
# ZSH_THEME="agnoster"
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# DISABLE_AUTO_UPDATE="true"
# DISABLE_UPDATE_PROMPT="true"
# export UPDATE_ZSH_DAYS=13
# DISABLE_MAGIC_FUNCTIONS=true
# DISABLE_LS_COLORS="true"
# DISABLE_AUTO_TITLE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
# plugins=(git debian docker kubectl npm vscode dircycle common-aliases)
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
# export LANG=en_US.UTF-8
# export ARCHFLAGS="-arch x86_64"
source $ZSH/oh-my-zsh.sh

### User configs:
EDITOR=nano
DEFAULT_USER=`whoami`

source /usr/local/bin/kube-ps1.sh
prompt_kube_ps1(){
   echo -n `kube_ps1`
}
KUBE_PS1_SYMBOL_COLOR=blue
KUBE_PS1_CTX_COLOR=red
KUBE_PS1_NS_COLOR=cyan
KUBE_PS1_BG_COLOR=null
KUBE_PS1_PREFIX=" "
KUBE_PS1_SEPARATOR=""
KUBE_PS1_SUFFIX=" "
KUBE_PS1_SYMBOL_USE_IMG=true
PROMPT='$(kube_ps1)'$PROMPT

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
source ~/.zsh.comp
source ~/.zsh.env
source ~/.zsh.aliases

### Antigen configs:
source /usr/share/zsh-antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
        sudo
        git
        debian
        docker
        fasd
        kubectl
        npm
        vscode
        dircycle
        common-aliases
        copyfile
        zdharma/fast-syntax-highlighting
        zsh-users/zsh-autosuggestions
        hlissner/zsh-autopair
        ael-code/zsh-colored-man-pages
        jonmosco/kube-ps1
EOBUNDLES
antigen theme romkatv/powerlevel10k
antigen apply