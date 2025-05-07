# Monitoramento de Disponibilidade de Site com Nginx e Notificação no Discord

Este é um script Bash que monitora a disponibilidade de um site e envia alertas no Discord em caso de falha. O script realiza verificações a cada minuto, reinicia o Nginx automaticamente se o site ficar fora do ar, e registra eventos em um arquivo de log.

## Funcionalidades

- Monitora a disponibilidade de um site.
- Envia uma notificação no Discord se o site estiver fora do ar.
- Reinicia automaticamente o servidor Nginx se o site ficar offline.
- Registra os eventos no arquivo de log (`/var/log/site_status.log`).
- Garante que o Nginx seja iniciado automaticamente no boot.

## Requisitos

- Sistema operacional baseado em Linux.
- Nginx instalado e configurado.
- Acesso ao terminal com permissões de `sudo`.
- Uma URL de Webhook do Discord para envio das notificações.
- `curl` instalado para realizar as requisições HTTP.

## Como Usar

1. Clone este repositório ou baixe o script para o seu servidor.

2. Faça o script ser executável:
    ```bash
    chmod +x monitor_site.sh
    ```

3. Configure a URL do site que deseja monitorar:
    - Abra o arquivo `monitor_site.sh` e edite a variável `URL` com o endereço do site que você quer monitorar.

4. Configure o Webhook do Discord:
    - Substitua a URL do webhook do Discord na variável `WEBHOOK_URL` com seu link de Webhook.

5. Execute o script:
    ```bash
    ./monitor_site.sh
    ```

6. Para rodar o script automaticamente em segundo plano, você pode configurar um cron job ou usar um serviço systemd.

## Explicação do Script

- **Verificação de Status HTTP**: O script usa o `curl` para verificar o status HTTP do site configurado. Se o site responder com um status HTTP 200 (OK), ele registra a resposta no log como "online". Caso contrário, o script envia uma mensagem de alerta ao Discord e tenta reiniciar o serviço Nginx.
  
- **Log de Atividades**: Todas as verificações e ações (como tentativas de reinício do Nginx) são registradas no arquivo de log localizado em `/var/log/site_status.log`.

- **Reinício do Nginx**: Caso o site esteja offline, o script tenta reiniciar o Nginx automaticamente e registra o sucesso ou falha dessa operação.

- **Notificação no Discord**: Quando o site está fora do ar, o script envia uma notificação para o canal configurado no Discord.

## Configuração do Nginx

Certifique-se de que o Nginx esteja configurado corretamente e com a opção de inicialização automática no boot:

```bash
sudo systemctl enable nginx



