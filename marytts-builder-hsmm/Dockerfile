FROM marytts-builder-hsmm-prep
ARG HTKUSER
ARG HTKPASSWORD
RUN wget http://$HTKUSER:$HTKPASSWORD@htk.eng.cam.ac.uk/ftp/software/HTK-3.4.1.tar.gz && \
  tar xvfz HTK-3.4.1.tar.gz && \
  rm -f HTK-3.4.1.tar.gz && \
  wget http://$HTKUSER:$HTKPASSWORD@htk.eng.cam.ac.uk/ftp/software/hdecode/HDecode-3.4.1.tar.gz && \
  tar xfvz HDecode-3.4.1.tar.gz && \
  rm -f HDecode-3.4.1.tar.gz
RUN cd htk && \
  patch -p1 -d . < ../hts/HTS-2.2_for_HTK-3.4.1.patch && \
  ./configure --prefix=/usr/local --disable-hslab && \
  make all && \
  make install
RUN PATH=/marytts/lib/external/ehmm/bin:$PATH && \
  marytts/lib/external/check_install_external_programs.sh -check || true
