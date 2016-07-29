#!/bin/bash
# create-ecartis-cgi-deb.sh
#
# Ver. 0.01 2016/07/29 
#
# How to build a Debian package:
#
# https://www.debian.org/doc/manuals/maint-guide/index.en.html
#--------------------------------------------------------------------------
#
# download the ecartis source with:
# "git clone https://github.com/d-graef/ecartis.git"
#
# invoke this script (./create-ecartis-cgi-deb.sh) to create a debian package
#

basedir="../../ecartis-cgi-deb/ecartis/"

#-------------------------------------
# create directory tree (Debian compliant)
#-------------------------------------

mkdir -p ${basedir}DEBIAN
mkdir -p ${basedir}var/lib/ecartis/lsg
mkdir -p ${basedir}usr/lib/ecartis/modules
mkdir -p ${basedir}usr/lib/cgi-bin
mkdir -p ${basedir}etc/ecartis/templates

#-------------------------------------
# copy files to the directory tree
#-------------------------------------

cp ecartis-cgi/control ${basedir}DEBIAN
cp ecartis-cgi/postinst ${basedir}DEBIAN
cp ../templates/*lsc ${basedir}etc/ecartis/templates
cp ../scripts/lsg2.cgi ${basedir}usr/lib/cgi-bin
cp ../src/build/lsg2.lpm ${basedir}usr/lib/ecartis/modules

#-------------------------------------
# create the Debian package
#-------------------------------------

cd ../../ecartis-cgi-deb
dpkg -b ecartis ecartis-cgi_1.0.2-0_amd64.deb

