FROM debian
RUN apt-get -y update && apt-get -y install \
  autoconf \
  automake \
  bzip2 \
  g++ \
  gcc \
  git \
  libatlas3-base \
  libtool \
  make \
  patch \
  python \
  python3 \
  python3-pip \
  subversion \
  unzip \
  wget \
  zlib1g-dev
RUN \
  wget https://github.com/kaldi-asr/kaldi/archive/master.zip -O kaldi.zip && \
  unzip kaldi.zip && \
  rm -f kaldi.zip && \
  mv kaldi-master kaldi
RUN \
  ln -sf bash /bin/sh && \
  cd kaldi/tools && \
  make -j16
RUN \
  cd kaldi/src && \
  ./configure --shared && \
  make depend -j16 && \
  make -j16
RUN \
  wget https://github.com/MontrealCorpusTools/Montreal-Forced-Aligner/archive/v0.8.1.zip -O mfa.zip && \
  unzip mfa.zip && \
  rm -f mfa.zip && \
  mv Montreal-Forced-Aligner-0.8.1 mfa
RUN \
  cd mfa && \
  python3 thirdparty/kaldibinaries.py /kaldi && \
  pip3 install -r requirements.txt && \
  freezing/freeze.sh
