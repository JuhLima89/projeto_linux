# DesafioLinux - Monitoramento de Site com Nginx e Notificação no Discord

Este projeto tem como objetivo monitorar se um site está online, utilizando o servidor Nginx e um script automatizado que verifica a disponibilidade do site a cada minuto. Caso o site esteja fora do ar, uma notificação é enviada automaticamente para um canal no Discord via webhook.

## O que foi pedido:

- Instalação e configuração do Nginx
- Script de monitoramento (cron job a cada 1 minuto)
- Simulação de queda do site parando o sistema através do terminal
- Notificação automática para o Discord com webhook
- Manter um arquivo de Log com os testes

## Como fiz o meu desafio:

1. Instalei o nginx na minha máquina, que já é linux, para abrir um site local.

```bash

sudo apt update
sudo apt upgrade
sudo apt install nginx

```   

2. Fiz a edição do site alterando o arquivo index.nginx-debian.html através do vim

```bash

:/var/www/html$ vim index.nginx-debian.html

```

3. Fiz um script em Bash que verifica se o site está respondendo. Dentro desse script está também o pedido para cada verificação ser guardada no arquivo de Log.

* O scrip está na pasta ProjetoLinux no github, com o nome monitor_site.sh

4. Simulei a queda do site parando o sistema Nginx manualmente através do terminal.

```bash

sudo systemctl stop nginx

```
5. Caso o site esteja fora do ar (resposta diferente de 200), o script envia uma mensagem para o Discord via webhook.

* Por questões de segurança, deixei a URL do webhook vazia. Para funcionar o script, deve ser inserido uma URL válida do webhook.

```
WEBHOOK_URL="" ## Colocar URl do discord
```


