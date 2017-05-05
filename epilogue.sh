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
PBS_SESS=$5
PBS_RLIMITS=$6
PBS_RUSED=$7
PBS_QUEUE=$8
PBS_ACCOUNT=$9
PBS_EXITVAL=${10}

cat <<EOF


########################################################################
PBS Epilogue:	$(date)
Job ID:		$PBS_JOBID
Limits:		$PBS_RLIMITS
Resources:	$PBS_RUSED
Exit Value:	$PBS_EXITVAL
########################################################################
EOF
