FROM ubuntu:24.04

# Atualiza os pacotes do sistema
RUN apt update && apt upgrade -y

# Instala o servidor FTP (vsftpd)
RUN apt install -y vsftpd

# Copia o arquivo de configuração do FTP (você pode personalizá-lo)
COPY vsftpd.conf /etc/vsftpd.conf

# Cria um diretório para os arquivos FTP e define permissões
RUN mkdir -p /home/ftpuser/ftp && \
    chmod 750 /home/ftpuser/ftp && \
    chown -R ftpuser:ftpuser /home/ftpuser/ftp

# Adiciona um usuário FTP
RUN useradd -m -d /home/ftpuser ftpuser && \
    echo "ftpuser:ftp_password" | chpasswd

# Expõe a porta padrão do FTP (21)
EXPOSE 21

# Inicia o servidor FTP
CMD ["/usr/sbin/vsftpd", "/etc/vsftpd.conf"]
