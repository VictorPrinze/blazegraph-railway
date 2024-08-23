FROM openjdk:8-jre-alpine

RUN apk add --no-cache curl

WORKDIR /opt/blazegraph

RUN curl -L https://github.com/blazegraph/database/releases/download/BLAZEGRAPH_2_1_6_RC/blazegraph.jar -o blazegraph.jar

# Create necessary directories
RUN mkdir -p /data /logs && chown -R nobody:nogroup /data /logs

# Copy configuration files
COPY RWStore.properties /opt/blazegraph/
COPY log4j.properties /opt/blazegraph/

# Switch to non-root user
USER nobody

EXPOSE ${PORT}

CMD ["sh", "-c", "java -server -Xmx512m -Djetty.port=${PORT} -Dcom.bigdata.journal.AbstractJournal.file=/data/blazegraph.jnl -Dlog4j.configuration=file:/opt/blazegraph/log4j.properties -jar blazegraph.jar"]