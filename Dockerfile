FROM ubuntu:20.04 as builder

RUN apt update && \
    apt upgrade -y && \
    apt-get install -y git make g++ wget && \
    git clone https://github.com/jjoshua2/Stockfish && \
    cd Stockfish/src && \
    CXXFLAGS='-march=native' make -j3 profile-nnue ARCH=x86-64-bmi2 && \
    wget https://cccfiles.chess.com/engines/nn.bin
RUN wget https://cccfiles.chess.com/engines/nn.bin-jjosh-e959200
WORKDIR /Stockfish/src

FROM ubuntu:20.04
RUN apt-get update && apt-get install -y libgomp1 wget && apt-get autoremove -y && apt-get autoclean
COPY --from=0 /Stockfish/src/stockfish /app/
COPY --from=0 /Stockfish/src/nn.bin-jjosh-e959200 /app/eval/nn.bin
WORKDIR /app
CMD ["./stockfish"]
