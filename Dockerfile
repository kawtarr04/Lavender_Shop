# Étape 1 : Build avec Maven
FROM maven:3.8.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Étape 2 : Utilisation de Tomcat pour exécuter le .war
FROM tomcat:10.1-jdk17
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Tomcat écoute sur le port 8080 par défaut
EXPOSE 8080