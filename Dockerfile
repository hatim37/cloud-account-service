#FROM openjdk:17-oracle
#VOLUME /tmp
#COPY target/*.jar app.jar
#ENTRYPOINT ["java","-jar","app.jar"]
#EXPOSE 8081

# telechargement de maeven afin de construire la solution
FROM maven:3.9.7-eclipse-temurin-17 AS build

# créer un dossier
WORKDIR /app

#je copie le projet
COPY . .

#Téléchargement des dépendances & compilation
RUN mvn clean package -DskipTests

# utilisation d'un JRE
# Java Runtime Environment
FROM eclipse-temurin:17-jre-jammy

WORKDIR /app

COPY --from=build /app/target/*.war app.war

EXPOSE 8081

# commande qui sera executé lors du lancement du container
ENTRYPOINT ["java","-jar","app.war"]