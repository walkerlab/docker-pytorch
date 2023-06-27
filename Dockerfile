# Image Args
ARG UBUNTU_VER

FROM ghcr.io/walkerlab/docker-data-science-essentials:ubuntu${UBUNTU_VER}
ARG TORCH_VER
ARG TORCHVISION_VER
ARG TORCHAUDIO_VER
ARG PYTORCH_EXTRA_IDX_URL

LABEL maintainer="Edgar Y. Walker <eywalker@uw.edu>, Daniel Sitonic <sitonic@uw.edu>"

# Install PyTorch
RUN pip3 --no-cache-dir install torch==$TORCH_VER torchvision==$TORCHVISION_VER torchaudio==$TORCHAUDIO_VER --extra-index-url https://download.pytorch.org/whl/cpu