#!/bin/bash
HNAME=`echo $HOSTNAME`
DATE=`date +%d%h%Y-%H:%M:%S`
#fetch name of the parent script 
PCOMMAND="$(ps -o args= $PPID)"
VALUE="$PCOMMAND $DATE"

DEVOPSONCALLURL=`consul kv get consul-alerts/config/notifiers/twilio/devops-oncall-url`
DEVOPSNUMBERS=`consul kv get consul-alerts/config/notifiers/twilio/devops-numbers && curl $DEVOPSONCALLURL | grep -A 3 -i "<th> ONCALL </th>" | grep '[0-9]' | cut -c10-19`
XPOST=`consul kv get consul-alerts/config/notifiers/twilio/xpost-url`
VOICE=`consul kv get consul-alerts/config/notifiers/twilio/voice-xml`
KEY=`consul kv get consul-alerts/config/notifiers/twilio/user-key`
FROM=`consul kv get consul-alerts/config/notifiers/twilio/from-number`
PROXY=`consul kv get consul-alerts/config/notifiers/twilio/proxy-url`
sleep 120
`consul kv put consul-alerts/config/notifiers/twilio/call-history/$HNAME "$VALUE"`
export http_proxy="$PROXY" && export https_proxy="$PROXY" && for i in $DEVOPSNUMBERS; do curl -XPOST "$XPOST" -d Url="$VOICE" -d To=+91$i -d From="$FROM" -u "$KEY"; done

