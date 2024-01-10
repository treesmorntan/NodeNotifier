#/bin/bash


# var that saves the current date and time
prior_current_time="$(date -d "-15 minutes" +'%FT%T')"
current_date_time="$(date +'%FT%T')"
three_weeks="$(date -d "-21 days" +'%FT%T')"
last_week="$(date -d "-7 days" +'%FT%T')"
last_month="$(date -d "-30 days" +'%FT%T')"
two_months="$(date -d "-60 days" +'%FT%T')"
three_months="$(date -d "-90 days" +'%FT%T')"

# to get the list of down node w/o header
#echo -e "------------------------------------------"
failednodelist="$(/opt/slurm/bin/sinfo -R -o "%n  %H  %t")"
failednodetimestamp="$(/opt/slurm/bin/sinfo -R --format=%H --noheader)"

echo "$failednodelist"
#echo -e "failednodelist:\n${failednodelist}"
#i removing --format -> results much tidier format
echo -e
#echo -e "============== List of unavailable nodes ==============\n\n$(sinfo -R -o "\t"%n"\t\t"%H)\n"


echo -e "============== Job history on failed node ==============\n\n"

#formatting the print output  -%_ add space behind, %_ add space in front
	#titleformat="%-11s %23s %23s %15s %20s\n"
	#printf "$titleformat" "USER" "USERID" "ACCOUNT" "JOBNAME" "NODELIST"

/opt/slurm/bin/sacct --brief --allocation --allusers --starttime="${last_week}" --endtime="${current_date_time}" --nodelist="${failednodelist}" -o User%7,UID%8,Account%10,JobName%10,NodeList%10 
