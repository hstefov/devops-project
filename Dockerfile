# Stage 1: Build
FROM openjdk:17-oracle AS build

# Set the working directory
WORKDIR /app

# Copy the Maven wrapper and pom.xml
COPY pom.xml mvnw ./
COPY .mvn .mvn

# Resolve dependencies
RUN ./mvnw dependency:resolve

# Copy the source code
COPY src src

# Package the application
RUN ./mvnw package

# Stage 2: Run
FROM openjdk:17-oracle

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Define the entrypoint
ENTRYPOINT ["java", "-jar", "app.jar"]
