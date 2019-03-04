FROM nvcr.io/nvidia/pytorch:19.01-py3

# RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh && bash /tmp/miniconda.sh
RUN apt-get update && apt-get install -y tar unzip
RUN wget http://www.statmt.org/moses/RELEASE-4.0/binaries/ubuntu-16.04.tgz -O /tmp/moses.tgz && tar -xvf /tmp/moses.tgz -C  /bin/
RUN export MOSES_PATH=/bin/ubuntu-16.04.tgz
#RUN wget http://github.com/glample/fastBPE/archive/master.zip -d /tmp/


COPY . /app/
WORKDIR /app/

RUN ./NMT/get_data_enfr.sh
