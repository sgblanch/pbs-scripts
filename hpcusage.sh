#!/bin/bash

# Convience script to summarize cluster usage on a torque-based cluster.

qstat -at | awk '
	$10=="R" {
		job[$2]++
		jobc++
		cpu[$2] += $7
		cpuc += $7
	} $10=="Q" {
		queue[$2]++
		queuec++
		qcpu[$2] += $7
		qcpuc += $7
	} END {
		PROCINFO["sorted_in"] = "@val_num_desc"
		print "User    \tJobs\tCPUs\tQueue\tQueued CPUs"
		print "--------\t----\t----\t-----\t-----------"
		for (user in cpu) {
			printf("%-8s\t%4g\t%4g\t%5g\t%11g\n", user, job[user], cpu[user], queue[user], qcpu[user])
			delete queue[user]
		}
		for (user in queue) {
			printf("%-8s\t%4g\t%4g\t%5g\t%11g\n", user, 0, 0, queue[user], qcpu[user])
		}
		print "        \t====\t====\t=====\t==========="
		printf("%-8s\t%4g\t%4g\t%5g\t%11g\n", "", jobc, cpuc, queuec, qcpuc)
	}'
