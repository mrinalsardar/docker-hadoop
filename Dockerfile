FROM mrinal449/openjdk

# Set up environment variables
ENV HADOOP_VERSION=2.9.1

# Install ssh
RUN apt-get update && apt-get install -y curl

# Download and install hadoop
RUN curl --fail http://redrockdigimark.com/apachemirror/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz > /opt/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzf /opt/hadoop-${HADOOP_VERSION}.tar.gz -C /opt/ && \
    rm /opt/hadoop-${HADOOP_VERSION}.tar.gz && \
    ln -s /opt/hadoop-${HADOOP_VERSION} /opt/hadoop && \
    mkdir /opt/hadoop/data

COPY confs/* /opt/hadoop/etc/hadoop/
