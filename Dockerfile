FROM ubuntu:20.04

WORKDIR /dust

# Set timezone ENV var
ENV TZ=US

# Setup timezone so that cmake install does not ask for user input
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install the dependencies available in apt
RUN apt update && apt install -y git gfortran libhdf5-serial-dev cmake libatlas-base-dev build-essential

# clone CGNS
RUN git clone -b v3.3.1 https://github.com/CGNS/CGNS.git

# Build CGNS
RUN cd CGNS && mkdir build install && cd build \
    && cmake -D CGNS_ENABLE_FORTRAN=ON -D CGNS_ENABLE_HDF5=ON -D CMAKE_INSTALL_PREFIX=../install ../ \
    && make \
    && make install \
    && cp -a /dust/CGNS/install/lib/. /usr/lib \
    && cp -a /dust/CGNS/install/include/. /usr/include

# Clone dust source code
RUN git clone -b 0.5.16-b https://gitlab.com/dust_group/dust.git

# Build dust
RUN cd dust && mkdir build && cd build && cmake ../ && make

COPY ./run.sh /

RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]