#!/bin/bash
# Copyright (c) 1995-2005 SUSE Linux AG, Nuernberg, Germany.
# All rights reserved.
#
# Author: Thomas Hofmann

# 1st saving old config for backup

cp sched_config sched_config.old

# Round Robin -
#       run a job from each queue before running second job from the
#       first queue.

round_robin ()
{
	if [ ${2} == "False" ] || [ ${2} == "false" ] || [ ${2} == "FALSE" ]
	then 	echo "Value = False"
		validvalue=1
	fi
	if [ ${2} == "True" ] || [ ${2} == "true" ] || [ ${2} == "TRUE" ]
        then    echo "Value = True"
                validvalue=1
        fi
	if [ ${3} == "All" ] || [ ${3} == "all" ] || [ ${3} == "ALL" ]
	then echo "Option = all"
	validoption=1
	fi
	if [ $validvalue == "1" ] && [ $validoption == "1" ]
	then	oldparam=$( grep round_robin: sched_config )
		newparam="round_robin: ${2}        ${3}"
#		echo "${oldparam}"
		echo "${newparam}"
#		cat sched_config.old | sed -e s/"${oldparam}"/"${newparam}"/g > sched_config
#		echo " $1 $2 $3 "
        else echo "ERROR: incorrect Parameter for Module 'Round Robin'"
	fi
return
}


# By Queue -
#       run jobs by queues.
#       If it is not set, the scheduler will look at all the jobs on
#       on the server as one large queue, and ignore the queues set
#       by the administrator
#       PRIME OPTION

by_queue ()
{
	if [ ${2} == "False" ] || [ ${2} == "false" ] || [ ${2} == "FALSE" ]
        then    echo "Value = False"
                validvalue=1
        fi
	if [ ${2} == "True" ] || [ ${2} == "true" ] || [ ${2} == "TRUE" ]
        then    echo "Value = True"
                validvalue=1
        fi
        if [ ${3} == "All" ] || [ ${3} == "all" ] || [ ${3} == "ALL" ]
        then echo "Option = all"
        validoption=1
        fi
	if [ ${3} == "Prime" ] || [ ${3} == "prime" ] || [ ${3} == "PRIME" ]
	then echo "Option = Prime"
	validoption=1
	fi
	if [ ${3} == "Non_Prime" ] || [ ${3} == "non_prime" ] || [ ${3} == "NON_PRIME" ]
	then echo "Option = non_prime"
	validoption=1
	fi
	if [ $validvalue == "1" ] && [ $validoption == "1" ]
        then    oldparam=$( grep by_queue: sched_config )
                newparam="by_queue: ${2}        ${3}"
#                echo "${oldparam}"
                echo "${newparam}"
#               cat sched_config.old | sed -e s/"${oldparam}"/"${newparam}"/g > sched_config
#                echo " $1 $2 $3 "
        else echo "ERROR: incorrect Parameter for Module 'By Queue'"
	fi
	return
}


# Strict Fifo -
#       run jobs in strict fifo order.  If one job can not run
#       move onto the next queue and do not run any more jobs
#       out of that queue even if some jobs in the queue could
#       be run.
#       If it is not set, it could very easily starve the large
#       resource using jobs.
#       PRIME OPTION

