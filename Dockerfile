FROM openjdk:8-jre-alpine

RUN apk add --no-cache curl

WORKDIR /opt/blazegraph

RUN curl -L https://github.com/blazegraph/database/releases/download/BLAZEGRAPH_2_1_6_RC/blazegraph.jar -o blazegraph.jar

# Create a data directory with appropriate permissions
RUN mkdir -p /data && chown -R nobody:nogroup /data

# Switch to non-root user
USER nobody

EXPOSE ${PORT}

CMD ["sh", "-c", "java -server -Xmx512m -Djetty.port=${PORT} -Dbigdata.propertyFile=/opt/blazegraph/RWStore.properties -jar blazegraph.jar"]