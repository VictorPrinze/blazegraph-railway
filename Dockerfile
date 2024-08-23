FROM openjdk:8-jre-alpine

RUN apk add --no-cache curl

WORKDIR /opt/blazegraph

RUN curl -L https://github.com/blazegraph/database/releases/download/BLAZEGRAPH_2_1_6_RC/blazegraph.jar -o blazegraph.jar

# Create necessary directories and set permissions
RUN mkdir -p /data /logs && \
    chown -R nobody:nogroup /data /logs /opt/blazegraph && \
    chmod 777 /data /logs

# Copy configuration files
COPY RWStore.properties /opt/blazegraph/
COPY log4j.properties /opt/blazegraph/

# Copy startup script
COPY start.sh /opt/blazegraph/
RUN chmod +x /opt/blazegraph/start.sh

# Switch to non-root user
USER nobody

EXPOSE ${PORT}

CMD ["/opt/blazegraph/start.sh"]