strict_fifo ()
{	
	if [ ${2} == "False" ] || [ ${2} == "false" ] || [ ${2} == "FALSE" ]
        then    echo "Value = False"
                validvalue=1
        fi
	if [ ${2} == "True" ] || [ ${2} == "true" ] || [ ${2} == "TRUE" ]
        then    echo "Value = True"
                validvalue=1
        fi
        if [ ${3} == "All" ] || [ ${3} == "all" ] || [ ${3} == "ALL" ]
        then echo "Option = all"
        validoption=1
        fi
	if [ ${3} == "Prime" ] || [ ${3} == "prime" ] || [ ${3} == "PRIME" ]
	then echo "Option = Prime"
	validoption=1
	fi
	if [ ${3} == "Non_Prime" ] || [ ${3} == "non_prime" ] || [ ${3} == "NON_PRIME" ]
	then echo "Option = non_prime"
	validoption=1
	fi
	if [ $validvalue == "1" ] && [ $validoption == "1" ]
        then    oldparam=$( grep strict_fifo: sched_config )
                newparam="strict_fifo: ${2}        ${3}"
#                echo "${oldparam}"
                echo "${newparam}"
#               cat sched_config.old | sed -e s/"${oldparam}"/"${newparam}"/g > sched_config
#                echo " $1 $2 $3 "
        else echo "ERROR: incorrect Parameter for Module 'Strict Fifo'"
	fi
	return
}


# fair_share - schedule jobs based on usage and share values
#       PRIME OPTION
#
fair_share ()
{
	if [ ${2} == "False" ] || [ ${2} == "false" ] || [ ${2} == "FALSE" ]
        then    echo "Value = False"
                validvalue=1
        fi
	if [ ${2} == "True" ] || [ ${2} == "true" ] || [ ${2} == "TRUE" ]
        then    echo "Value = True"
                validvalue=1
        fi
        if [ ${3} == "All" ] || [ ${3} == "all" ] || [ ${3} == "ALL" ]
        then echo "Option = all"
        validoption=1
        fi
	if [ ${3} == "Prime" ] || [ ${3} == "prime" ] || [ ${3} == "PRIME" ]
	then echo "Option = Prime"
	validoption=1
	fi
	if [ ${3} == "Non_Prime" ] || [ ${3} == "non_prime" ] || [ ${3} == "NON_PRIME" ]
	then echo "Option = non_prime"
	validoption=1
	fi
	if [ $validvalue == "1" ] && [ $validoption == "1" ]
        then    oldparam=$( grep fair_share: sched_config )
                newparam="fair_share: ${2}        ${3}"
#                echo "${oldparam}"
                echo "${newparam}"
#               cat sched_config.old | sed -e s/"${oldparam}"/"${newparam}"/g > sched_config
#                echo " $1 $2 $3 "
        else echo "ERROR: incorrect Parameter for Module 'Fair Share'"
	fi
	return
}


# Help Starving Jobs -
#       Jobs which have been waiting a long time will
#       be considered starving.  Once a job is considered
#       starving, the scheduler will not run any jobs
#       until it can run all of the starving jobs.
#       PRIME OPTION

starving_jobs ()
{
	if [ ${2} == "False" ] || [ ${2} == "false" ] || [ ${2} == "FALSE" ]
        then    echo "Value = False"
                validvalue=1
        fi
	if [ ${2} == "True" ] || [ ${2} == "true" ] || [ ${2} == "TRUE" ]
        then    echo "Value = True"
                validvalue=1
        fi
        if [ ${3} == "All" ] || [ ${3} == "all" ] || [ ${3} == "ALL" ]
        then echo "Option = all"
        validoption=1
        fi
	if [ ${3} == "Prime" ] || [ ${3} == "prime" ] || [ ${3} == "PRIME" ]
	then echo "Option = Prime"
	validoption=1
	fi
	if [ ${3} == "Non_Prime" ] || [ ${3} == "non_prime" ] || [ ${3} == "NON_PRIME" ]
	then echo "Option = non_prime"
	validoption=1
	fi
	if [ $validvalue == "1" ] && [ $validoption == "1" ]
        then    oldparam=$( grep help_starving_jobs: sched_config )
                newparam="help_starving_jobs: ${2}        ${3}"
#                echo "${oldparam}"
                echo "${newparam}"
#               cat sched_config.old | sed -e s/"${oldparam}"/"${newparam}"/g > sched_config
#                echo " $1 $2 $3 "
        else echo "ERROR: incorrect Parameter for Module 'Help Starving Jobs'"
	fi
	return
}


