eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

function proxy() {
    # 💡 代理端口
    local PROXY_PORT="7892"
    
    export http_proxy="http://127.0.0.1:${PROXY_PORT}"
    export https_proxy="http://127.0.0.1:${PROXY_PORT}"
    export HTTP_PROXY="http://127.0.0.1:${PROXY_PORT}"
    export HTTPS_PROXY="http://127.0.0.1:${PROXY_PORT}"
    
    export all_proxy="socks5://127.0.0.1:${PROXY_PORT}"
    export ALL_PROXY="socks5://127.0.0.1:${PROXY_PORT}"
    
    echo "终端代理【已开启】(Port: ${PROXY_PORT})"
}

function proxyoff() {
    unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY all_proxy ALL_PROXY
    echo "终端代理【已关闭】"
}

# alias
alias s-z="source ~/.zshrc"
alias l="ls -1"
alias la="ls -1aF"
alias h="cd ~"
alias cls="clear"
alias gs="git status"
alias glog="git log"
alias gdiff="git diff"
alias vsconf="code ~/.zshrc"

