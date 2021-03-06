#!/bin/sh

# Set the metadata server to the get projct id
PROJECTID=$(curl -s "http://metadata.google.internal/computeMetadata/v1/project/project-id" -H "Metadata-Flavor: Google")
BUCKET=$(curl -s "http://metadata.google.internal/computeMetadata/v1/instance/attributes/BUCKET" -H "Metadata-Flavor: Google")

echo "Project ID: ${PROJECTID} Bucket: ${BUCKET}"

# Get the files we need
gsutil cp gs://${BUCKET}/spring-simple-compute-deploy-jar-0.0.1-SNAPSHOT.jar .

echo "Loaded jar from gs://${BUCKET}/spring-simple-compute-deploy-jar-0.0.1-SNAPSHOT.jar"

# Install dependencies
apt-get update
apt-get install -yq openjdk-11-jdk git maven
mvn --version

echo "Loaded dependencies"

# Make Java 11 default
#update-alternatives --set java /usr/lib/jvm/java-11-openjdk-amd64/bin/java

# Start server
java -jar spring-simple-compute-deploy-jar-0.0.1-SNAPSHOT.jar