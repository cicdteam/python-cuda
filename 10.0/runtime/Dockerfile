ARG IMAGE_PREFIX
ARG CUDA

FROM ${IMAGE_PREFIX}-cuda${CUDA}-base

# Install NVIDIA/CUDA runtime support based on:
# https://gitlab.com/nvidia/container-images/cuda/blob/master/dist/ubuntu18.04/10.0/runtime/Dockerfile

ENV NCCL_VERSION 2.4.8

RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-libraries-$CUDA_PKG_VERSION \
cuda-nvtx-$CUDA_PKG_VERSION \
libnccl2=$NCCL_VERSION-1+cuda10.0 && \
    apt-mark hold libnccl2 && \
    rm -rf /var/lib/apt/lists/*
