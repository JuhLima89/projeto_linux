#!/bin/bash

# Configurações
URL="http://192.168.1.162"  # Seu IP ou URL
LOGFILE="site_status.log"
WEBHOOK_URL="" # Colocar URl do discord

while true; do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    # Verifica status HTTP
    HTTP_STATUS=$(curl -k -s -o /dev/null -w "%{http_code}" "$URL")

    if [ "$HTTP_STATUS" -eq 200 ]; then
        echo "[$TIMESTAMP] Site $URL está online (HTTP $HTTP_STATUS)." | tee -a "$LOGFILE"
    else
        MSG="[$TIMESTAMP] ⚠️ ALERTA: Site $URL está FORA DO AR (HTTP $HTTP_STATUS)."
        echo "$MSG" | tee -a "$LOGFILE"

        # Envia notificação para Discord
        curl -H "Content-Type: application/json" \
             -X POST \
             -d "{\"content\": \"$MSG\"}" \
             "$WEBHOOK_URL"
    fi

    sleep 60
done
