ARG IMAGE_PREFIX
ARG CUDA

FROM ${IMAGE_PREFIX}-cuda${CUDA}-runtime

# Install NVIDIA/CUDA CUDNN7 support:
# https://gitlab.com/nvidia/container-images/cuda/blob/master/dist/ubuntu16.04/9.0/runtime/cudnn7/Dockerfile
# https://gitlab.com/nvidia/container-images/cuda/blob/master/dist/ubuntu18.04/10.0/runtime/cudnn7/Dockerfile

ENV CUDNN_VERSION 7.6.5.32
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    libcudnn7=$CUDNN_VERSION-1+cuda9.0 \
&& \
    apt-mark hold libcudnn7 && \
    rm -rf /var/lib/apt/lists/*

