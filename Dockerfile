ARG PYTORCH="2.1.2"
ARG CUDA="11.8"
ARG CUDNN="8"

FROM pytorch/pytorch:${PYTORCH}-cuda${CUDA}-cudnn${CUDNN}-devel

ENV TORCH_CUDA_ARCH_LIST="6.0 6.1 7.0+PTX"
ENV TORCH_NVCC_FLAGS="-Xfatbin -compress-all"
ENV CMAKE_PREFIX_PATH="$(dirname $(which conda))/../"
ENV DEBIAN_FRONTEND noninteractive

# COPY ./cuda-keyring_1.0-1_all.deb cuda-keyring_1.0-1_all.deb
# RUN rm /etc/apt/sources.list.d/cuda.list \
#     && rm /etc/apt/sources.list.d/nvidia-ml.list \
#     && dpkg -i cuda-keyring_1.0-1_all.deb

RUN apt-get update && apt-get install -y vim git ninja-build libglib2.0-0 libsm6 libgl1-mesa-dev libxrender-dev libxext6 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install mmdetection
#RUN git clone https://github.com/open-mmlab/mmdetection.git /mmdetection
WORKDIR /crowddet
ADD . .
RUN pip install --default-timeout=1800 -r requirements.txt --ignore-installed