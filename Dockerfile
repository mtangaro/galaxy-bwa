FROM ubuntu:14.04

RUN apt-get -y update
RUN apt-get install -y make build-essential zlib1g-dev python

### install bwa
ADD https://github.com/lh3/bwa/archive/0.5.9.tar.gz /tmp/bwa.tar.gz
WORKDIR /tmp
RUN tar xvzf /tmp/bwa.tar.gz \
      && cd /tmp/bwa-0.5.9 \
      && make \
      && ln -s /tmp/bwa-0.5.9/bwa /usr/bin/

### get bwa wrapper
ADD https://raw.githubusercontent.com/galaxyproject/tools-devteam/master/legacy/bwa_wrappers/bwa_wrapper.py /usr/bin/bwa_wrapper.py
RUN chmod a+x /usr/bin/bwa_wrapper.py
