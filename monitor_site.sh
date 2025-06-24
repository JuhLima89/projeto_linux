#!/bin/bash

# Configurações
URL="http://localhost"
LOGFILE="/var/log/site_status.log"
WEBHOOK_URL="https://"  #Adicionar URL do Webhook
STATUS_FILE="/tmp/site_status_last"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
HTTP_STATUS=$(curl -k -s -o /dev/null -w "%{http_code}" "$URL")
STATUS_ANTERIOR=$(cat "$STATUS_FILE" 2>/dev/null || echo "desconhecido")

# Garante que o nginx será iniciado automaticamente no boot
sudo systemctl enable nginx &>/dev/null

if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "[$TIMESTAMP] Site $URL está online (HTTP $HTTP_STATUS)." >> "$LOGFILE"
    echo "online" > "$STATUS_FILE"
else
    MSG="[$TIMESTAMP] ⚠️ ALERTA: Site $URL está FORA DO AR (HTTP $HTTP_STATUS)."
    echo "$MSG" >> "$LOGFILE"

    if [ "$STATUS_ANTERIOR" != "offline" ]; then
        curl -H "Content-Type: application/json" \
             -X POST \
             -d "{\"content\": \"$MSG\"}" \
             "$WEBHOOK_URL"

    fi

    echo "offline" > "$STATUS_FILE"

    # Tenta reiniciar o nginx
    echo "[$TIMESTAMP] Tentando reiniciar o Nginx..." >> "$LOGFILE"
    sudo systemctl restart nginx

    if systemctl is-active --quiet nginx; then
        echo "[$TIMESTAMP] Nginx reiniciado com sucesso." >> "$LOGFILE"
    else
        echo "[$TIMESTAMP] Falha ao reiniciar o Nginx." >> "$LOGFILE"

    fi
fi
