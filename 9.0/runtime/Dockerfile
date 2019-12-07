ARG IMAGE_PREFIX
ARG CUDA

FROM ${IMAGE_PREFIX}-cuda${CUDA}-base

# Install NVIDIA/CUDA runtime support based on:
# https://gitlab.com/nvidia/container-images/cuda/blob/master/dist/ubuntu16.04/9.0/runtime/Dockerfile

ENV NCCL_VERSION 2.4.8

RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-libraries-$CUDA_PKG_VERSION \
cuda-cublas-9-0=9.0.176.4-1 \
libnccl2=$NCCL_VERSION-1+cuda9.0 && \
    apt-mark hold libnccl2 && \
    rm -rf /var/lib/apt/lists/*
