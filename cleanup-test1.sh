#/bin/bash

# list of down node and its' timestamp and sort it reverse format with most recent downnode on top
failednodewithtime="$(/opt/slurm/bin/sinfo -R --format=%n,%H --noheader | sort -r -k1 -k2)"

# 30 mins ago from current time (in seconds)
current_time=$(date +"%s")
halfhour_ago=$(date -d "-30 minutes" +"%s")

# the result of diff must be 1800s
interval_differences="$((current_time-halfhour_ago))"

# sendemail is a boolean. To toggle if any node went down x <= 30 mins ago of current interval
sendemail=0

for nodelist in $failednodewithtime;
do
	nodename="$(echo $nodelist | awk -F ',' '{ print $1 }')"	
	timestamp="$(echo $nodelist | awk -F ',' '{ print $2 }')"	

        downnodetime=$(date -d "$timestamp" +"%s")

        # the result of current_time - downnodetime
        differences="$((current_time-downnodetime))"

        # compare if the downnode time is less than the interval_differences (1800s)
        if [ "$differences" -le "$interval_differences" ]; then
		sendemail=1
	fi

done

if [ "$sendemail" -eq 1 ]; then
	echo "List of down nodes for the past 30 mins"
	downnodelist="$(/opt/slurm/bin/sinfo -R | sort -r -k1 -k2)" 
	echo $downnodelist | mailx -s "List of down node for the past 30 mins" tanboont9801@uwec.edu
fi

