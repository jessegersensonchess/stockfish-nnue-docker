# BUILD
# docker build -t stockfish:latest -f Dockerfile .
# RUN
# docker run -it --rm stockfish:latest

FROM centos:8
RUN yum -y install git gcc gcc-c++ make && \
git clone https://github.com/official-stockfish/Stockfish.git && \
cd Stockfish/src && \
make -j ARCH=x86-64 profile-build
#    CXXFLAGS='-march=native' make -j2 profile-build ARCH=x86-64-bmi2 
CMD ["/Stockfish/src/stockfish"]

