FROM ubuntu:20.04 as builder
RUN apt update && \
    apt upgrade -y && \
    apt-get install -y git make g++ wget && \
    git clone https://github.com/official-stockfish/Stockfish && \
    cd Stockfish/src && \
    CXXFLAGS='-march=native' make -j2 profile-build ARCH=x86-64-bmi2 
WORKDIR /Stockfish/src

FROM ubuntu:20.04
RUN apt-get update && apt-get install -y libgomp1 wget && apt-get autoremove -y && apt-get autoclean
COPY --from=0 /Stockfish/src/stockfish /app/
COPY --from=0 /Stockfish/src/*.nnue /app/
WORKDIR /app
CMD ["./stockfish"]
