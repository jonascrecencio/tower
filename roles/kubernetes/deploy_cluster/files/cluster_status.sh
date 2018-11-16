#!/bin/bash

count=0
ok=0
i=0
while [ $i -eq 0 ]; do
	kubectl get nodes | tr ' ' '%' | tr -s % | ( while read line; do
		status=$(echo $line | cut -f2 -d%)
		if [ $status == "STATUS" ]; then
			continue
		fi
		count=$(($count+1))
		if [ $status == "Ready" ]; then
			ok=$(($ok+1))
		fi
	done
	if [ $count -eq $ok ] && [ $ok -ne 0 ]; then
		echo "We are ready motherfucka!!!"
		touch /tmp/weareready
		break
	else
		echo "we are not ready yet :("
	fi )
	if [ -e /tmp/weareready ] ; then
		rm -f /tmp/weareready
		break
	fi
	sleep 10
done
