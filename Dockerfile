# Étape 1 : Build de l'application
FROM maven:3.8.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Étape 2 : Image pour exécution
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# Commande de lancement
ENTRYPOINT ["java", "-jar", "app.jar"]
