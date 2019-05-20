FROM ubuntu:14.04

RUN apt-get update

# samtools
# Usage: samtools [OPTIONS]
RUN apt-get install -y gcc
RUN apt-get install -y libncurses5-dev
RUN apt-get install -y libbz2-dev
RUN apt-get install -y liblzma-dev
RUN apt-get install -y libcurl4-openssl-dev
RUN apt-get install -y libssl-dev
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y make

ENV SW=/root/software
WORKDIR ${SW}

ENV samtools=samtools-1.5
ADD ${samtools}.tar.bz2 .
WORKDIR ${samtools}

RUN ./configure
RUN make
RUN make install
WORKDIR ${SW}

# Python 2.7
ADD get-pip.py .
RUN apt-get install -y python
RUN python get-pip.py
RUN rm get-pip.py

RUN pip install --upgrade pip
RUN pip install numpy
RUN pip install scipy
RUN pip install pysam

RUN apt-get install -y python-dev
RUN apt-get install -y build-essential
RUN pip install matplotlib

RUN apt-get install -y bedtools

RUN sudo apt-get install -y libblas-dev liblapack-dev
RUN sudo apt-get install -y libgsl0ldbl
RUN sudo apt-get install -y gfortran

#rmats2sashimiplot
ADD setup.py .
ADD README.rst .
ADD src/ ./src/
RUN echo $(ls -al .)
RUN python setup.py install
