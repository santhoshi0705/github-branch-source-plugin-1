# Use an official Maven JDK image to build the plugin
FROM maven:3.9.4-eclipse-temurin-17 AS builder

# Set work directory
WORKDIR /build

# Copy your project files
COPY . .

# Build the plugin (produces target/github-branch-source.hpi)
RUN mvn clean package

# Final image to output only the plugin
FROM alpine:3.18

# Create a folder to hold the plugin
RUN mkdir /plugin

# Copy the built plugin
COPY --from=builder /build/target/*.hpi /plugin/github-branch-source.hpi

CMD ["ls", "-lh", "/plugin"]
