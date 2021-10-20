#!/bin/bash

function displayduration {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  
  if [[ ${D} != 0 ]]
  then
     printf '%d days %02d:%02d:%02d' $D $H $M $S
  else
     printf '%02d:%02d:%02d' $H $M $S
  fi
  
}

BAKUP_DIR=/opt/JCR_export
START="$(date +%s)"
STARTDATE="$(date -u -d @$START +%T)"
BACKUP_FILE="JCRExport.$(date '+%Y%m%d_%H%M%S').tar.gz"
PORTAL_ADMIN_ID=wpsadmin
PORTAL_ADMIN_PWD=wpsadmin
WAS_ADMIN_ID=wpsadmin
WAS_ADMIN_PWD=wpsadmin

echo
echo
echo "---------------------------------------------------------------------------------"
echo
echo "  _   _    ____   _     ";
echo " | | | |  / ___| | |    ";
echo " | |_| | | |     | |    ";
echo " |  _  | | |___  | |___ ";
echo " |_| |_|  \____| |_____|";
echo "                        ";
echo
echo "---------------------------------------------------------------------------------"
echo "                    WCM Export Initiator Script"
echo "---------------------------------------------------------------------------------"
echo 
echo "Start time: $STARTDATE"
echo 


tar -czf $BACKUP_FILE $BAKUP_DIR

rm -rf $BAKUP_DIR

/opt/IBM/WebSphere/PortalServer/config/WPSconfig.sh export-wcm-data -DPortalAdminId=${PORTAL_ADMIN_ID} -DPortalAdminPwd=${PORTAL_ADMIN_PWD} -DWasUserid=${WAS_ADMIN_ID} -DWasPassword=${WAS_ADMIN_PWD}

DURATION=$[ $(date +%s) - ${START} ]

echo 
echo "---------------------------------------------------------------------------------"
echo "---------------------------------------------------------------------------------"
echo 
echo "Start time was $STARTDATE"
echo "File location is $BAKUP_DIR/$BACKUP_FILE"
echo "Duration was $(displayduration DURATION)"
echo 
echo "---------------------------------------------------------------------------------"
echo "---------------------------------------------------------------------------------"
