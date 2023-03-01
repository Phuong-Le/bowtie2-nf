FROM ubuntu:20.04 as app
LABEL maintainer='Phuong Le' 
LABEL maintainer.email='al35@sanger.ac.uk'

WORKDIR /opt

# install basic dependencies, cleanup apt garbage.
RUN apt-get update && apt-get install -y -qq \
        wget \
        zip \
        perl \ 
        zlib1g-dev \  
        libncurses5-dev \ 
        make \ 
        autoconf \
        build-essential \
        gcc \ 
        libbz2-dev \ 
        liblzma-dev \
    && apt-get autoclean && rm -rf /var/lib/apt/lists/*

# installing bowtie2
ARG BOWTIE2_VER=2.3.5
RUN wget -O bowtie2.zip https://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.3.5/bowtie2-2.3.5-linux-x86_64.zip/download \
    && unzip bowtie2.zip \
    && rm bowtie2.zip 
ENV PATH ${PATH}:/opt/bowtie2-2.3.5-linux-x86_64/


# installing samtools
ARG SAMTOOLS_VER=1.9
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 \
    && tar -vxjf samtools-1.9.tar.bz2 \
    && rm samtools-1.9.tar.bz2 \
    && cd samtools-1.9 \
    && ./configure \
    && make \
    && make install
