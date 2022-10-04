# syntax=docker/dockerfile:1
# Overjet Base Image for Python Testing and Cloud Build
#
# Use this Dockerfile to build a Python Image that uses `pyenv` and `direnv` to manage testing and
# deploying Python code for Cloud Functions in GCP.
#
# Overjet <info@overjet.ai>
#FROM python:3.8.13-slim
FROM python:3.9.13-slim-buster AS build-image


# Set Shell to bash
SHELL ["/bin/bash", "--login", "-c"]
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Set to non-interactive prompt for package installation (only during build)
ARG DEBIAN_FRONTEND="noninteractive"

# Set a fixed model cache directory.
ENV FVCORE_CACHE="/tmp"

# Allow statements and log messages to immediately appear in the Cloud Run logs













ENV PYTHONUNBUFFERED=TRUE

# Development packages, and setting python3 -> python
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    git \
    wget \
    libsm6 \
    libxext6 \
    libgtk2.0-dev \
    libgl1-mesa-glx \
    libgl1-mesa-dev \
    libprotobuf-dev \
    ninja-build \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && ln -sv /usr/bin/python3 /usr/bin/python

# Update pip
RUN pip install --upgrade pip

# Install poetry
ENV POETRY_HOME="/usr/local"
RUN curl -sSL https://install.python-poetry.org | python3 -

# Install Google Cloud SDK
RUN curl -sSL https://sdk.cloud.google.com | bash -
ENV PATH="/root/google-cloud-sdk/bin:$PATH"

# Create a non-root user
ARG USER_ID=1000
RUN useradd -m --no-log-init --system  --uid ${USER_ID} appuser

# Change owner to appuser
RUN chown --recursive appuser "/home/appuser"
# RUN chown --recursive appuser "/builder/home"

# Change user at end
# USER appuser

RUN python -m pip install --upgrade pip  \
    && python -m pip install cython \
    && python -m pip install pycocotools \
    && python -m pip install poetry
