FROM --platform=linux/amd64 maven:3.9.8-eclipse-temurin-24 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY . .
RUN mvn clean package -DskipTests

FROM --platform=linux/amd64 openjdk:25-jdk-slim

WORKDIR /app

COPY --from=build /app/target/LojaCompleta-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]