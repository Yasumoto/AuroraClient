#!/bin/bash

set -eux

tempfoo=`basename $0`
TEMPDIR=`/usr/bin/mktemp -d -t ${tempfoo}`

startup() {
  pushd ${TEMPDIR}
  mkdir -p ./out
  PATH=${TEMPDIR}/out/bin:${PATH}
}

build_bison () {
  curl -O http://ftp.gnu.org/gnu/bison/bison-3.0.tar.gz

  tar -xzvf ./bison-3.0.tar.gz

  pushd ./bison-3.0
    ./configure --prefix ${TEMPDIR}/out
    make
    make install
  popd
  YACC=${TEMPDIR}/out/bin/yacc
}

get_thrift() {
  pushd /Users/jsmith/Documents/thrift
  #./bootstrap.sh
  ./configure \
      --includedir /usr/local/opt/openssl/include \
      --with-openssl=/usr/local/opt/openssl \
      --with-php=no --with-php_extension=no \
      --with-dart=no --with-go=no \
      --with-perl=no
  make
  popd
}

copy_thrift_from_apache_aurora() {
    echo "To be curled"
}

generate_api() {
  ./out/bin/thrift \
      -v -debug \
      -o ../AuroraClient/AuroraClient/AuroraAPI \
      --gen swift \
      ../AuroraClient/AuroraClient/api.thrift
}

cleanup() {
  rm -rf ${TEMPDIR}
}

startup
build_bison
get_thrift
#cleanup