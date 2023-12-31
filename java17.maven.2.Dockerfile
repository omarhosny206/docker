# Stage 1: Build the application
FROM maven:3.9.5-amazoncorretto-17 as builder

WORKDIR /app

COPY ./pom.xml .

RUN mvn dependency:go-offline

COPY ./src ./src

RUN mvn clean package -DskipTests

# Stage 2: Create a runtime container
FROM amazoncorretto:17-alpine as runtime

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/app.jar

CMD ["java", "-jar", "app.jar"]
