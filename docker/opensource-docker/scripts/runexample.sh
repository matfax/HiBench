#!/bin/bash

#modify etc/hosts file to avoid connection error
cp /etc/hosts /etc/hostsbak
sed -i 's/::1/#::1/' /etc/hostsbak
cat /etc/hostsbak > /etc/hosts
rm -rf /etc/hostsbak
#run wordcount example
/usr/bin/restart_hadoop_spark.sh
${HIBENCH_HOME}/bin/workloads/micro/wordcount/prepare/prepare.sh
${HIBENCH_HOME}/bin/workloads/micro/wordcount/hadoop/run.sh
${HIBENCH_HOME}/bin/workloads/micro/wordcount/spark/run.sh
${HIBENCH_HOME}/bin/workloads/micro/sort/prepare/prepare.sh
${HIBENCH_HOME}/bin/workloads/micro/sort/hadoop/run.sh
${HIBENCH_HOME}/bin/workloads/micro/sort/spark/run.sh
${HIBENCH_HOME}/bin/workloads/micro/terasort/prepare/prepare.sh
${HIBENCH_HOME}/bin/workloads/micro/terasort/hadoop/run.sh
${HIBENCH_HOME}/bin/workloads/micro/terasort/spark/run.sh
