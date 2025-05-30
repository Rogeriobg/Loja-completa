# Usar imagem oficial do Maven para buildar o projeto
FROM maven:3.9.2-eclipse-temurin-17 AS build

WORKDIR /app

# Copiar pom.xml e baixar dependências
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copiar todo o código-fonte
COPY src ./src

# Buildar o projeto
RUN mvn clean package -DskipTests

# Usar imagem oficial do OpenJDK para rodar a aplicação
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copiar o jar gerado da imagem build para a imagem final
COPY --from=build /app/target/LojaCompleta-0.0.1-SNAPSHOT.jar app.jar

# Expõe a porta que sua aplicação Spring Boot usa (geralmente 8080)
EXPOSE 8080

# Comando para rodar a aplicação
ENTRYPOINT ["java","-jar","app.jar"]