#!/usr/bin/env python
#Create by Allen Sanabria
#To verify that the current RX Descriptors are set to the MAX of what it can handle.
#To set this value all you have to do is "ethtool -G <device> <MAX>"  ethtool -G eth0 511

#This script will reorder your vmnics for you
#Copyright (C) 2008 Allen Sanabria

#This program is free software; you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation; either version 2 of the License, or
#(at your option) any later version.

#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#GNU General Public License for more details.

#You should have received a copy of the GNU General Public License along
#with this program; if not, write to the Free Software Foundation, Inc.,
#51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.



import os, re

eth = []
cur_rx = {}
max_rx = {}
devices = open('/proc/net/dev', 'r').readlines()

root = 0
uid = os.getuid()
login = os.getlogin()

if uid == root:
  for lines in devices:
    match1 = re.search("(eth[0-9]+)\:", lines)
    if match1:
      eth.append(match1.group(1))
    else:
      continue

  for iface in eth:
    ethtool = 'ethtool -g %s' % (iface)
    ethtool_exec = os.popen(ethtool).readlines()
    for line in range(len(ethtool_exec)):
      match_max = re.search("^Pre-set\s+maximums\:", ethtool_exec[line])
      match_cur = re.search("^Current\s+hardware\s+settings\:", ethtool_exec[line])
      if match_max:
        match_value = re.search("(\d+)", ethtool_exec[line+1])
        max_rx[iface] = match_value.group(1)
      elif match_cur:
        match_value = re.search("(\d+)", ethtool_exec[line+1])
        cur_rx[iface] = match_value.group(1)
      else:
        continue
  for key in cur_rx.keys():
    if cur_rx[key] == max_rx[key]:
      print "[PASS] "+key+" rx value = "+max_rx[key]
      pass
    else:
      print "[FAIL] Current RX value = " +cur_rx[key]+ " (Required RX value = " +max_rx[key]+ ")"
      ethtool_set = 'ethtool -G %s rx %s' % (iface, max_rx[key])  
      ethtool_exec = os.popen(ethtool_set).readlines()
else:
  print "Only root can run this, and you are %s with a id of %s" % (login, uid )
