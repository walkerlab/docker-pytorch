ARG UBUNTU_VER
ARG CUDA_VER
ARG PYTORCH_EXTRA_IDX_URL

FROM nvidia/cuda:${CUDA_VER}-devel-ubuntu${UBUNTU_VER}
LABEL maintainer="Edgar Y. Walker <eywalker@uw.edu>"

# Deal with pesky Python 3 encoding issue
ENV LANG C.UTF-8

# Prevent Debian/Ubuntu from asking questions
ENV DEBIAN_FRONTEND noninteractive

# Install essential Ubuntu packages
# and upgrade pip
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update && \
    apt-get install -y build-essential && \
    apt-get install -y software-properties-common \
    build-essential \
    git \
    wget \
    vim \
    curl \
    zip \
    zlib1g-dev \
    unzip \
    pkg-config \
    libgl-dev \
    libblas-dev \
    liblapack-dev \
    python3-tk \
    python3-wheel \
    python3-pip \
    graphviz \
    libhdf5-dev \
    swig \
    apt-transport-https \
    lsb-release \
    ca-certificates &&\
    apt-get clean &&\
    # best practice to keep the Docker image lean
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install essential Python packages
RUN pip3 --no-cache-dir install \
    numpy \
    matplotlib \
    scipy \
    pandas \
    jupyter \
    jupyterlab \
    scikit-learn \
    scikit-image \
    seaborn \
    graphviz \
    h5py \
    gitpython \
    Pillow \
    datajoint

# Install PyTorch
RUN pip3 --no-cache-dir install torch torchvision torchaudio $([ -z "$PYTORCH_EXTRA_IDX_URL" ] && echo "" || echo "--extra-index-url $PYTORCH_EXTRA_IDX_URL")

# Export port for Jupyter Notebook
EXPOSE 8888

# Add Jupyter Notebook config
ADD ./jupyter_notebook_config.py /root/.jupyter/

WORKDIR /notebooks

# By default start running jupyter notebook
ENTRYPOINT ["jupyter", "lab", "--allow-root"]