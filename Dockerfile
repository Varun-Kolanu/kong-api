# Use Kong image as base image
FROM kong/kong-gateway:3.8.0.0

# Set environment variables
ENV KONG_DATABASE=off
ENV KONG_DECLARATIVE_CONFIG=/kong/declarative/kong.yml
ENV KONG_PROXY_ACCESS_LOG=/dev/stdout
ENV KONG_PROXY_ERROR_LOG=/dev/stderr

# Create the declarative config directory
USER root
RUN mkdir -p /kong/declarative

# Copy the kong.yml configuration file into the container
COPY ./kong.yml /kong/declarative/kong.yml
USER kong

# Expose the necessary port
EXPOSE 8000

# Command to start Kong
CMD ["kong", "reload", "start"]
