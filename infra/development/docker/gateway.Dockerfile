FROM golang:1.23-alpine

RUN apk add --no-cache git curl

WORKDIR /app

# Copy go mod and sum files
COPY gateway/go.mod gateway/go.sum ./gateway/

# Download dependencies
WORKDIR /app/gateway
RUN go mod download

# Copy the entire project
COPY . /app

# Enable live reloading for development
RUN go install github.com/air-verse/air@latest

# Expose port for the service
EXPOSE 8080

# Use air for live reloading
CMD ["air", "-c", ".air.toml"]