#/bin/bash

# the following code: sort the list of downnode in descending order AND sucessfully compared the sorted down with time interval 

# var that saves the current date and time
previous_hour="$(date -d "-60 minutes" +'%FT%T')"
current_date_time="$(date +'%FT%T')"
twohours_ago="$(date -d "-2 hours" +'%FT%T')"

# this actually sort the timestamp
failednodetimestamp="$(/opt/slurm/bin/sinfo -R --format=%H --noheader | sort -r -k1)"
echo "failednodetimestamp is here: $failednodetimestamp"

# get this nodelist
failednodeNode="$(/opt/slurm/bin/sinfo -R --format=%n --noheader | sort -r -k1)"
echo "failednodeNode: $failednodeNode"

failednodewithtime=$(/opt/slurm/bin/sinfo -R --format=%n,%H --noheader | sort -r -k1 -k2)
echo "failednodewithtime: $failednodewithtime "

# 30 mins ago from current time (in seconds)
current_time=$(date +"%s")
halfhour_ago=$(date -d "-30 minutes" +"%s")

# the result of diff must be 1800s
interval_differences="$((current_time-halfhour_ago))"

#echo "seconds differences between current and 30 mins ago in seconds: $interval_differences"

# boolean 
t=true
f=false

#convert the failednodelist and halfhour_ago to octal notation (in minutes)

#date -d "$node" +"%s"
for node in $failednodetimestamp;
do
        # a var that stores the list of down node in seconds format
        downnodetime=$(date -d "$node" +"%s")

        # the result of current_time - downnodetime
        differences="$((current_time-downnodetime))"

        # compare if the downnode time is less than the interval_differences (1800s)
        if [ "$differences" -lt "$interval_differences" ]; then
        	echo "$node, is less than 30 mins with differences $differences result should print t => $t"
	elif [ "$differences" -gt "$interval_differences" ]; then
		echo "$node, is greater than 30 mins $differences result should print f => $f"
	else
		echo "$node has a $downnodetime timestamp"
	fi

done
