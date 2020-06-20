FROM ubuntu:20.04

RUN apt update && \
    apt upgrade -y && \
    apt-get install -y git make g++ && \
    git clone https://github.com/nodchip/Stockfish.git && \
        sed -i 's/LDFLAGS += -static/#LDFLAGS += -static/g' Stockfish/src/Makefile && \
        cd Stockfish/src && \
    make -j4 nnue-gen-sfen-from-original-eval ARCH=x86-64-bmi2

CMD [ "/Stockfish/src/stockfish" ]

