#!/bin/sh
set -ex

# Wait for the data directory to be mounted
while [ ! -d "/data" ]; do
  echo "Waiting for /data directory to be available..."
  sleep 1
done

# Print directory contents and permissions
ls -la /data
ls -la /opt/blazegraph

# Start Blazegraph with increased verbosity
exec java -server -Xmx512m \
  -Djetty.port=${PORT} \
  -Dcom.bigdata.journal.AbstractJournal.file=/data/blazegraph.jnl \
  -Dlog4j.configuration=file:/opt/blazegraph/log4j.properties \
  -Dcom.bigdata.rdf.sail.webapp.ConfigParams.timeout=300 \
  -Dcom.bigdata.journal.AbstractJournal.bufferMode=DiskRW \
  -Dcom.bigdata.journal.AbstractJournal.initialExtent=209715200 \
  -Dcom.bigdata.journal.AbstractJournal.maximumExtent=209715200 \
  -Dcom.bigdata.rdf.sail.truthMaintenance=false \
  -Dcom.bigdata.rdf.store.AbstractTripleStore.quads=true \
  -Dcom.bigdata.rdf.store.AbstractTripleStore.statementIdentifiers=false \
  -Dcom.bigdata.rdf.store.AbstractTripleStore.textIndex=false \
  -Dcom.bigdata.rdf.store.AbstractTripleStore.axiomsClass=com.bigdata.rdf.axioms.NoAxioms \
  -Dorg.eclipse.jetty.server.Request.maxFormContentSize=10000000 \
  -Dcom.bigdata.btree.writeRetentionQueue.capacity=4000 \
  -Dcom.bigdata.btree.BTree.branchingFactor=128 \
  -Dcom.bigdata.journal.Journal.groupCommit=true \
  -verbose:gc \
  -XX:+PrintGCDetails \
  -XX:+PrintGCDateStamps \
  -jar blazegraph.jar