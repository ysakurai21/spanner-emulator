FROM golang:1.16 as builder
ENV GO111MODULE=on
WORKDIR /build
COPY go.mod go.sum main.go ./
RUN go build .

FROM gcr.io/cloud-spanner-emulator/emulator:1.3.0 as runtime
COPY --from=builder /build/spanner-emulator ./
EXPOSE 9010 9020
CMD ["./spanner-emulator"]

