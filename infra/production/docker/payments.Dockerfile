FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY . .

WORKDIR /app/payments

RUN CGO_ENABLED=0 GOOS=linux go build -o payments

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/payments/payments .

EXPOSE 5672

CMD ["./payments"] 