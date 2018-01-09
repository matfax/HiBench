#!/bin/bash
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

if ! [ -x "$(command -v wslpath)" ]; then
    echo "#=================================================#"
    echo "  Installing wslpath since command doesn't exist   "
    echo "#=================================================#"
    chmod 755 wslpath
    sudo mv wslpath /usr/bin
fi

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)

echo "#=================================================#"
echo "     This script first build the images            "
echo "       and then launch the container               "
echo "       with all dependencies installed             "
echo "                                                   "
echo "     After all services are launched, the          "
echo "     container will run a basic workload           "
echo "     , by default is 'wordcount'.                  "
echo "#=================================================#"
echo "                                                   "
echo "                                                   "

${DIR}/build_docker.sh $1
if [ $? == 1 ]; then
    echo "Usage $0 {cdh|open-source}"
    echo " "
    exit 1;
fi

# run HiBench workload wordcount as an example
# Format: docker.exe run (-v "LocalLargeDiskDir:/usr/loal"-it) hibench-hadoop-spark /bin/bash /root/HiBench/workloads/<workload-name>/prepare/prepare.sh
if [ "$1" == "cdh" ]
then
   docker.exe run -ti -v d:/data:/data --device-read-bps /dev/sda:200mb --device-read-iops /dev/sda:20000 --device-write-bps /dev/sda:200mb --device-write-iops /dev/sda:20000 hibench-docker-cdh /bin/bash -c "/root/runexample.sh"
elif [ "$1" == "open-source" ]
then
   docker.exe run -ti -v d:/data:/data --device-read-bps /dev/sda:200mb --device-read-iops /dev/sda:20000 --device-write-bps /dev/sda:200mb --device-write-iops /dev/sda:20000 hibench-docker-opensource /bin/bash -c "/root/runexample.sh"
fi
