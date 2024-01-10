#/bin/bash

# var that saves the current date and time
previous_hour="$(date -d "-60 minutes" +'%FT%T')"
current_date_time="$(date +'%FT%T')"
twohours_ago="$(date -d "-2 hours" +'%FT%T')"

failednodelist="$(sinfo -R --format=%H --noheader)"

# 30 mins ago from current time (in seconds)
current_time=$(date +"%s")
halfhour_ago=$(date -d "-30 minutes" +"%s")


# the result of diff must be 1800s 
interval_differences="$((current_time-halfhour_ago))"

echo "seconds differences between current and 30 mins ago in seconds: $interval_differences"


#convert the failednodelist and halfhour_ago to octal notation (in minutes)
echo "loop start below here:  "

#date -d "$node" +"%s"
for node in $failednodelist;
do
	date -d "$node" +"%s" 
done
 
