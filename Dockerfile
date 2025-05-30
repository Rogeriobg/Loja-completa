# Etapa de build
FROM maven:3.9.2-eclipse-temurin-17-slim AS build

WORKDIR /app

# Copia o pom.xml e baixa dependências
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copia o restante da aplicação
COPY . .

# Compila o projeto sem rodar testes
RUN mvn clean package -DskipTests

# Etapa de runtime com imagem estável
FROM eclipse-temurin:17-jdk AS runtime

WORKDIR /app

COPY --from=build /app/target/LojaCompleta-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
