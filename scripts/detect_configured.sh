#!/bin/bash

/opt/pbs/bin/pbsnodes -a | cut -f1 -d" " | uniq -u > /opt/yast/hpc/scripts/configured_pbs
