#!/bin/bash

## Check if root-rsa-key is present; if not -> create one

if ! test -f /root/.ssh/id_rsa ; then
	ssh-keygen -t rsa -f /root/.ssh/id_rsa -N '' -q
fi
