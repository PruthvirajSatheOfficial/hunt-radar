#!/bin/bash
# --- 1. THE INSTALLER ---
install_tools() {
    echo "[+] Initializing Manual Hunter Environment..."
    sudo apt update && sudo apt install -y golang jq
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
    go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
    go install -v github.com/lc/gau/v2/cmd/gau@latest
    go install -v github.com/tomnomnom/anew@latest
}
if ! command -v subfinder &> /dev/null; then install_tools; fi
# --- 2. TARGETS ---
TARGETS=("hey.com" "binance.com")
for domain in "${TARGETS[@]}"; do
    echo "[*] TARGET ACQUIRED: $domain"
    mkdir -p "$domain"
    subfinder -d $domain -silent | anew "$domain/subs.txt"
    cat "$domain/subs.txt" | httpx -silent -sc -td -title -follow-redirects -o "$domain/live.txt"
done
