#/bin/bash

# var that saves the current date and time
previous_hour="$(date -d "-1 hour" +'%FT%T')"
twohours_ago="$(date -d "-2 hours" +'%FT%T')"
current_date_time="$(date +'%FT%T')"
three_weeks="$(date -d "-21 days" +'%FT%T')"
last_week="$(date -d "-7 days" +'%FT%T')"
last_month="$(date -d "-30 days" +'%FT%T')"
two_months="$(date -d "-60 days" +'%FT%T')"
three_months="$(date -d "-90 days" +'%FT%T')"

failednodetimestamp="$(/opt/slurm/bin/sinfo -R --format=%H --noheader)"

# how to sort both node and timestamp column before saving to output
echo -e
echo "sinfo -R -o TimeStamp of last week:"

# This reverse sort results in sorting in ascending order, -k# specifies the number of column  
/opt/slurm/bin/sinfo -R TimeStamp="${last_week}" --format=%H --noheader | sort -r -k1

# ^
echo "sinfo -R -o TimeStamp of current time:"
/opt/slurm/bin/sinfo -R TimeStamp="${current_date_time}" --format=%H --noheader | sort -r -k1 

