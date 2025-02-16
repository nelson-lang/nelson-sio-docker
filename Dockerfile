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

FROM ubuntu:24.04
LABEL maintainer="Allan CORNET nelson.numerical.computation@gmail.com"

ARG NELSON_VERSION=1.8.0
ARG NELSON_VERSION_TAG=4314

RUN apt -q update;
RUN apt -y upgrade;

RUN apt-get install -y apt-transport-https ca-certificates gnupg software-properties-common wget ;
RUN apt-get install -y build-essential;
RUN apt-get install -y cmake;
RUN apt-get install -y libfftw3-single3;
RUN apt-get install -y libfftw3-double3;
RUN apt-get install -y libslicot0;
RUN apt-get install -y libopenblas0;
RUN apt-get install -y hdf5-tools;
RUN apt-get install -y libasound2t64;
RUN apt-get install -y libboost-chrono1.83.0;
RUN apt-get install -y libboost-filesystem1.83.0;
RUN apt-get install -y libboost-iostreams1.83.0;
RUN apt-get install -y libboost-locale1.83.0;
RUN apt-get install -y libboost-serialization1.83.0;
RUN apt-get install -y libboost-thread1.83.0;
RUN apt-get install -y libgit2-1.7;
RUN apt-get install -y libhdf5-103-1t64;
RUN apt-get install -y libjack-jackd2-0;
RUN apt-get install -y liblapacke;
RUN apt-get install -y libmatio11;
RUN apt-get install -y libopenblas0;
RUN apt-get install -y libopenmpi3t64;
RUN apt-get install -y libportaudio2;
RUN apt-get install -y libqt6core6;
RUN apt-get install -y libqt6gui6;
RUN apt-get install -y libqt6help6;
RUN apt-get install -y libqt6printsupport6;
RUN apt-get install -y libqt6qml6;
RUN apt-get install -y libqt6quick6;
RUN apt-get install -y libqt6svg6;
RUN apt-get install -y libqt6widgets6;
RUN apt-get install -y libsndfile1;
RUN apt-get install -y libtag1v5;
RUN apt-get install -y qt6-declarative-dev;
RUN apt-get install -y qt6-documentation-tools;
RUN apt-get install -y qml6-module-qtquick;
RUN apt-get install -y qml6-module-qtquick-templates;
RUN apt-get install -y qml6-module-qtquick-controls;
RUN apt-get install -y qml6-module-qtquick-window;
RUN apt-get install -y qml6-module-qtquick-dialogs;
RUN apt-get install -y qml6-module-qtqml-workerscript;   
RUN apt-get install -y qml6-module-qtquick-layouts;
RUN apt-get install -y libtbb12;
RUN apt-get install -y python3;
RUN apt-get install -y python3-numpy;

RUN wget https://github.com/nelson-lang/nelson/releases/download/v${NELSON_VERSION}/nelson-Ubuntu-24.04-x86_64-v${NELSON_VERSION}.${NELSON_VERSION_TAG}.deb && \
    apt install -y ./nelson-Ubuntu-24.04-x86_64-v${NELSON_VERSION}.${NELSON_VERSION_TAG}.deb && \
    rm nelson-Ubuntu-24.04-x86_64-v${NELSON_VERSION}.${NELSON_VERSION_TAG}.deb

RUN rm -rf /var/lib/apt/lists/*

WORKDIR "/nelson"

RUN mkdir /home/nelsonuser

RUN useradd -m nelsonuser
RUN chown -R nelsonuser:nelsonuser /home/nelsonuser
RUN chown -R nelsonuser:nelsonuser /nelson

USER nelsonuser

WORKDIR /home/nelsonuser

ENV AUDIODEV null
ENTRYPOINT ["nelson-sio-cli"]
