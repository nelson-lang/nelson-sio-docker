#==============================================================================
# Copyright (c) 2016-2019 Allan CORNET (Nelson)
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

FROM debian:buster-slim
LABEL maintainer="Allan CORNET nelson.numerical.computation@gmail.com"

RUN apt-get update
RUN apt-get install -y build-essential;
RUN apt-get install -y autotools-dev;
RUN apt-get install -y libtool;
RUN apt-get install -y automake;
RUN apt-get install -y xvfb;
RUN apt-get install -y git;
RUN apt-get install -y libboost-all-dev;
RUN apt-get install -y libopenmpi-dev;
RUN apt-get install -y openmpi-bin;
RUN apt-get install -y gettext;
RUN apt-get install -y pkg-config;
RUN apt-get install -y cmake;
RUN apt-get install -y libffi-dev;
RUN apt-get install -y libicu-dev;
RUN apt-get install -y libxml2-dev;
RUN apt-get install -y liblapack-dev;
RUN apt-get install -y liblapacke-dev;
RUN apt-get install -y fftw3;
RUN apt-get install -y fftw3-dev;
RUN apt-get install -y libasound-dev;
RUN apt-get install -y portaudio19-dev;
RUN apt-get install -y libsndfile1-dev;
RUN apt-get install -y libtag1-dev;
RUN apt-get install -y alsa-utils;
RUN apt-get install -y libhdf5-dev;
RUN apt-get install -y hdf5-tools;
RUN apt-get install -y libmatio-dev;
RUN apt-get install -y libslicot0;
RUN apt-get install -y zlib1g-dev;
RUN apt-get install -y libcurl4-openssl-dev;
RUN apt-get install -y libgit2-dev;
RUN apt-get install -y qtbase5-dev;
RUN apt-get install -y qtdeclarative5-dev;
RUN apt-get install -y libqt5webkit5-dev;
RUN apt-get install -y qttools5-dev-tools;
RUN apt-get install -y qml-module-qtquick-controls;
RUN apt-get install -y qml-module-qtquick-dialogs;
RUN apt-get install -y libqt5opengl5-dev;
RUN apt-get install -y qtbase5-private-dev;
RUN apt-get install -y qtdeclarative5-dev;
RUN apt-get install -y libqt5help5;
RUN apt-get install -y qttools5-dev;
RUN apt-get install -y qttools5-dev-tools;

RUN rm -rf /var/lib/apt/lists/*

RUN git clone https://gitlab.com/libeigen/eigen.git /tmp/eigen
RUN mkdir /tmp/eigen-build && cd /tmp/eigen && git checkout 3.4 && cd - && cd /tmp/eigen-build && cmake . /tmp/eigen && make -j4 && make install;

RUN git clone https://github.com/Nelson-numerical-software/nelson.git /nelson
WORKDIR "/nelson"
RUN git checkout -b v0.6.4

ENV AUDIODEV null
ENV PATH="/usr/lib/x86_64-linux-gnu/qt5/bin/:${PATH}"

RUN cmake -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" .
RUN cmake --build . -- -j $(nproc)
RUN cmake --build . -- get_module_skeleton

RUN cmake --build . -- buildhelp
RUN cmake --build . -- tests_minimal

RUN xvfb-run -a /nelson/bin/linux/nelson -adv-cli -e "doc;exit"

ENTRYPOINT ["/nelson/bin/linux/nelson-sio-cli"]
