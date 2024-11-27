FROM ubuntu:24.04

# Atualiza pacotes e instala o vsftpd
RUN apt update && apt install -y vsftpd

# Copia o arquivo de configuração do FTP para o container
COPY vsftpd.conf /etc/vsftpd.conf

# Cria o diretório para o usuário FTP e ajusta permissões
RUN mkdir -p /home/ftpuser/ftp && \
    chmod 750 /home/ftpuser/ftp && \
    chown -R ftpuser:ftpuser /home/ftpuser/ftp

# Adiciona um usuário FTP usando variáveis de ambiente
ARG FTP_USER=ftpuser
ARG FTP_PASS=ftp_password
RUN useradd -m -d /home/ftpuser ftpuser && \
    echo "$FTP_USER:$FTP_PASS" | chpasswd

# Expõe a porta padrão do FTP (21) e a faixa para modo passivo
EXPOSE 21 21000-21010

# Comando para iniciar o servidor FTP
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
