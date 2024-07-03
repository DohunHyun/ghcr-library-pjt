# Stage 1: Build
FROM gradle:7.3.3-jdk17 AS build

WORKDIR /app

COPY gradlew ./
COPY gradle ./gradle
COPY build.gradle ./
COPY settings.gradle ./

COPY src ./src

RUN ./gradlew build

# Stage 2: Run
FROM openjdk:17-jdk-slim

WORKDIR /app

COPY --from=build /app/build/libs/*.jar library.jar
