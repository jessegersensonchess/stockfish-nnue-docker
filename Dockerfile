FROM centos:8 as build
RUN yum -y install git gcc gcc-c++ make && \
  git clone https://github.com/official-stockfish/Stockfish.git && \
  cd Stockfish/src && \
  CXXFLAGS='-march=native' make -j2 profile-build ARCH=x86-64

FROM centos:8

WORKDIR /app
COPY --from=build /Stockfish/src/stockfish ./ 
RUN adduser stockfish
USER stockfish

ENTRYPOINT ["/app/stockfish"]
