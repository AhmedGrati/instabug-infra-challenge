FROM golang:1.17-buster as builder

WORKDIR /app
RUN go mod init project_module
# Copy local code to the container image.
COPY . ./

# Build the binary.
RUN go build -v -o server -mod=mod

FROM debian:buster-slim
WORKDIR /app
RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Copy the binary to the production image from the builder stage.
COPY --from=builder /app .
# Run the web service on container startup.
CMD ["/app/server"]
