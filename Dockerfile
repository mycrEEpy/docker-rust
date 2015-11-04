FROM centos:7
MAINTAINER Tobias Germer

# Environment variables
ENV RUST_USER=rust \
    RUST_HOME=/source \
    RUST_CHANNEL=stable

# Update CentOS
RUN yum update -y

# Add user to run Rust compiler and create folders
RUN useradd -m $RUST_USER && \
    mkdir $RUST_HOME

# Download and install Rust
RUN curl -sSf https://static.rust-lang.org/rustup.sh | sh -s -- --channel=$RUST_CHANNEL --yes

# Bypass union filesystem for source code
VOLUME $RUST_HOME

# Use Rust home as workdir
WORKDIR $RUST_HOME

# Set user for running Rust compiler
USER $RUST_USER

# Run in a bash
CMD /bin/bash
