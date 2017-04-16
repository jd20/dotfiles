#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "../ubuntu/utils.sh"

declare -r CUDA_PKG="/tmp/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64.deb"
declare -r CUDA_URL="https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb"
declare -r CUDNN_TARBALL="/tmp/cudnn-8.0-linux-x64-v5.1.tgz"
declare -r CUDNN_URL="https://www.dropbox.com/s/jvw90813gmcff4y/cudnn-8.0-linux-x64-v5.1.tgz?dl=1"

download_cuda() {
    wget -qO $CUDA_PKG $CUDA_URL
}

install_cuda() {
    sudo dpkg -i $CUDA_PKG
    sudo apt-get update
    sudo apt-get install cuda
}

download_cudnn() {
    wget -qO $CUDNN_TARBALL $CUDNN_URL
}

install_cudnn() {
    tar -C /tmp -zxf $CUDNN_TARBALL
    cd /tmp/cuda
    sudo cp -P /tmp/cuda/include/cudnn.h /usr/include
    sudo cp -P /tmp/cuda/lib64/libcudnn* /usr/lib/x86_64-linux-gnu/
    sudo chmod a+r /usr/lib/x86_64-linux-gnu/libcudnn*
}

if nvidia_gpu_present; then

    execute "download_cuda" "Download CUDA Toolkit 8.0"
    execute "install_cuda" "Install CUDA Tookit 8.0"
    execute "download_cudnn" "Download cuDNN 5.1"
    execute "install_cudnn" "Install cuDNN 5.1"
    install_package "NVIDIA CUDA Profile Tools Interface" "libcupti-dev"

else

    print_success "nVidia graphics card not detected"

fi
