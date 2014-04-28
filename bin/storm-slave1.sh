#!/usr/bin/env bash

vagrant ssh -c "rlwrap /home/vagrant/app/storm-0.9.0.1/bin/storm $@" slave1