# sort_queues - sort queues by the priority attribute
#       PRIME OPTION
#

sort_queues ()
{
	if [ ${2} == "False" ] || [ ${2} == "false" ] || [ ${2} == "FALSE" ]
        then    echo "Value = False"
                validvalue=1
        fi
	if [ ${2} == "True" ] || [ ${2} == "true" ] || [ ${2} == "TRUE" ]
        then    echo "Value = True"
                validvalue=1
        fi
        if [ ${3} == "All" ] || [ ${3} == "all" ] || [ ${3} == "ALL" ]
        then echo "Option = all"
        validoption=1
        fi
	if [ ${3} == "Prime" ] || [ ${3} == "prime" ] || [ ${3} == "PRIME" ]
	then echo "Option = Prime"
	validoption=1
	fi
	if [ ${3} == "Non_Prime" ] || [ ${3} == "non_prime" ] || [ ${3} == "NON_PRIME" ]
	then echo "Option = non_prime"
	validoption=1
	fi
	if [ $validvalue == "1" ] && [ $validoption == "1" ]
        then    oldparam=$( grep sort_queues: sched_config )
                newparam="sort_queues: ${2}        ${3}"
#                echo "${oldparam}"
                echo "${newparam}"
#               cat sched_config.old | sed -e s/"${oldparam}"/"${newparam}"/g > sched_config
#                echo " $1 $2 $3 "
        else echo "ERROR: incorrect Parameter for Module 'Sort Queues'"
	fi
	return
}

# load_balancing - load balance between timesharing nodes
#       PRIME OPTION
#

load_balancing ()
{
	if [ ${2} == "False" ] || [ ${2} == "false" ] || [ ${2} == "FALSE" ]
        then    echo "Value = False"
                validvalue=1
        fi
	if [ ${2} == "True" ] || [ ${2} == "true" ] || [ ${2} == "TRUE" ]
        then    echo "Value = True"
                validvalue=1
        fi
        if [ ${3} == "All" ] || [ ${3} == "all" ] || [ ${3} == "ALL" ]
        then echo "Option = all"
        validoption=1
        fi
	if [ ${3} == "Prime" ] || [ ${3} == "prime" ] || [ ${3} == "PRIME" ]
	then echo "Option = Prime"
	validoption=1
	fi
	if [ ${3} == "Non_Prime" ] || [ ${3} == "non_prime" ] || [ ${3} == "NON_PRIME" ]
	then echo "Option = non_prime"
	validoption=1
	fi
	if [ $validvalue == "1" ] && [ $validoption == "1" ]
        then    oldparam=$( grep load_balancing: sched_config )
                newparam="load_balancing: ${2}        ${3}"
#                echo "${oldparam}"
                echo "${newparam}"
#               cat sched_config.old | sed -e s/"${oldparam}"/"${newparam}"/g > sched_config
#                echo " $1 $2 $3 "
        else echo "ERROR: incorrect Parameter for Module 'Load Balancing'"
	fi
	return
}

# sort_by:
# key:
#       to sort the jobs on one key, specify it by sort_by
#       If multiple sorts are necessary, set sory_by to multi_sort
#       specify the keys in order of sorting
#
# if round_robin or by_queue is set, the jobs will be sorted in their
# respective queues.  If not the entire server will be sorted.
#
# different sorts - defined in globals.c
# no_sort shortest_job_first longest_job_first smallest_memory_first
# largest_memory_first high_priority_first low_priority_first multi_sort
# fair_share large_walltime_first short_walltime_first
#
#       PRIME OPTION

sort_by ()
{ 
echo
}

# filter out prolific debug messages
# 256 are DEBUG2 messages
#       NO PRIME OPTION

