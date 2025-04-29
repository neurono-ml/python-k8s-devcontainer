FROM docker.io/3.12.10-slim-bookworm

ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=developer
ARG USER_UID=1001
ARG USER_GID=$USER_UID

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
	&& apt-get update \
	&& apt-get install -y sudo git build-essential libssl-dev \
	&& echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
	&& chmod 0440 /etc/sudoers.d/$USERNAME
   
RUN pip install poetry jupyter pyspark=3.4.0 "synapseml>=1.0.10,<2.0.0" "lightgbm>=4.6.0,<5.0.0" \
	"scikit-learn>=1.6.1,<2.0.0" "seaborn>=0.13.2,<0.14.0" \
	"matplotlib>=3.10.1,<4.0.0" "onnx>=1.17.0,<2.0.0" \
	"tensorflow=2.19.0" "keras=3.9.2"

RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
