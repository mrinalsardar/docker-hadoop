FROM mrinal449/openjdk

# Set up environment variables
ENV HADOOP_VERSION=2.9.1

# Install curl, ssh and set up passwordless ssh to localhost
RUN apt-get update && \
    apt-get install -y curl ssh openssh-server && \
    ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
    cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
    service ssh restart

# Copy ssh config file
COPY confs/ssh_config /root/.ssh/config

# Download and install hadoop
RUN curl --fail http://redrockdigimark.com/apachemirror/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz > /opt/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzf /opt/hadoop-${HADOOP_VERSION}.tar.gz -C /opt/ && \
    rm /opt/hadoop-${HADOOP_VERSION}.tar.gz && \
    ln -s /opt/hadoop-${HADOOP_VERSION} /opt/hadoop && \
    mkdir /opt/hadoop/tmp /opt/hadoop/namenode /opt/hadoop/datanode && \
    sed -i -e \$a"export JAVA_HOME=$(echo ${JAVA_HOME})/" /opt/hadoop/etc/hadoop/hadoop-env.sh && \
    sed -i -e \$a"export HADOOP_CONF_DIR=\/opt\/hadoop\/etc\/hadoop" /opt/hadoop/etc/hadoop/hadoop-env.sh

# Set HADOOP_HOME
ENV HADOOP_HOME=/opt/hadoop

# Copy hadoop config files
COPY confs/*.xml /opt/hadoop/etc/hadoop/

COPY ./entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "bash" ]

