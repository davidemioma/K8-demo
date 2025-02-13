FROM golang:1.23-alpine AS builder

WORKDIR /app

COPY . .

WORKDIR /app/orders

RUN CGO_ENABLED=0 GOOS=linux go build -o orders

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/orders/orders .

EXPOSE 2000

CMD ["./orders"] 