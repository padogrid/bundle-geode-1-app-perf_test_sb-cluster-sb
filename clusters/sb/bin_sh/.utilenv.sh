#!/usr/bin/env bash

#
# Displays the recovery steps for the specified type.
#
# @required RECOVERY_SPECIFIED If "true" displays the recovery steps.
#
# @param type  0|1|2|3|4|5  All other values are sliently ignored.
#
function show_recovery
{
   if [ "$RECOVERY_SPECIFIED" == "true" ]; then
      local TYPE_ARG="$1"
      if [[ $TYPE_ARG =~ [012345] ]]; then
         ./show_recovery_steps -type $TYPE_ARG
      fi
   fi
}

#
# Converts the specified timstamp to seconds.
#
# @param timestamp  Timestamp in the format, 'yyyy/mm/dd hh:mm:ss'.
#
function get_time_in_seconds
{
   timestamp="$@"
   local date=$(echo $timestamp |  awk '{print $1} ')
   local time=$(echo $timestamp |  awk '{print $2}')
   date=$(echo $date | sed 's/-/\//g')
   if [ "$OS_NAME" == "DARWIN" ]; then
      local time_in_seconds=$(date -jf "%Y/%m/%d %H:%M:%S" "$date $time" +%s)
   else
      local time_in_seconds=$(date -d "$date $time" +"%s")
   fi
   echo $time_in_seconds
}
