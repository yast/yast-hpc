#!/bin/bash

sharepoint=$( grep SHAREPOINT /etc/sysconfig/hpc.cfg|cut -f2 -d":" )


sed '/$1/d' $sharepoint/shosts.equiv
