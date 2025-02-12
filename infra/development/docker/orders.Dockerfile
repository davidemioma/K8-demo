FROM golang:1.23-alpine

RUN apk add --no-cache git curl

WORKDIR /app

# Copy go mod and sum files
COPY orders/go.mod orders/go.sum ./orders/

# Download dependencies
WORKDIR /app/orders
RUN go mod download

# Copy the entire project
COPY . /app

# Enable live reloading for development
RUN go install github.com/air-verse/air@latest

# Expose port for the service
EXPOSE 2000

# Use air for live reloading
CMD ["air", "-c", ".air.toml"]