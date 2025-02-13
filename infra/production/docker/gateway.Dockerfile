FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY . .

WORKDIR /app/gateway

RUN CGO_ENABLED=0 GOOS=linux go build -o gateway ./cmd/.

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/gateway/gateway .

EXPOSE 8080

CMD ["./gateway"] 