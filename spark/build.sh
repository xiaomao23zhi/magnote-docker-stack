#!/usr/bin/env bash

set -ex

SPARK_VERSION=3.3.0
HADOOP_VERSION=hadoop3
SPARK_BIN=spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz
AWS_JAVA_SDK_BUNDLE_VERSION=1.11.1034
HADOOP_AWS_VERSION=3.2.4
REPO=gchr.io/xiaomao23zhi/magnote-docker-stack
TAG=${SPARK_VERSION}_${HADOOP_VERSION}

wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz
tar -xzf ${SPARK_BIN}

# Install addtional jars
cd spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}
wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_JAVA_SDK_BUNDLE_VERSION}/aws-java-sdk-bundle-${AWS_JAVA_SDK_BUNDLE_VERSION}.jar jars/
wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_AWS_VERSION}/hadoop-aws-${HADOOP_AWS_VERSION}.jar jars/

./bin/docker-image-tool.sh -r ${REPO} -t ${TAG} -p ./kubernetes/dockerfiles/spark/bindings/python/Dockerfile build
