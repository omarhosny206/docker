# Stage 1: Build the application
FROM amazoncorretto:17-alpine as builder

WORKDIR /app

COPY . .

RUN chmod +x ./gradlew
RUN ./gradlew clean build -x test

# Stage 2: Create a runtime container
FROM amazoncorretto:17-alpine as runtime

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar /app/app.jar

CMD ["java", "-jar", "app.jar"]
