#!/bin/bash
FS_SCORE=0
test1=$(grep -io -e "taskid" -e "label" -e "loglevel" -e "logger" -e "duration" /opt/logstash/output.txt | sort -u |wc -l)
test2=$(grep -io -e "taskid" -e "label" -e "loglevel" -e "logger" -e "duration" -e "grok" /projects/challenge/pipeline.conf|wc -l)
test3=$(bash /opt/logstash/bin/logstash -t -f /projects/challenge/pipeline.conf | grep -i "Configuration OK" | wc -l)
if [[ $test1 -ge 5 ]]; then
	((FS_SCORE+=30));
fi

if [[ $test2 -ge 6 ]]; then
	((FS_SCORE+=30));
fi

if [[ $test3 -ge 1 ]]; then
	((FS_SCORE+=40));
fi

echo "FS_SCORE:$FS_SCORE%"
