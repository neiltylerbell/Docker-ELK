# ELK - ElasticSearch, Logstash, Kibana 
#
FROM ubuntu:14.04.2
MAINTAINER neiltylerbell

# Setup env and apt
ENV DEBIAN_FRONTEND noninteractive
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV ELASTICSEARCH_VERSION 1.4.4
#####
# Logstash version includes a random string
ENV LOGSTASH_VERSION 1.4.2-1-2c0f5a1_all
#####
# Newer Kibana versions include x86 or x64 in string
ENV KIBANA_VERSION 3.1.2

# Upgrade, get and install packages 
RUN apt-get update -y && apt-get dist-upgrade -y
RUN apt-get install -y apache2 supervisor wget openjdk-7-jdk openjdk-7-jre-headless python-pip
RUN a2enmod proxy proxy_http
RUN cd /tmp; wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${ELASTICSEARCH_VERSION}.deb && dpkg -i elasticsearch-${ELASTICSEARCH_VERSION}.deb
RUN cd /tmp; wget https://download.elasticsearch.org/logstash/logstash/packages/debian/logstash_${LOGSTASH_VERSION}.deb && dpkg -i logstash_${LOGSTASH_VERSION}.deb
Run cd /tmp; wget https://download.elasticsearch.org/kibana/kibana/kibana-${KIBANA_VERSION}.tar.gz; tar xvf kibana-${KIBANA_VERSION}.tar.gz; mv kibana-${KIBANA_VERSION}/* /var/www/html/
 
# Setup ELK configuration
ADD assets/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD assets/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
ADD assets/000-default.conf /etc/apache2/sites-available/000-default.conf 
ADD assets/logstash.conf /etc/logstash/conf.d/logstash.conf

# Start ELK
CMD ["/usr/bin/supervisord"]
