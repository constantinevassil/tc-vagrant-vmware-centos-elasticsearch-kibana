# tc-vagrant-vmware-centos-elasticsearch-kibana

Vagrant config with VMWare provider to run a Elastisearch and Kibana using the source directory from your Mac. No scripts.

Step by step for full understing the process.

## Getting started

Topics:

1. Mac computer
1. VMWare Fusion 
1. Vagrant
1. CentOS 7+


## Getting started

On Mac

```bash
xcode-select --install
git clone https://github.com/topconnector/tc-vagrant-vmware-centos-elasticsearch-kibana.git
cd tc-vagrant-vmware-centos-elasticsearch-kibana
```

## NOTE: bootstrapelasticsearch.sh is performing automatic installation.

### Install Elasticsearch with RPM
https://www.elastic.co/guide/en/elasticsearch/reference/current/rpm.html

Import the Elasticsearch PGP Key:
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
Installing from the RPM repositoryedit
Create a file called elasticsearch.repo in the /etc/yum.repos.d/ directory for RedHat based distributions, containing:

```bash
[elasticsearch-5.x]
name=Elasticsearch repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
```

And your repository is ready for use. You can now install Elasticsearch with one of the following commands:

```bash
sudo yum install elasticsearch
```

Elasticsearch is not started automatically after installation. 

Running Elasticsearch with systemd
To configure Elasticsearch to start automatically when the system boots up, run the following commands:

```bash
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
```

Elasticsearch can be started and stopped as follows:

```bash
sudo systemctl start elasticsearch.service
sudo systemctl stop elasticsearch.service
```

These commands provide no feedback as to whether Elasticsearch was started successfully or not. Instead, this information will be written in the log files located in /var/log/elasticsearch/.

By default the Elasticsearch service doesn’t log information in the systemd journal. To enable journalctl logging, the --quiet option must be removed from the ExecStart command line in the elasticsearch.service file.

When systemd logging is enabled, the logging information are available using the journalctl commands:

To tail the journal:

```bash
sudo journalctl -f
```

To list journal entries for the elasticsearch service:

```bash
sudo journalctl --unit elasticsearch
```

To list journal entries for the elasticsearch service starting from a given time:

```bash
sudo journalctl --unit elasticsearch --since  "2016-10-30 18:17:16"
```

Checking that Elasticsearch is runningedit
You can test that your Elasticsearch node is running by sending an HTTP request to port 9200 on localhost:

```bash
curl -XGET 'localhost:9200/?pretty'
```

which should give you a response something like this:
```json
{
  "name" : "Cp8oag6",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "AT69_T_DTp-1qgIJlatQqA",
  "version" : {
    "number" : "5.5.1",
    "build_hash" : "f27399d",
    "build_date" : "2016-03-30T09:51:41.449Z",
    "build_snapshot" : false,
    "lucene_version" : "6.5.1"
  },
  "tagline" : "You Know, for Search"
}
```

Get your VM public IP Address:
```bash
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 00:0c:29:f6:51:05 brd ff:ff:ff:ff:ff:ff
    inet 10.0.1.57/24 brd 10.0.1.255 scope global dynamic eth1
       valid_lft 84465sec preferred_lft 84465sec
    inet6 fe80::20c:29ff:fef6:5105/64 scope link
       valid_lft forever preferred_lft forever
```       

Configure ElasticSearch 

The ElasticSearch configuration is located at /etc/elasticsearch/elasticsearch.yml
The minimal change required to configuration is to set following value

network.host: 10.0.1.57

By default the value is 127.0.0.1, which however prevents to access from outside the machine. 


### Install Kibana with RPM

https://www.elastic.co/guide/en/kibana/current/rpm.html

Import the Elastic PGP Key

Download and install the public signing key:

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

Installing from the RPM repositoryedit
Create a file called kibana.repo in the /etc/yum.repos.d/ directory for RedHat based distributions, or in the /etc/zypp/repos.d/ directory for OpenSuSE based distributions, containing:

```bash
[kibana-5.x]
name=Kibana repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
```

And your repository is ready for use. You can now install Kibana with the following command:

sudo yum install kibana


Running Kibana with systemdedit
To configure Kibana to start automatically when the system boots up, run the following commands:


```bash
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable kibana.service
```

Kibana can be started and stopped as follows:

```bash
sudo systemctl start kibana.service
sudo systemctl stop kibana.service
```

These commands provide no feedback as to whether Kibana was started successfully or not. Instead, this information will be written in the log files located in /var/log/kibana/.

Kibana confiruation file is similarly located at /etc/kibana/kibana.yml and the values you have to modify are

server.host: 10.0.1.57
elasticsearch.url: "http://localhost:9200"



