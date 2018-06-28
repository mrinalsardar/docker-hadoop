#!/bin/bash

# Restart ssh service
service ssh restart

$HADOOP_HOME/bin/hdfs namenode -format

# Start file system
$HADOOP_HOME/sbin/start-dfs.sh

# Start yarn
$HADOOP_HOME/sbin/start-yarn.sh

/bin/bash
