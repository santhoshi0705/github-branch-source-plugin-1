# Use an OpenJDK 17 image because your logs show Java 17
FROM maven:3.9.4-eclipse-temurin-17

# Set working directory inside the container
WORKDIR /app

# Copy your pom.xml and source code into the container
COPY pom.xml .
COPY src ./src

# Optional: copy other needed files (like Jenkinsfile or settings.xml if you have them)
# COPY settings.xml /root/.m2/settings.xml

# Run Maven clean validate to verify the build
RUN mvn clean validate
