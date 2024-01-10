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
failednodelist="$(sinfo -R --format=%n --noheader)"

#echo -e "failednodelist:\n${failednodelist}"
#i removing --format -> results much tidier format
echo -e
echo -e "============== List of unavailable nodes ==============\n\n$(/opt/slurm/bin/sinfo -R -o "\t"%n"\t\t"%H)\n"


echo -e "============== Job history on failed node (last month - today)==============\n\n"

#formatting the print output  -%_ add space behind, %_ add space in front
	#titleformat="%-11s %23s %23s %15s %20s\n"
	#printf "$titleformat" "USER" "USERID" "ACCOUNT" "JOBNAME" "NODELIST"

/opt/slurm/bin/sacct --brief --allocation --allusers --nodelist="${failednodelist}" --starttime="${last_month}" --endtime="${current_date_time}" -o User%15,UID%10,Account%12,JobName%15,NodeList%15

