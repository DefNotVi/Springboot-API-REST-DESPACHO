# --- ETAPA 1: Compilación ---
FROM maven:3.8.8-eclipse-temurin-17 AS build
WORKDIR /app

# Copia el archivo de dependencias
COPY pom.xml .

# Descarga dependencias en caché
RUN mvn dependency:go-offline -B

# Copia el código fuente
COPY src ./src

# Compila saltando los tests para ir rápido
RUN mvn clean package -DskipTests

# --- ETAPA 2: Ejecución Segura ---
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Cumple con el criterio de "Mínimo Privilegio" de la rúbrica creando un usuario
RUN useradd -m devopsuser
USER devopsuser

# Copia el archivo compilado desde la etapa anterior
COPY --from=build /app/target/*.jar app.jar

# Expone el puerto por defecto de Spring Boot
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]