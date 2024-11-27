FROM ubuntu:24.04

# Atualiza pacotes e instala o vsftpd
RUN apt update && apt install -y vsftpd

# Define variáveis de ambiente para o usuário FTP
ARG FTP_USER=ftpuser
ARG FTP_PASS=ftp_password

# Cria o usuário FTP com diretório home
RUN useradd -m -d /home/$FTP_USER -s /usr/sbin/nologin $FTP_USER && \
    echo "$FTP_USER:$FTP_PASS" | chpasswd

# Cria o diretório FTP e ajusta permissões
RUN mkdir -p /home/$FTP_USER/ftp && \
    chmod 750 /home/$FTP_USER/ftp && \
    chown -R $FTP_USER:$FTP_USER /home/$FTP_USER/ftp

# Copia o arquivo de configuração do vsftpd
COPY vsftpd.conf /etc/vsftpd.conf

# Expõe as portas para o FTP
EXPOSE 21 21000-21010

# Inicia o servidor FTP
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
