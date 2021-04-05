# Build the listbuilds.jar
FROM us-docker.pkg.dev/bendory-cloud-builders/cloud-builders/mvn as builder
COPY pom.xml .
COPY src src
RUN mvn -q package

# Package the jar into a jre container.
FROM openjdk:11-jre-slim
COPY --from=builder /target/listbuilds-1.0-jar-with-dependencies.jar /usr/local/lib/listbuilds.jar
ENTRYPOINT ["java", "-jar", "/usr/local/lib/listbuilds.jar"]
