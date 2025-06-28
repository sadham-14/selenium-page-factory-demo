# Stage 1: Build the project using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set work directory inside the container
WORKDIR /app

# Copy all files to the container
COPY . .

# Build the project without running tests
RUN mvn clean install -DskipTests

# Stage 2: Create runtime image
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy only the final JAR from the build stage
COPY --from=build /app/target/selenium-page-factory-1.0-SNAPSHOT.jar app.jar

# Default command to run the JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
