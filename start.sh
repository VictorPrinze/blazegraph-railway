#!/bin/sh
set -e

# Wait for the data directory to be mounted
while [ ! -d "/data" ]; do
  echo "Waiting for /data directory to be available..."
  sleep 1
done

# Start Blazegraph
exec java -server -Xmx512m -Djetty.port=${PORT} \
  -Dcom.bigdata.journal.AbstractJournal.file=/data/blazegraph.jnl \
  -Dlog4j.configuration=file:/opt/blazegraph/log4j.properties \
  -Dcom.bigdata.rdf.sail.webapp.ConfigParams.timeout=${BLAZEGRAPH_TIMEOUT} \
  -jar blazegraph.jar