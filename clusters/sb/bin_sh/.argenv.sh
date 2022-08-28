#!/usr/bin/env bash

# ========================================================================
# Copyright (c) 2020-2022 Netcrest Technologies, LLC. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ========================================================================

# OS_NAME in uppercase
OS_NAME=`uname`
OS_NAME=`echo "$OS_NAME"|awk '{print toupper($0)}'`

#
# .argenv.sh parses input arguments of individual scripts
# and assign appropriate parameters.
#

#
# Determine arguments
#
LAST_ARG=
DIAG_ARG=
DIAG_SPECIFIED=false
NO_COLOR=false
COUNT=
LONG=false
ALL=true
ALL_SPECIFIED=false
MEMBER_SPECIFIED=false
LOCATOR=
MEMBER=
TIMESTAMP=
PREV=

for i in "$@"
do
   if [[ "$i" != "-"* ]]; then
      # Options with previous value
      if [ "$PREV" == "-diag" ]; then
         DIAG_ARG=$i
      elif [ "$PREV" == "-count" ]; then
         COUNT=$i
      elif [ "$PREV" == "-locator" ]; then
         LOCATOR=$i
      elif [ "$PREV" == "-member" ]; then
         MEMBER=$i
      elif [ "$PREV" == "-timestamp" ]; then
         TIMESTAMP=$i
      fi

   else

      # All options
      if [ "$i" == "-diag" ]; then
         DIAG_SPECIFIED=true
      elif [ "$i" == "-no-color" ]; then
         NO_COLOR=true
      elif [ "$i" == "-long" ]; then
         LONG=true
      elif [ "$i" == "-all" ]; then
         ALL=true
         ALL_SPECIFIED=true
      elif [ "$i" == "-member" ]; then
         MEMBER_SPECIFIED=true
      elif [ "$i" == "-locator" ]; then
         LOCATOR_SPECIFIED=true
      fi
   fi
   PREV=$i

done

# Bash color code
if [ "$NO_COLOR" != "true" ]; then
  CNone='\033[0m' # No Color
  CBlack='\033[0;30m'
  CDarkGray='\033[1;30m'
  CRed='\033[0;31m'
  CLightRed='\033[1;31m'
  CGreen='\033[0;32m'
  CLightGreen='\033[1;32m'
  CBrownOrange='\033[0;33m'
  CYellow='\033[1;33m'
  CBlue='\033[0;34m'
  CLightBlue='\033[1;34m'
  CPurple='\033[0;35m'
  CLightPurple='\033[1;35m'
  CCyan='\033[0;36m'
  CLightCyan='\033[1;36m'
  CLightGray='\033[0;37m'
  CWhite='\033[1;37m'
  CUnderline='\033[4m'
  CUrl=$CBlue$CUnderline
  CHighlight=$CBrownOrange
  CError=$CLightRed
  CWarning=$CYellow
  CGo=$CLightGreen
  CCaution=$CBrownOrange
  CStop=$CLightRed
fi

# Tree characters
if [ "$PADOGRID_CHARSET" == "unicode" ] ;then
   # Unicode characters
   TBar='|'
   TTee='|--'
   TLel='`--'
else
   TBar='│'
   TTee='├──'
   TLel='└──'
fi

LAST_ARG=${@: -1}
