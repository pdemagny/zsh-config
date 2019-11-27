#zmodload zsh/zprof
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

### PowerLevel9k configs:
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(kube_ps1 aws os_icon ssh context dir vcs status root_indicator)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_STRATEGY=Default
POWERLEVEL9K_DIR_SHOW_WRITABLE=true
ZSH_THEME="powerlevel9k/powerlevel9k"

### Zsh configs:
HIST_STAMPS="mm/dd/yyyy"
source $ZSH/oh-my-zsh.sh

### User configs:
EDITOR=nano
DEFAULT_USER=`whoami`

source $HOME/.antigen/bundles/jonmosco/kube-ps1/kube-ps1.sh
prompt_kube_ps1() { echo -n $(kube_ps1); }
get_cluster_short() { if [[ "$1" =~ ^arn:aws:eks ]]; then echo "$1" | rev | cut -d'/' -f 1 | rev; fi; }
KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short
KUBE_PS1_SYMBOL_COLOR=white
KUBE_PS1_CTX_COLOR=red
KUBE_PS1_NS_COLOR=cyan
KUBE_PS1_BG_COLOR=null
KUBE_PS1_PREFIX=" "
KUBE_PS1_SEPARATOR=""
KUBE_PS1_SUFFIX=" "
KUBE_PS1_SYMBOL_USE_IMG=true
PROMPT='$(kube_ps1)'$PROMPT
PROMPT_EOL_MARK=''

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

source $HOME/.zsh.env

### Antigen configs:
source /usr/share/zsh-antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
        sudo
        git
        debian
        docker
        docker-compose
        fasd
        fzf
        asdf
        kubectl
        helm
        aws
        npm
        dircycle
        common-aliases
        copyfile
        zdharma/fast-syntax-highlighting
        zsh-users/zsh-autosuggestions
        hlissner/zsh-autopair
        ael-code/zsh-colored-man-pages
        jonmosco/kube-ps1
        akarzim/zsh-docker-aliases
EOBUNDLES

#antigen theme romkatv/powerlevel10k
antigen apply

source $HOME/.zsh.comp
source $HOME/.zsh.aliases

export HISTSIZE=100000
export SAVEHIST=100000

### Utility functions
join_array() { local IFS="$1"; shift; echo "$*"; }

### 
ecrlogin() { asp ekssm && $(aws ecr get-login --no-include-email); }
ekstoken() {
    TOKEN_SECRET_NAME="$(kubectl --context arn:aws:eks:eu-west-1:775527458845:cluster/${1}-cluster -n kube-system get secret | grep admin-user-token | awk '{print $1}')"
    kubectl --context "arn:aws:eks:eu-west-1:775527458845:cluster/${1}-cluster" -n kube-system get secret "${TOKEN_SECRET_NAME}" -o jsonpath='{.data.token}' | base64 -d | clipcopy
}
eksdash() {
    kubectl --context "arn:aws:eks:eu-west-1:775527458845:cluster/${1}-cluster" proxy --port="${2}" 1>/dev/null 2>&1 &
    sensible-browser "http://localhost:${2}/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/\#/login" >/dev/null
    ekstoken "${1}"
}
ekskov() {
    unset -v CLUSTERS PROXY_PORT
    counter=1
    for cluster in "${@}"; do
        PROXY_PORT="800${counter}"
        kubectl --context "arn:aws:eks:eu-west-1:775527458845:cluster/${cluster}-cluster" proxy --port="${PROXY_PORT}" 1>/dev/null 2>&1 &
        CLUSTERS+=( "http://localhost:${PROXY_PORT}" )
        ((counter++))
        sleep 1
    done
    docker run -it -d --net=host hjacobs/kube-ops-view --clusters "$(join_array "," "${CLUSTERS[@]}")" 1>/dev/null 2>&1
    sleep 5
    sensible-browser "http://localhost:8080" 1>/dev/null 2>&1
}
#ozprof

[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh