#!/usr/bin/env bash

echo [master]
vagrant ssh -c "/home/vagrant/app/zookeeper-3.4.6/bin/zkServer.sh $@" master
echo [slave1]
vagrant ssh -c "/home/vagrant/app/zookeeper-3.4.6/bin/zkServer.sh $@" slave1
echo [slave2]
vagrant ssh -c "/home/vagrant/app/zookeeper-3.4.6/bin/zkServer.sh $@" slave2
