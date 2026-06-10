FROM openjdk:8-jre-alpine
WORKDIR /app
COPY target/triangle-app-1.0.0.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]