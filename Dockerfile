FROM centos:7
MAINTAINER Tobias Germer

# Environment variables
ENV RUST_USER=rust \
    RUST_HOME=/source \
    RUST_CHANNEL=stable

# Update CentOS and install gcc
RUN yum update -y && \
    yum install gcc.x86_64 -y

# Add user to run Rust compiler / create folders / change owner
RUN useradd -m $RUST_USER && \
    mkdir $RUST_HOME && \
    chown -R $RUST_USER:$RUST_USER $RUST_HOME

# Download and install Rust
RUN curl -sSf https://static.rust-lang.org/rustup.sh | sh -s -- --channel=$RUST_CHANNEL --yes --disable-sudo

# Bypass union filesystem for source code
VOLUME $RUST_HOME

# Use Rust home as workdir
WORKDIR $RUST_HOME

# Set user for running Rust compiler
USER $RUST_USER

# Run in a bash
CMD /bin/bash
