#!/bin/bash
# --- 2. TARGETS ---
TARGETS=("hey.com" "binance.com")
for domain in "${TARGETS[@]}"; do
    echo "[*] TARGET ACQUIRED: $domain"
    mkdir -p "$domain"
    subfinder -d $domain -silent | anew "$domain/subs.txt"
    cat "$domain/subs.txt" | httpx -silent -sc -td -title -follow-redirects -o "$domain/live.txt"
done
