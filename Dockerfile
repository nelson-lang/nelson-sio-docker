#==============================================================================
# Copyright (c) 2016-present Allan CORNET (Nelson)
#==============================================================================
# LICENCE_BLOCK_BEGIN
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# LICENCE_BLOCK_END
#==============================================================================

FROM ubuntu:22.04
LABEL maintainer="Allan CORNET nelson.numerical.computation@gmail.com"

RUN apt update;
RUN apt -y upgrade;
RUN apt -y install build-essential;
RUN apt -y install git;
RUN apt -y install cmake;
RUN apt -y install apt-transport-https ca-certificates gnupg software-properties-common wget ;
RUN apt -y install ninja-build;
RUN apt -y install ninja-build;
RUN apt -y install xvfb;
RUN apt -y install libopenmpi-dev;
RUN apt -y install autotools-dev;
RUN apt -y install libtool;
RUN apt -y install automake;
RUN apt -y install openmpi-bin;
RUN apt -y install gettext;
RUN apt -y install pkg-config;
RUN apt -y install libffi-dev;
RUN apt -y install libicu-dev;
RUN apt -y install libxml2-dev;
RUN apt -y install liblapack-dev;
RUN apt -y install liblapacke-dev;
RUN apt -y install fftw3;
RUN apt -y install fftw3-dev;
RUN apt -y install libasound-dev;
RUN apt -y install portaudio19-dev;
RUN apt -y install libsndfile1-dev;
RUN apt -y install libtag1-dev;
RUN apt -y install alsa-utils;
RUN apt -y install libslicot-dev;
RUN apt -y install libsqlite3-dev;
RUN apt -y install libgl-dev;
RUN apt -y install hdf5-tools;
RUN apt -y install zlib1g-dev;
RUN apt -y install libcurl4-openssl-dev;
RUN apt -y install libgit2-dev;
RUN apt -y install libboost-all-dev;
RUN apt -y install libeigen3-dev;
RUN apt -y install libhdf5-dev;
RUN apt -y install libmatio-dev;
RUN apt -y install qt6-base-dev;
RUN apt -y install libqt6svg6-dev;
RUN apt -y install qt6-declarative-dev;
RUN apt -y install qt6-documentation-tools;
RUN apt -y install qml6-module-qtquick;
RUN apt -y install qml6-module-qtquick-templates;
RUN apt -y install qml6-module-qtquick-controls;
RUN apt -y install qml6-module-qtquick-window;
RUN apt -y install qml6-module-qtquick-dialogs;
RUN apt -y install qml6-module-qtqml-workerscript;
RUN apt -y install qml6-module-qtquick-layouts;
RUN apt -y install assistant-qt6;
RUN apt -y install qt6-tools-dev;

RUN rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Nelson-numerical-software/nelson.git /nelson
WORKDIR "/nelson"
RUN git checkout -b v0.7.4

RUN mkdir /home/nelsonuser

RUN groupadd -g 999 nelsonuser && \
    useradd -r -u 999 -g nelsonuser nelsonuser

RUN chown -R nelsonuser:nelsonuser /home/nelsonuser
RUN chown -R nelsonuser:nelsonuser /nelson

USER nelsonuser

ENV AUDIODEV null

RUN cmake -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" . -DQTDIR="/usr/lib/qt6"
RUN cmake --build . -- -j $(nproc)
RUN cmake --build . -- -j $(nproc) get_module_skeleton

RUN cmake --build . -- -j $(nproc) buildhelp
RUN cmake --build . -- -j $(nproc) tests_minimal

RUN xvfb-run -a /nelson/bin/linux/nelson-adv-cli -e "doc;exit"

ENTRYPOINT ["/nelson/bin/linux/nelson-sio-cli"]