log_filter ()
{
	if [ ${2} -le 256 ] && [ ${2} -ge 0 ]
	then	echo "log_filter set to ${2}"
		oldparam=$( grep log_filter: sched_config )
                newparam="log_filter: ${2}"
#                echo "${oldparam}"
                echo "${newparam}"
#               cat sched_config.old | sed -e s/"${oldparam}"/"${newparam}"/g > sched_config
#                echo " $1 $2 "
        else echo "ERROR: incorrect Parameter for Module 'log_filter'"
        fi


}


# all queues starting with this value are dedicated time queues
# i.e. dedtime or dedicatedtime would be dedtime queues
#       NO PRIME OPTION

dedicated_prefix ()
{
	echo "dedicated Prefix set to ${2}"
		oldparam=$( grep dedicated_prefix: sched_config )
                newparam="dedicated_prefix: ${2}"
#                echo "${oldparam}"
                echo "${newparam}"
#               cat sched_config.old | sed -e s/"${oldparam}"/"${newparam}"/g > sched_config
#                echo " $1 $2 "
}


# this defines how long before a job is considered starving.  If a job has
# been queued for this long, it will be considered starving
#       NO PRIME OPTION


max_starve ()
{
	if [ ${2:0:2} -le 59 ] && [ ${2:3:2} -le 59 ] && [ ${2:6:2} -le 59 ]
	then #	echo " ${2:0:2} ${2:3:2} ${2:6:2}" 
		oldparam=$( grep max_starve: sched_config )
	        newparam="max_starve: ${2}"
#        	echo "${oldparam}"
        	echo "${newparam}"
#       	cat sched_config.old | sed -e s/"${oldparam}"/"${newparam}"/g > sched_config
	else 	echo "ERROR: invalid Value in Module 'max starve'"
	fi
}

# half_life - the half life of usage for fair share
#       NO PRIME OPTION

half_life ()
{
	if [ ${2:0:2} -le 59 ] && [ ${2:3:2} -le 59 ] && [ ${2:6:2} -le 59 ]
        then #	echo " ${2:0:2} ${2:3:2} ${2:6:2}"
		oldparam=$( grep half_life: sched_config )
                newparam="half_life: ${2}"
#                echo "${oldparam}"
                echo "${newparam}"
#               cat sched_config.old | sed -e s/"${oldparam}"/"${newparam}"/g > sched_config
 	
	else 	echo "ERROR: invalid Value in Module 'half life'"
        fi
}


# unknown_shares - the number of shares for the "unknown" group
#       NO PRIME OPTION

unknown_shares ()
{
        if [ ${2} -le 99 ]
        then #	echo " ${2}"
	        oldparam=$( grep unknown_shares: sched_config )
                newparam="unknown_shares: ${2}"
#                echo "${oldparam}"
                echo "${newparam}"
#               cat sched_config.old | sed -e s/"${oldparam}"/"${newparam}"/g > sched_config
	
	else 	echo "ERROR: invalid Value in Module 'unknown_shares'"
        fi
}



# sync_time - the amount of time between syncing the usage information to disk
#       NO PRIME        OPTION

sync_time ()
{
        if [ ${2:0:2} -le 59 ] && [ ${2:3:2} -le 59 ] && [ ${2:6:2} -le 59 ]
        then  #  echo " ${2:0:2} ${2:3:2} ${2:6:2}"
                oldparam=$( grep sync_time: sched_config )
                newparam="sync_time: ${2}"
#                echo "${oldparam}"
                echo "${newparam}"
#               cat sched_config.old | sed -e s/"${oldparam}"/"${newparam}"/g > sched_config

        else    echo "ERROR: invalid Value in Module 'sync time'"
        fi
}



