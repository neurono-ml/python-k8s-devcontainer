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
   
RUN pip install poetry jupyter