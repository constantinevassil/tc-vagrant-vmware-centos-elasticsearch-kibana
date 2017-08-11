#!/bin/bash

# https://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
 
echo "Adding Elasticsearch repository elastic.repo."
touch '/etc/yum.repos.d/elastic.repo'
echo "[elasticsearch-5.x]
name=Elasticsearch repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md" > '/etc/yum.repos.d/elastic.repo'
 
echo "And your repository is ready for use. You can now install Elasticsearch"

yum install -y java elasticsearch 
 
# Elasticsearch is not started automatically after installation.
echo "Making sure Elastic-Search service starts automatically on system bootup"
systemctl daemon-reload
systemctl enable elasticsearch.service
 
echo "Start Elastic-Search service"
systemctl start elasticsearch.service
service  elasticsearch status
 
echo "Now I will sleep for 11 seconds and then verify if elastic search API is reachable."
n=0
while (( $n <= 11 ));
do
	echo -n ".";
	sleep 1;
	((n++));
done
 
if curl -XGET 'localhost:9200/?pretty';
then
	echo "Seems like ElasticSearch is up and running. Don't forget to set up whatever is needed in /etc/elasticsearch/"
	exit 0;
else
	echo "ERROR: Can't reach ElasticSearch!"
	exit 1;
fi;
