FROM ubuntu:22.04
USER root

RUN apt update && \
    apt install -y --no-install-recommends wget \
        tar \
        ca-certificates \
        build-essential \
        cmake \
        catch2 \
        libboost-all-dev \
        libfreetype-dev \
        git

ARG RDKIT_VERSION="Release_2024_09_1"

RUN wget -nv "https://github.com/rdkit/rdkit/archive/refs/tags/${RDKIT_VERSION}.tar.gz" && \
        tar xvf "${RDKIT_VERSION}.tar.gz" && \
        rm "${RDKIT_VERSION}.tar.gz"

ENV RDBASE=/"rdkit-${RDKIT_VERSION}"
ENV LD_LIBRARY_PATH=/"rdkit-${RDKIT_VERSION}"/lib:/usr/include/boost
CMD ["/bin/bash"]

WORKDIR /"rdkit-${RDKIT_VERSION}"
RUN mkdir build

WORKDIR /"rdkit-${RDKIT_VERSION}"/build

RUN cmake -DRDK_BUILD_PYTHON_WRAPPERS=OFF ..
RUN make
RUN make install

WORKDIR /
RUN cp -r /"rdkit-${RDKIT_VERSION}" /tmp/
WORKDIR /tmp/"rdkit-${RDKIT_VERSION}"
RUN mv Code /tmp/ && \
    mv build /tmp/ && \
    rm -rf * && \
    mv /tmp/Code /tmp/"rdkit-${RDKIT_VERSION}"/ && \
    mv /tmp/build /tmp/"rdkit-${RDKIT_VERSION}"/
WORKDIR /tmp/"rdkit-${RDKIT_VERSION}"/build
RUN mv lib /tmp/"rdkit-${RDKIT_VERSION}"/ && \
    rm -rf * && \
    mv /tmp/"rdkit-${RDKIT_VERSION}"/lib /tmp/"rdkit-${RDKIT_VERSION}"/build/
WORKDIR /tmp
RUN tar czf "rdkit-${RDKIT_VERSION}_ubuntu_22_04.tar.gz" "rdkit-${RDKIT_VERSION}"
