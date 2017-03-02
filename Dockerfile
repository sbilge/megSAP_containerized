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

# Install dependencies (curl added because of gosu)
RUN apt-get install -y --no-install-recommends \
	bzip2 \
	ca-certificates \
	cmake \
	curl \
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
  cd /megSAP && cp settings.ini.default settings.ini && \
	cd /megSAP/data && \
	/bin/bash download_tools.sh

# Configure mount points
RUN cd /megSAP/data && \
  mkdir -p /mnt/data/dbs /mnt/data/genomes && \
  mv dbs dbs_old && \
  mv genomes genomes_old && \
  ln -s /mnt/data/dbs && \
  ln -s /mnt/data/genomes

# Adding gosu 
# See https://denibertovic.com/posts/handling-permissions-with-docker-volumes/ 
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4

#Adding gosu to switch to the newly created user (see https://denibertovic.com/posts/handling-permissions-with-docker-volumes/)
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
        && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture).asc" \
        && gpg --verify /usr/local/bin/gosu.asc \
        && rm /usr/local/bin/gosu.asc \
        && chmod +x /usr/local/bin/gosu

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
