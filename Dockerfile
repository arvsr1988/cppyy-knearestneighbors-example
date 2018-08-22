FROM teeks99/boost-cpp-docker:gcc-8

RUN apt-get install -y curl
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py 
RUN pip install cppyy

RUN apt-get install -y clang-6.0
RUN apt-get install -y libclang-6.0-dev
RUN apt-get install -y python-clang-6.0
RUN pip install cppyy-cling
RUN pip install cppyy-backend
RUN pip install CpyCppyy
RUN pip install cppyy

RUN apt-get install -y software-properties-common

RUN apt-get update

#install cmake
RUN apt remove cmake
RUN apt purge --auto-remove cmake
ENV version 3.12
ENV build 1
RUN mkdir ~/temp
RUN cd ~/temp
RUN wget https://cmake.org/files/v${version}/cmake-${version}.${build}.tar.gz
RUN tar -xzvf cmake-${version}.${build}.tar.gz
WORKDIR cmake-${version}.${build}/
RUN pwd
RUN ls
RUN ./bootstrap
RUN make -j4
RUN make install
RUN cmake --version

RUN apt-get install -y ninja-build

WORKDIR ../
RUN pwd
RUN ls
COPY ./src/ .
RUN pwd
RUN ls
RUN mkdir build
WORKDIR build
RUN pwd
RUN ls

RUN cmake -G Ninja ..
RUN cmake --build .

RUN python nn.py