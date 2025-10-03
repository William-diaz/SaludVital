# Imagen de construcción
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Crear carpeta de la app
WORKDIR /app

# Copiar pom.xml primero
COPY pom.xml .

# Copiar el código y compilar
COPY src ./src
RUN mvn package -DskipTests

# Imagen final
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
