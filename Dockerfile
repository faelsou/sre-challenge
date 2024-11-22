# Builder
FROM ghcr.io/graalvm/graalvm-ce:22.2.0 AS builder
COPY . /root/app/
WORKDIR /root/app
RUN ./mvnw clean install -DskipTests

# Application
FROM ghcr.io/graalvm/graalvm-ce:22.2.0 AS application
COPY --from=builder /root/app/target/*.jar /home/app/app.jar
WORKDIR /home/app
RUN chmod 0777 /home/app/app.jar
EXPOSE 8080

# Defina as opções Java, se necessário
# ENV JAVA_OPTIONS="-Xmx512m -Xms256m"

ENTRYPOINT ["java", "-jar", "/home/app/app.jar"]
