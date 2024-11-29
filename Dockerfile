FROM maven:3.8.8-eclipse-temurin-17 AS build

WORKDIR /app


COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Użycie obrazu JDK jako bazowego
FROM openjdk:17-jdk-slim

# Ustaw zmienną środowiskową dla Javy
ENV JAVA_OPTS=""

# Skopiuj plik JAR do kontenera
COPY --from=build /app/target/demoDockerCompose-0.0.1-SNAPSHOT.jar app.jar

# Uruchom aplikację
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app.jar"]
