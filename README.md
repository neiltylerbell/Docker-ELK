# Docker-ELK
Dockerfile for running ElasticSearch, Logstash, Kibana (ELK) in Docker Container. 
Service versions can be changed via ENV variable.

# Use the command below when starting container manually
docker run -it -p 8080:80 -p 9200:9200 -p 514:514 -v /home/docker/elk/data/apache2:/var/log/apache2/ -v /home/docker/elk/data/elk/:/data/elk/ <image>
 
