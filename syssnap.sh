#!/bin/bash

# System Snapshot

# Copyright (c) 2015 Mark Coccimiglio (mcoccimiglio@rice.edu)
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.

# Default settings.

_DEBUG=0
_destlogs=/var/log/syssnap
_maxdays=7
#_NOW=$(date '+%s')
_NOW=$(date '+%Y-%m-%d_%H:%M')

# Load configuration overrides.

_config=/etc/syssnap.conf

[ -s $_config ] && . $_config

[ ! -d $_destlogs ] && mkdir -p $_destlogs

find $_destlogs/ -name syssnap-\*log -type f -mtime +${_maxdays} $( (($_DEBUG)) || echo '-delete' )

date > $_destlogs/syssnap-${_NOW}.log
echo >> $_destlogs/syssnap-${_NOW}.log
uptime >> $_destlogs/syssnap-${_NOW}.log
echo >> $_destlogs/syssnap-${_NOW}.log
free -m >> $_destlogs/syssnap-${_NOW}.log
echo >> $_destlogs/syssnap-${_NOW}.log

echo "------------------------------------------------------------" >> $_destlogs/syssnap-${_NOW}.log
echo "w : " >> $_destlogs/syssnap-${_NOW}.log
w  >> $_destlogs/syssnap-${_NOW}.log
echo >> $_destlogs/syssnap-${_NOW}.log

echo "------------------------------------------------------------" >> $_destlogs/syssnap-${_NOW}.log
echo "TOP : " >> $_destlogs/syssnap-${_NOW}.log
top -b -n 1 >> $_destlogs/syssnap-${_NOW}.log
echo >> $_destlogs/syssnap-${_NOW}.log

echo "------------------------------------------------------------" >> $_destlogs/syssnap-${_NOW}.log
echo 'PS :' >> $_destlogs/syssnap-${_NOW}.log
ps auxf   >> $_destlogs/syssnap-${_NOW}.log
echo >> $_destlogs/syssnap-${_NOW}.log

echo "------------------------------------------------------------" >> $_destlogs/syssnap-${_NOW}.log
echo "IOSTATS:" >> $_destlogs/syssnap-${_NOW}.log
iostat   >> $_destlogs/syssnap-${_NOW}.log
echo >> $_destlogs/syssnap-${_NOW}.log

echo "------------------------------------------------------------" >> $_destlogs/syssnap-${_NOW}.log
echo "NETSTAT:" >> $_destlogs/syssnap-${_NOW}.log
netstat -tulpn >> $_destlogs/syssnap-${_NOW}.log
echo >> $_destlogs/syssnap-${_NOW}.log

echo "------------------------------------------------------------" >> $_destlogs/syssnap-${_NOW}.log
echo "NVidia-SMI:" >> $_destlogs/syssnap-${_NOW}.log
/usr/bin/env nvidia-smi >> $_destlogs/syssnap-${_NOW}.log
echo >> $_destlogs/syssnap-${_NOW}.log

echo "------------------------------------------------------------" >> $_destlogs/syssnap-${_NOW}.log
echo "CPU Temps:" >> $_destlogs/syssnap-${_NOW}.log
/usr/bin/env sensors >> $_destlogs/syssnap-${_NOW}.log
echo >> $_destlogs/syssnap-${_NOW}.log

echo "------------------------------------------------------------" >> $_destlogs/syssnap-${_NOW}.log
echo "Disk Usage:" >> $_destlogs/syssnap-${_NOW}.log
/usr/bin/env df -hT >> $_destlogs/syssnap-${_NOW}.log
echo >> $_destlogs/syssnap-${_NOW}.log

