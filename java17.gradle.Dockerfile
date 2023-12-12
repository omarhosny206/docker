# Stage 1: Build the application
FROM amazoncorretto:17-alpine as build

WORKDIR /app

COPY . .

RUN chmod +x ./gradlew
RUN ./gradlew clean build -x test

# Stage 2: Create a runtime container
FROM amazoncorretto:17-alpine as runtime

WORKDIR /app

COPY --from=build /app/build/libs/*.jar /app/app.jar

CMD ["java", "-jar", "app.jar"]
