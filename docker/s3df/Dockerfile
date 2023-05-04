FROM docker.io/ubuntu:18.04

WORKDIR /root

# Install useful packages
RUN apt-get -y update && \
    apt-get -y install wget vim emacs tmux screen openssh-client && \
    rm -rf /var/lib/apt/lists/*

# Download miniconda installer, perform the installation and remove it
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x /root/Miniconda3-latest-Linux-x86_64.sh && \
    /root/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/anaconda && \
    rm /root/Miniconda3-latest-Linux-x86_64.sh

# Copy and add the entrypoint script
ADD entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT ["/opt/entrypoint.sh"]