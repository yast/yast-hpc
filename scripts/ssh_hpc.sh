#!/bin/bash

if ! test -f /root/.ssh/id_rsa ; then
	ssh-keygen -t rsa -f /root/.ssh/id_rsa -N '' -q
fi
