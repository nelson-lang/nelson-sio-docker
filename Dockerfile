#==============================================================================
# Copyright (c) 2016-present Allan CORNET (Nelson)
#==============================================================================
# This file is part of the Nelson.
#=============================================================================
# LICENCE_BLOCK_BEGIN
# SPDX-License-Identifier: LGPL-3.0-or-later
# LICENCE_BLOCK_END
#==============================================================================

FROM debian:bullseye-slim
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
RUN apt-get install -y libeigen3-dev;
RUN apt-get install -y qtbase5-dev;
RUN apt-get install -y qtdeclarative5-dev;
RUN apt-get install -y libqt5webkit5-dev;
RUN apt-get install -y qtbase5-private-dev;
RUN apt-get install -y qtdeclarative5-dev;
RUN apt-get install -y qml-module-qtquick-controls;
RUN apt-get install -y qml-module-qtquick-dialogs;
RUN apt-get install -y qttools5-dev;
RUN apt-get install -y qttools5-dev-tools;
RUN apt-get install -y libqt5opengl5-dev;
RUN apt-get install -y libqt5help5;


RUN rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Nelson-numerical-software/nelson.git
WORKDIR "/nelson"
RUN cd "/nelson" && git checkout v0.6.4

RUN mkdir /home/nelsonuser

RUN groupadd -g 999 nelsonuser && \
    useradd -r -u 999 -g nelsonuser nelsonuser

RUN chown -R nelsonuser:nelsonuser /home/nelsonuser

RUN chown -R nelsonuser:nelsonuser /nelson

USER nelsonuser

ENV AUDIODEV null

RUN cmake -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles" .
RUN cmake --build . -- -j $(nproc)
RUN cmake --build . -- get_module_skeleton

RUN cmake --build . -- buildhelp
RUN cmake --build . -- tests_minimal

RUN xvfb-run -a /nelson/bin/linux/nelson -adv-cli -e "doc;exit"

ENTRYPOINT ["/nelson/bin/linux/nelson-sio-cli"]
