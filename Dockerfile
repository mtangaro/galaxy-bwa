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

### install bwa wrapper
RUN wget https://raw.githubusercontent.com/galaxyproject/tools-devteam/master/legacy/bwa_wrappers/bwa_wrapper.py -O /usr/tools/bin/bwa_wrapper.py
RUN /bin/chmod +x /usr/tools/bin/bwa_wrapper.py
ENV PATH /usr/tools/bin:$PATH

WORKDIR /usr/tools

CMD ["bwa"]
