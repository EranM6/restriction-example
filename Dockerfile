## Build JAR file with gradle
FROM gradle:8.1.1-jdk17 AS build

COPY  . /workspace/
WORKDIR /workspace/

RUN gradle build

#--------------

FROM registry.access.redhat.com/ubi8/openjdk-17:1.16

ENV LANGUAGE='en_US:en'


# We make four distinct layers so if there are application changes the library layers can be re-used
COPY --chown=185 --from=build /workspace/build/quarkus-app/lib/ /deployments/lib/
COPY --chown=185 --from=build /workspace/build/quarkus-app/*.jar /deployments/
COPY --chown=185 --from=build /workspace/build/quarkus-app/app/ /deployments/app/
COPY --chown=185 --from=build /workspace/build/quarkus-app/quarkus/ /deployments/quarkus/

EXPOSE 8080
USER 185
ENV JAVA_OPTS="-Dquarkus.http.host=0.0.0.0 -Djava.util.logging.manager=org.jboss.logmanager.LogManager"
ENV JAVA_APP_JAR="/deployments/quarkus-run.jar"

