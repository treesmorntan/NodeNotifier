#/bin/bash

# the following code: sort the list of downnode in descending order AND sucessfully compared the sorted down with time interval 

# var that saves the current date and time
previous_hour="$(date -d "-60 minutes" +'%FT%T')"
current_date_time="$(date +'%FT%T')"
twohours_ago="$(date -d "-2 hours" +'%FT%T')"

# this actually sort the timestamp
failednodetimestamp="$(/opt/slurm/bin/sinfo -R --format=%H --noheader | sort -r -k1)"

# 30 mins ago from current time (in seconds)
current_time=$(date +"%s")
halfhour_ago=$(date -d "-30 minutes" +"%s")

# the result of diff must be 1800s
interval_differences="$((current_time-halfhour_ago))"

echo "seconds differences between current and 30 mins ago in seconds: $interval_differences"

#convert the failednodelist and halfhour_ago to octal notation (in minutes)


for node in $failednodetimestamp;
do
        # a var that stores the list of down node in seconds format
        downnodetime=$(date -d "$node" +"%s")

        # the result of current_time - downnodetime
        differences="$((current_time-downnodetime))"

        # compare if the downnode time is less than the interval_differences (1800s)
        if [ "$differences" -lt "$interval_differences" ]; then
        echo "
node time stamp: $node 
node down time in seconds: $downnodetime 
the differences between current time and down node time: $differences"  

	else
	echo " $node is greater than 30 mins ago"

	fi
done

# down,drained,fail,future,maint, power_down, unknown, powered_down, no_respond, power_down, reboot, unknown=> savail references | are the list of down nodes (don't sinfo -R shows you already?)
