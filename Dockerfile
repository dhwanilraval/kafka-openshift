FROM centos:7
ENV ENABLE_AUTO_EXTEND true
ENV NUM_PARTITIONS 12
RUN mkdir -p /opt/kafka \
  && cd /opt/kafka \
  && yum -y install java-1.8.0-openjdk-headless gettext net-tools \
  && curl -s http://www.mirrorservice.org/sites/ftp.apache.org/kafka/0.10.1.0/kafka_2.11-0.10.1.0.tgz | tar -xz --strip-components=1 \
  && yum clean all 
COPY bin/*.sh /opt/kafka/bin/
COPY lib/*.jar /opt/kafka/libs/
COPY config/* /opt/kafka/config/
RUN chmod -R a=u /opt/kafka
RUN chmod -R a+rx /opt/kafka/bin/*
WORKDIR /opt/kafka
VOLUME /tmp/kafka-logs /tmp/zookeeper
EXPOSE 2181 2888 3888 9093
