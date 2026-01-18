# 1. 경량 JDK 이미지 사용 (Java 17 예시)
FROM eclipse-temurin:21-jdk-alpine

# 2. 애플리케이션 디렉터리
WORKDIR /app

# 3. 빌드된 JAR 복사 (예: build/libs/xxx.jar 또는 target/xxx.jar)
ARG JAR_FILE=build/libs/*.jar   # Gradle
# ARG JAR_FILE=target/*.jar     # Maven 사용 시 이렇게 변경
COPY ${JAR_FILE} app.jar

# 4. 컨테이너 포트 (Spring 기본 8080)
EXPOSE 8080

# 5. 애플리케이션 실행
ENTRYPOINT ["java","-jar","/app/app.jar"]
