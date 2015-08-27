#!/bin/bash

# ENC script to apply correct classes to nodes
# $1 returns FQDN, but we need only the hostname.


domainhost=$1
phost="${domainhost%%.*}"

string="maxnode,"

# node_groups.txt is dumped and scp'd from xcat each
# night at 11pm. For new machines added, /root/xcat_dump.sh
# on xcat, must be executed
# before running puppet. This ensures
# any new machines are present in this file.


group=$(grep -A1 $phost /etc/puppet/node_groups.txt | grep -v bmc)
if [[ "$group" == *"$string"* ]]; then
  class="lab"
  else
    class="workstation"
fi

# output yaml file to instruct puppet on classes to apply.

echo -e "---"
echo -e "classes:"
echo -e "- $class"
echo ""

