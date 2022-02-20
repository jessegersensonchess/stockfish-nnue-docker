#### Compile stockfish. outputs to /Stockfish/src/stockfish ####
FROM alpine:3.15 as buildStockfish
RUN apk add gcc \
    g++ \
    make \
    git \
    curl && \
  git clone https://github.com/official-stockfish/Stockfish.git && \
  cd Stockfish/src && \
  CXXFLAGS='-static' make -j2 build ARCH=x86-64

#### Copy binaries, add a "stockfish" user ####
FROM alpine:3.15
WORKDIR /app
COPY --from=buildStockfish /Stockfish/src/stockfish ./
ENV USER=stockfish
ENV UID=12345

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --no-create-home \
    --uid "$UID" \
    "$USER" && \
    chown -R ${USER}:${USER} /app
USER ${USER}
ENTRYPOINT ["/app/stockfish"]
