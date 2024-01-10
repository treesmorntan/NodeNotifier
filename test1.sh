#/bin/bash

# the following code: sort the list of downnode in descending order AND sucessfully compared the sorted down with time interval 

# var that saves the current date and time
previous_hour="$(date -d "-60 minutes" +'%FT%T')"
current_date_time="$(date +'%FT%T')"
twohours_ago="$(date -d "-2 hours" +'%FT%T')"

# this actually sort the timestamp
failednodetimestamp="$(/opt/slurm/bin/sinfo -R --format=%H --noheader | sort -r -k1)"
#echo "failednodetimestamp is here: $failednodetimestamp"

# get this nodelist
failednodeNode="$(/opt/slurm/bin/sinfo -R --format=%n --noheader | sort -r -k1)"
#echo "failednodeNode: $failednodeNode"

failednodewithtime="$(/opt/slurm/bin/sinfo -R --format=%n,%H --noheader | sort -r -k1 -k2)"
#echo "failednodewithtime: $failednodewithtime "

# 30 mins ago from current time (in seconds)
current_time=$(date +"%s")
halfhour_ago=$(date -d "-30 minutes" +"%s")

# the result of diff must be 1800s
interval_differences="$((current_time-halfhour_ago))"

#echo "seconds differences between current and 30 mins ago in seconds: $interval_differences"

# boolean vars 
t=true
f=false
sendemail=0

# this var will traverse in T nodes 
#tnodeindex

#convert the failednodelist and halfhour_ago to octal notation (in minutes)

#date -d "$node" +"%s"
for nodelist in $failednodewithtime;
do
	nodename="$(echo $nodelist | awk -F ',' '{ print $1 }')"	
	timestamp="$(echo $nodelist | awk -F ',' '{ print $2 }')"	
#	echo $nodename
        # a var that stores the list of down node in seconds format
        downnodetime=$(date -d "$timestamp" +"%s")

        # the result of current_time - downnodetime
        differences="$((current_time-downnodetime))"

        # compare if the downnode time is less than the interval_differences (1800s)
        if [ "$differences" -le "$interval_differences" ]; then
		sendemail=1
#        	echo "$nodelist, is less than 30 mins with differences $differences result should print t => $t"

		# travese the sinfo of filtered timestamp to get the node of that filtered timestamp
	#	for tnodeindex in "/opt/slurm/bin/sinfo -R --format=$node --noheader | sort -r -k1";
	#	do
	#		echo "filtered node index of true: $tnodeindex"	
	#	done
			
	elif [ "$differences" -gt "$interval_differences" ]; then
#		echo "$nodelist, is greater than 30 mins with differences $differences"

		# traverse the sinfo of filtered timestamp to get the node of that filtered timestamp, in this case is F
	#	for nodeindex in "$(/opt/slurm/bin/sinfo -R --format=$node --noheader | sort -r -k1)";
	#	do
	#		echo "fileterd node index of false: $nodeindex"
	#	done

#		echo "$nodelist has a $downnodetime timestamp"
	myvar=true
	fi

done

if [ "$sendemail" -eq 1 ]; then
	echo "sendemail"
	/opt/slurm/bin/sinfo -R --noheader | sort -r -k1 -k2	
fi



