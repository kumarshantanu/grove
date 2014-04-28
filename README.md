# grove

Grove is a 3-node Vagrant configuration for working with

* [ZooKeeper](http://zookeeper.apache.org/)
* [Storm](http://storm.incubator.apache.org/)
* [Hadoop](http://hadoop.apache.org/) (todo)

This configuration uses 2GB RAM on each of the three nodes, which may be fine
for a host with 8GB RAM.

## Installation

1. Install the following software packages:

   * [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
   * [Vagrant](http://www.vagrantup.com/downloads.html)
   * [Ansible](http://docs.ansible.com/intro_installation.html)

2. Vagrant box download location:
   https://oss-binaries.phusionpassenger.com/vagrant/boxes/2014-04-22/

   Download the file [ubuntu-14.04-amd64-vbox.box](https://oss-binaries.phusionpassenger.com/vagrant/boxes/2014-04-22/ubuntu-14.04-amd64-vbox.box).

3. Add the downloaded box to Vagrant:

   ```bash
   vagrant box add --name trusty64 /path/to/ubuntu-14.04-amd64-vbox.box
   ```

   If you are on Ubuntu host you may have to run the following:

   ```bash
   $ sudo apt-get install python-yaml python-jinja2 python-paramiko python-crypto
   ```

4. Download required packages:

   ```
   ansible-playbook -i localhost download.yml
   ```

5. Start cluster:

   ```
   vagrant up
   vagrant provision
   ```

## Services

## ZooKeeper

   Start ZooKeeper: `./bin/zkServer start`

   Stop ZooKeeper: `./bin/zkServer stop`

### Storm services (press Ctrl+C to stop)

   Start Storm Nimbus: `./bin/storm-master.sh nimbus`

   Start Storm UI: `./bin/storm-master.sh ui` and visit http://10.211.55.101:8080

   Start Storm Supervisor: `./bin/storm-slave1.sh supervisor` and `./bin/storm-slave2.sh supervisor`


## Reference

- https://github.com/leucos/ansible-tuto
- http://blog.cloudera.com/blog/2013/04/how-to-use-vagrant-to-set-up-a-virtual-hadoop-cluster/
