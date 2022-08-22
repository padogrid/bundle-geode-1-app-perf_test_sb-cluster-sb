#!/usr/bin/env bash

#
# Displays the recovery steps for the specified type.
#
# @env RECOVERY_SPECIFIED If "true" displays the recovery steps.
# @env SHOW_OPTS Options such as '-no-color' to pass on to 'show_recovery_steps'.
#
# @param type  0|1|2|3|4|5  All other values are sliently ignored.
#
function show_recovery
{
   if [ "$RECOVERY_SPECIFIED" == "true" ]; then
      local TYPE_ARG="$1"
      if [[ $TYPE_ARG =~ [012345] ]]; then
         ./show_recovery_steps -type $TYPE_ARG $SHOW_OPTS
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
   local timestamp="$@"
   local time_in_seconds
   if [ "$timestamp" == "" ]; then
      time_in_seconds="0"
   else
      local date=$(echo $timestamp |  awk '{print $1} ')
      local time=$(echo $timestamp |  awk '{print $2}')
      date=$(echo $date | sed 's/-/\//g')
      # remove milliseconds
      time=$(echo $time | sed 's/\..*//')
      if [ "$OS_NAME" == "DARWIN" ]; then
         local time_in_seconds=$(date -jf "%Y/%m/%d %H:%M:%S" "$date $time" +%s)
      else
         local time_in_seconds=$(date -d "$date $time" +"%s")
      fi
      if [ "$time_in_seconds" == "" ]; then
         time_in_seconds="0"
      fi
   fi
   echo $time_in_seconds
}

#
# Returns trimmed string
# @param String to trim
#
function trimString
{
    local var="$1"
    # remove leading whitespace characters
    var="${var#"${var%%[![:space:]]*}"}"
    # remove trailing whitespace characters
    var="${var%"${var##*[![:space:]]}"}"   
    echo -n "$var"
}

#
# Returns a string list with all duplicate words removed from the specified string list.
# @param stringList String list of words separated by spaces
#
function unique_words
{
   local __words=$1
   local  __resultvar=$2
   local __visited
   local __unique_words
   local __i
   local __j

   # remove all repeating hosts
   for __i in $__words; do
      __visited=false
      for __j in $__unique_words; do
         if [ "$__i" == "$__j" ]; then
            __visited=true
         fi
      done
      if [ "$__visited" == "false" ]; then
         __unique_words="$__unique_words $__i"
      fi
   done

   if [[ "$__resultvar" ]]; then
      eval $__resultvar="'$__unique_words'"
      #echo `trimString "$__resultvar"`
   else
     echo `trimString "$__unique_words"`
   fi
}
