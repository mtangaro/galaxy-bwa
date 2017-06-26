FROM ubuntu:16.04

MAINTAINER Marco-Antonio Tangaro <ma.tangaro@gmail.com>

RUN apt-get -y update
RUN apt-get install -y wget gzip zip bzip2 python git
RUN mkdir /usr/tools && cd /usr/tools
RUN mkdir /usr/tools/bin

### install conda
RUN wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
RUN echo "yes\nyes\n" > conda_inst_stdin.txt
RUN bash Miniconda2-latest-Linux-x86_64.sh < conda_inst_stdin.txt
RUN export PATH=/root/miniconda2/bin:$PATH
ENV PATH /root/miniconda2/bin:$PATH
RUN conda list
RUN conda config --add channels r
RUN conda config --add channels bioconda

### install bwa 0.5.9
RUN conda install bwa=0.5.9

### get bwa wrapper
RUN mkdir /tmp/bwa
WORKDIR /tmp/bwa

RUN git clone https://github.com/galaxyproject/tools-devteam.git bwa_deps
RUN cp bwa_deps/legacy/bwa_wrappers/bwa_wrapper.py /usr/bin/bwa_wrapper.py
RUN chmod a+x /usr/bin/bwa_wrapper.py

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
