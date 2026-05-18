# ============================================================
# STAGE 1 - BUILD
# ============================================================
FROM maven:3.9.6-eclipse-temurin-21-alpine AS builder

WORKDIR /app

COPY Springboot-API-REST/pom.xml ./pom.xml
COPY Springboot-API-REST/.mvn ./.mvn
COPY Springboot-API-REST/mvnw ./mvnw

RUN chmod +x mvnw && ./mvnw dependency:go-offline -q

COPY Springboot-API-REST/src ./src

RUN ./mvnw package -DskipTests -q

# ============================================================
# STAGE 2 - PRODUCTION
# ============================================================
FROM eclipse-temurin:21-jre-alpine AS production

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

COPY --from=builder /app/target/*.jar app.jar

RUN chown -R appuser:appgroup /app

USER appuser

EXPOSE 8081

HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
  CMD wget -qO- http://localhost:8081/actuator/health || exit 1

ENV DB_HOST=db \
    DB_PORT=3306 \
    DB_NAME=ventas_db \
    DB_USER=appuser \
    DB_PASS=apppassword \
    SERVER_PORT=8081

ENTRYPOINT ["java", "-jar", "app.jar"]
