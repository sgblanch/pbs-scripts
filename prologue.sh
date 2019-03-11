#!/bin/bash

# sgblanch@uncc.edu
# 05 May 2017

set -eu

# Torque may not give us a clean environment
PATH="/opt/moab/bin:/usr/local/bin:/usr/bin:/bin"
export PATH
unset TMPDIR

# We *really* want this to exit 0
trap "exit 0" 1 2 3 15 20 ERR EXIT

PBS_JOBID=$1
PBS_USER=$2
PBS_GROUP=$3
PBS_JOBNAME=$4
PBS_RLIMITS=$5
PBS_QUEUE=$6
PBS_ACCOUNT=$7

PBS_HOME=/var/spool/torque

cat <<EOF
########################################################################
PBS Prologue:	$(date)
Job ID:		$PBS_JOBID
Username:	$PBS_USER
Group:		$PBS_GROUP
Job Name:	$PBS_JOBNAME
Limits:		$(fold -w 56 <<< "$PBS_RLIMITS" | sed -e '2,$s/^/\t\t/')
Queue:		$PBS_QUEUE
Nodes:		$(sort $PBS_HOME/aux/$PBS_JOBID | uniq -c | awk '{ printf("%s[%s] ", $2, $1) }' | fold -sw 56 | sed -e '2,$s/^/\t\t/')
########################################################################
EOF