for n in $(seq 1 $#); do
	# Init Flags and Parameterset
	validparam=0
	validvalue=0
	validoption=0
# if noch mind. 3 Parameter vorhanden
#	echo "Debug: n: $n, #: $#" #debug output
#	echo "Debug: $(($n+1)) ; $#"
	if [ $(($n+2)) -le $# ] # 3-Parameterset	
	then
#		echo "3-er Set"
		param="$n"
		value="$(($n+1))"
		option="$(($n+2))"
		testparam="${!param}"           #"Der" Parameter
		testvalue="${!value}"           #Wert
		testoption="${!option}"         #Option

		#echo ${!param}
		#echo ${!value}
		#echo ${!option}
		
		if [ ${testparam:0:1} == "-" ]
		then
			if [ ${testvalue:0:1} !=  "-" ] && [ ${testoption:0:1} !=  "-" ]
			then  #	echo "3-er Schleife Param:$testparam;  Value:$testvalue; Option:$testoption"
				# Checking round_robin
				# Parameters could be: -rr
				# Values could be: False, True
				# Options could be: prime, non_prime, all
		 
				if [ ${!param} == "-rr" ]
				then 	validparam=1
					# echo "Parameter ist round_robin"
					round_robin ${!param} ${!value} ${!option}
				fi
	
	
				# Checking by_queue
				# Parameters could be: -byq
				# Values could be: False, True
				# Options could be: prime, non_prime, all
				
				if [ ${!param} == "-byq" ]
				then  	validparam=1
					# echo "Parameter ist by_queue"
					by_queue ${!param} ${!value} ${!option}
				fi

		
				# Checking strict_fifo
				# Parameters could be: -sf
				# Values could be: False, True
				# Options could be: prime, non_prime, all
				
				if [ ${!param} == "-sf" ]
				then  	validparam=1
					# echo "Parameter ist strict_fifo"
					strict_fifo ${!param} ${!value} ${!option}
				fi
		

				# Checking fair_share 
				# Parameters could be: -fs
				# Values could be: False, True
				# Options could be: prime, non_prime, all
		
				if [ ${!param} == "-fs" ]
				then  	validparam=1
					# echo "Parameter ist fair_share"
					fair_share ${!param} ${!value} ${!option}
				fi
				
		
				# Checking help_starving_jobs
				# Parameters could be: -sj
				# Values could be: False, True
				# Options could be: prime, non_prime, all
				
				if [ ${!param} == "-sj" ]
				then  	validparam=1
					# echo "Parameter ist starving_jobs"
					starving_jobs ${!param} ${!value} ${!option}
				fi
	
	
				# Checking sort_queues
				# Parameters could be: -sq
				# Values could be: False, True
				# Options could be: prime, non_prime, all
				
				if [ ${!param} == "-sq" ]
				then  	validparam=1
					# echo "Parameter ist sort_queues"
					sort_queues ${!param} ${!value} ${!option}
				fi
				

				# Checking load_balancing
				# Parameters could be: -lb
				# Values could be: False, True
				# Options could be: prime, non_prime, all
				
				if [ ${!param} == "-lb" ]
				then  	validparam=1
					# echo "Parameter ist load_balancing"
					load_balancing ${!param} ${!value} ${!option}
				fi
		

				# Checking sort_by
				# Parameters could be: -sb, -ms
				# Values could be: different sorts - defined in globals.c
				# Options could be: prime, non_prime, all
				
				if [ ${!param} == "-sb" ] || [ ${!param} == "-mus" ]
				then  	validparam=1
					# echo "Parameter ist sort_by"
					sort_by ${!param} ${!value} ${!option}
				fi

			fi

	                if [ ${testvalue:0:1} !=  "-" ] && [ ${testoption:0:1} == "-" ]
	                then
#	                        echo "2-er Schleife"
#	                        echo "Parameterset: ${!param}; ${!value}"
			
				# Checking log_filter
				# Parameters could be: -lf
				# Values could be: 1 - 256
				
				if [ ${!param} == "-lf" ]
				then  	validparam=1
					# echo "Parameter ist log_filter"
					log_filter ${!param} ${!value} ${!option}
				fi


				# Checking dedicated_prefix
				# Parameters could be: -dp
				# Values could be:

				if [ ${!param} == "-dp" ]
				then  	validparam=1
					# echo "Parameter ist dedicated_prefix"
					dedicated_prefix ${!param} ${!value} ${!option}
				fi


				# Checking max_starve
				# Parameters could be: -ms
				# Values could be: hh:mm:ss

				if [ ${!param} == "-ms" ]
				then  	validparam=1
					# echo "Parameter ist max_starve"
					max_starve ${!param} ${!value} ${!option}
				fi


				# Checking half_life
				# Parameters could be: -hl
				# Values could be: hh:mm:ss

				if [ ${!param} == "-hl" ]
				then  	validparam=1
					# echo "Parameter ist half_life"
					half_life ${!param} ${!value} ${!option}
				fi

				# Checking unknown_shares
				# Parameters could be: -us
				# Values could be:

				if [ ${!param} == "-us" ]
				then  	validparam=1
					# echo "Parameter ist unknown_shares"
					unknown_shares ${!param} ${!value} ${!option}
				fi


				# Checking sync_time
				# Parameters could be: -st
				# Values could be: hh:mm:ss
						
				if [ ${!param} == "-st" ]
				then  	validparam=1
					# echo "Parameter ist sync_time"
					sync_time ${!param} ${!value} ${!option}
				fi
	
	                fi

		fi
	fi

	if [ $(($n+1)) -eq $# ] # 2-Parameterset
	then 	param="$n"
             	value="$(($n+1))"
		testparam="${!param}"           #"Der" Parameter
                testvalue="${!value}"           #Wert
#		echo "2-er Set"
	        if [ ${testparam:0:1} == "-" ] && [ ${testvalue:0:1} != "-" ]
		then # echo "2-er Schleife; Param:$testparam;  Value:$testvalue"

			
				# Checking log_filter
				# Parameters could be: -lf
				# Values could be: 1 - 256
				
				if [ ${!param} == "-lf" ]
				then  	validparam=1
					# echo "Parameter ist log_filter"
					log_filter ${!param} ${!value} ${!option}
				fi


				# Checking dedicated_prefix
				# Parameters could be: -dp
				# Values could be:

				if [ ${!param} == "-dp" ]
				then  	validparam=1
					# echo "Parameter ist dedicated_prefix"
					dedicated_prefix ${!param} ${!value} ${!option}
				fi


				# Checking max_starve
				# Parameters could be: -ms
				# Values could be: hh:mm:ss

				if [ ${!param} == "-ms" ]
				then  	validparam=1
					# echo "Parameter ist max_starve"
					max_starve ${!param} ${!value} ${!option}
				fi


				# Checking half_life
				# Parameters could be: -hl
				# Values could be: hh:mm:ss

				if [ ${!param} == "-hl" ]
				then  	validparam=1
					# echo "Parameter ist half_life"
					half_life ${!param} ${!value} ${!option}
				fi

				# Checking unknown_shares
				# Parameters could be: -us
				# Values could be:

				if [ ${!param} == "-us" ]
				then  	validparam=1
					# echo "Parameter ist unknown_shares"
					unknown_shares ${!param} ${!value} ${!option}
				fi


				# Checking sync_time
				# Parameters could be: -st
				# Values could be: hh:mm:ss
						
				if [ ${!param} == "-st" ]
				then  	validparam=1
					# echo "Parameter ist sync_time"
					sync_time ${!param} ${!value} ${!option}
				fi
		fi
	fi	
	
	
	# Check for invalid Parameters, Values, Options
	
#		if [ $validparam == "0" ]
#		then echo "invalid Parameters"
#		exit
#		fi
	
#		if [ $validvalue == "0" ]
#		then echo "invalid Value"
#		exit
#		fi
		
#		if [ $validoption == "0" ]
#		then echo "invalid Options"
#		exit
#		fi
	
done
