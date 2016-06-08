#!/bin/bash
# create-ecartis-deb.sh
#
# Ver. 0.01 2016/06/08 
#
# How to build a Debian package:
#
# https://www.debian.org/doc/manuals/maint-guide/index.en.html
#--------------------------------------------------------------------------
#
# download the ecartis source with:
# "git clone https://github.com/d-graef/ecartis.git"
#
# invoke this script (./create-ecartis-deb.sh) to create a debian package
#

basedir="../../ecartis-deb/ecartis/"

#-------------------------------------
# build ecartis binaries
#-------------------------------------

cd ../src
make -f Makefile.dist

#-------------------------------------
# create directory tree (Debian compliant)
#-------------------------------------

cd ../debian
mkdir -p ${basedir}DEBIAN
mkdir -p ${basedir}etc/ecartis
mkdir -p ${basedir}etc/logrotate.d
mkdir -p ${basedir}usr/lib/ecartis/modules
mkdir -p ${basedir}usr/share/doc/ecartis/examples
mkdir -p ${basedir}usr/share/man/man8
mkdir -p ${basedir}var/lib/ecartis/lists
mkdir -p ${basedir}var/lib/ecartis/queue

#-------------------------------------
# copy files to the directory tree
#-------------------------------------

gzip ecartis.8
cp ecartis.8.gz ${basedir}usr/share/man/man8
cp control ${basedir}DEBIAN
cp postinst ${basedir}DEBIAN
cp postrm ${basedir}DEBIAN
cp ../documentation/* ${basedir}usr/share/doc/ecartis
cp ../src/build/*lpm ${basedir}usr/lib/ecartis/modules
rm ${basedir}usr/lib/ecartis/modules/lsg2.lpm
cp ../src/build/ecartis ${basedir}usr/lib/ecartis
cp -rp ../lists ${basedir}var/lib/ecartis/lists
cp ecartis.logrotate ${basedir}etc/logrotate.d/ecartis
cp ../cfg/ecartis.cfg.dist  ${basedir}etc/ecartis/ecartis.cfg


#-------------------------------------
# create the Debian package
#-------------------------------------

cd ../../ecartis-deb
dpkg -b ecartis ecartis_1.0.2-0_amd64.deb



