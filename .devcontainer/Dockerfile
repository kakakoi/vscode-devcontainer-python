ARG VARIANT="3.9-bullseye"
FROM --platform=linux/arm64 mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}

ENV PYTHONDONTWRITEBYTECODE 1

# [Choice] Node.js version: none, lts/*, 16, 14, 12, 10
ARG NODE_VERSION="lts/*"
RUN if [ "${NODE_VERSION}" != "none" ]; then su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/opt/poetry python3 - && \
    cd /usr/local/bin && \
    ln -s /opt/poetry/bin/poetry && \
    poetry config virtualenvs.create true

RUN cd /usr/local && \
    curl -L https://dl.dagger.io/dagger/install.sh | sh

# aws cli
RUN apt-get update && apt-get install -y less vim curl unzip sudo htop
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install

# copilot cli
RUN curl -Lo copilot "https://github.com/aws/copilot-cli/releases/latest/download/copilot-linux"
RUN chmod +x copilot
RUN sudo mv copilot /usr/local/bin/copilot
RUN copilot --help

ARG USERNAME=vscode
RUN SNIPPET="export PROMPT_COMMAND='history -a' && export HISTFILE=/commandhistory/.bash_history" \
    && mkdir /commandhistory \
    && touch /commandhistory/.bash_history \
    && chown -R $USERNAME /commandhistory \
    && echo $SNIPPET >> "/home/$USERNAME/.bashrc"

# ARG HOME=/home/vscode
COPY ./.aws /home/vscode/.aws

WORKDIR /workspace
