FROM docker.io/library/ubuntu:latest

WORKDIR /opt

# Install useful packages
RUN apt-get -y update && \
    apt-get -y install wget vim emacs tmux screen openssh-client && \
    rm -rf /var/lib/apt/lists/*

# Download miniconda installer, perform the installation and remove it
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x /opt/Miniconda3-latest-Linux-x86_64.sh && \
    /opt/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/anaconda && \
    rm /opt/Miniconda3-latest-Linux-x86_64.sh

RUN . /opt/anaconda/etc/profile.d/conda.sh && conda update -c conda-forge conda
RUN . /opt/anaconda/etc/profile.d/conda.sh && conda install -n base conda-libmamba-solver && conda config --set solver libmamba
RUN . /opt/anaconda/etc/profile.d/conda.sh && conda install mpi=1.0=mpich mpich=3.3 mpi4py --yes

# Copy and add the entrypoint script
ADD entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT ["/opt/entrypoint.sh"]