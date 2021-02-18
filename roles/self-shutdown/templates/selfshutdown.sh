#!/bin/bash

uptime_minutes() {
  set `uptime -p`
  local minutes=0

  shift
  while [ -n "$1" ]; do
    case $2 in
      day*)
        ((minutes+=$1*1440))
        ;;
      hour*)
        ((minutes+=$1*60))
        ;;
      minute*)
        ((minutes+=$1))
        ;;
    esac
   shift
   shift
  done

  echo $minutes
}

minutes=$(uptime_minutes)
if [ "$minutes" -gt "{{ selfshutdown__time }}" ]; then
  echo "Shuting down server"
  /sbin/shutdown -h now
fi

if [ -f "/opt/shutdown_flag" ]; then
  echo "Shuting down server"
  /sbin/shutdown -h now
fi
