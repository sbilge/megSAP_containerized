# Test on automated build
# Changed ubuntu to ubuntu:xenial
# Base image
FROM ubuntu:xenial

# Set default shell
SHELL ["/bin/bash", "-c"]

# Init
USER root

# Update base image
RUN apt-get update && \
  apt-get upgrade -y

# Install dependencies
RUN apt-get install -y --no-install-recommends \
	bzip2 \
	ca-certificates \
	cmake \
	debconf-utils \
	g++ \
	libncurses5-dev \
	libqt5xmlpatterns5-dev \
	libqt5sql5-mysql \
	make \
	git \
	php \
	php7.0-xml \
	python \
	python-matplotlib \
	python-software-properties \
	qt5-default \
	software-properties-common \
	tabix \
	unzip \
	wget

# Install Java from custom repository
# Note that this auto-accepts the license terms
RUN add-apt-repository ppa:webupd8team/java && \
	apt-get update && \
	echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
	apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default

# Install and configure megSAP
RUN cd / && \
	git clone https://github.com/imgag/megSAP.git && \
  cd /megSAP && cp settings.ini.default settings.ini \
	cd /megSAP/data && \
	/bin/bash download_tools.sh
