#!/bin/bash

#modify etc/hosts file to avoid connection error
cp /etc/hosts /etc/hostsbak
sed -i 's/::1/#::1/' /etc/hostsbak
cat /etc/hostsbak > /etc/hosts
rm -rf /etc/hostsbak
#run wordcount example
/usr/bin/restart-hadoop-spark.sh
${HIBENCH_HOME}/workloads/wordcount/prepare/prepare.sh
${HIBENCH_HOME}/workloads/wordcount/mapreduce/bin/run.sh
${HIBENCH_HOME}/workloads/wordcount/spark/scala/bin/run.sh
${HIBENCH_HOME}/workloads/sort/prepare/prepare.sh
${HIBENCH_HOME}/workloads/sort/mapreduce/bin/run.sh
${HIBENCH_HOME}/workloads/sort/spark/scala/bin/run.sh
${HIBENCH_HOME}/workloads/terasort/prepare/prepare.sh
${HIBENCH_HOME}/workloads/terasort/mapreduce/bin/run.sh
${HIBENCH_HOME}/workloads/terasort/spark/scala/bin/run.sh