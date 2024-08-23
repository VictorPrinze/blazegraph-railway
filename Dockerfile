FROM openjdk:8-jre-alpine

RUN apk add --no-cache curl

WORKDIR /opt/blazegraph

RUN curl -L https://github.com/blazegraph/database/releases/download/BLAZEGRAPH_2_1_6_RC/blazegraph.jar -o blazegraph.jar

EXPOSE 9999

CMD ["sh", "-c", "java -server -Xmx512m -Djetty.port=${PORT} -jar blazegraph.jar"]