FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y install git g++ cmake pkg-config flex bison python3 python3-pip ninja-build qt5-default && \
	pip3 install meson

RUN cd /root && \
	git clone --recurse-submodules --depth 1 https://github.com/rizinorg/rizin && \
	cd rizin && \
	meson build --prefix=/usr && \
	ninja -C build && \
	ninja -C build install

RUN git clone --recurse-submodules --depth 1 https://github.com/rizinorg/rz-ghidra && \
        cd rz-ghidra && \
        mkdir build && cd build && \
        cmake -DCMAKE_INSTALL_PREFIX=~/usr .. && \
        make && make install

RUN ls /usr/bin

