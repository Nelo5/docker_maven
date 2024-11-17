# Используем официальный образ Maven
FROM maven:3.9.4-eclipse-temurin-17 AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем pom.xml и весь код проекта
COPY app/pom.xml .
COPY app/src ./src

# Выполняем сборку проекта
RUN mvn clean package -DskipTests

# Используем легковесный образ JDK для запуска
FROM eclipse-temurin:17-jre

# Копируем готовый JAR из сборочной стадии
COPY --from=builder /app/target/*.jar /app/app.jar

# Устанавливаем рабочую директорию и точку входа
WORKDIR /app
ENTRYPOINT ["java", "-jar", "app.jar"]
