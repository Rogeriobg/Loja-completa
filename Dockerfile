# Etapa de build
FROM maven:3.9.8-eclipse-temurin-24 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY . .
RUN mvn clean package -DskipTests

# Etapa de runtime
FROM eclipse-temurin:24-jdk

WORKDIR /app

COPY --from=build /app/target/LojaCompleta-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
