#!/bin/bash
yum group install 'Development Tools' -y
yum install fuse-devel -y
git clone https://github.com/relan/exfat.git;cd exfat
autoreconf --install
./configure --prefix=/usr
Make
make install
