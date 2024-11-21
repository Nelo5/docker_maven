# Используем образ Maven для сборки
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY demo/pom.xml ./
COPY demo/src ./src
RUN mvn clean package -DskipTests

# Используем образ OpenJDK для запуска
FROM openjdk:17
WORKDIR /app
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
