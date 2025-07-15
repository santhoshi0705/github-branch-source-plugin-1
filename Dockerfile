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

# Run the SonarQube analysis with parameters (replace <your_token> and <sonar_url>)
# Using ARGs so you can pass at build or runtime
ARG SONAR_HOST_URL
ARG SONAR_LOGIN
ARG SONAR_PROJECT_KEY

RUN mvn sonar:sonar \
    -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
    -Dsonar.host.url=${SONAR_HOST_URL} \
    -Dsonar.login=${SONAR_LOGIN}

# Optional: default command to keep container alive or run something else
CMD ["tail", "-f", "/dev/null"]
