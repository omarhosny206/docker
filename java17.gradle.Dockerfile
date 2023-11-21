# Stage 1: Build the Spring Boot application
FROM amazoncorretto:17 as build
WORKDIR /app
COPY . .
RUN chmod +x ./gradlew
RUN ./gradlew clean build -x test

# Stage 2: Create a runtime container
FROM amazoncorretto:17 as runtime
WORKDIR /app
COPY --from=build /app/build/libs/*.jar /app/spring-boot-app.jar
CMD ["java", "-jar", "spring-boot-app.jar"]