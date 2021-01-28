#!/bin/bash
passed=0
failed=0
test1=$(grep -io -e "taskid" -e "label" -e "loglevel" -e "logger" -e "duration" /opt/logstash/output.txt | sort -u |wc -l)
test2=$(grep -io -e "taskid" -e "label" -e "loglevel" -e "logger" -e "duration" -e "grok" /projects/challenge/pipeline.conf | wc -l)
test3=$(bash /opt/logstash/bin/logstash -t -f /projects/challenge/pipeline.conf | grep -i "Configuration OK" | wc -l)
if [[ test1 -ge 5 ]]; then
	echo "testcase 1 passed";
	((passed+=1));
else
	echo "testcase 1 failed, Does not match the required output";
	((failed+=1));
fi


if [[ test2 -ge 6 ]]; then
	echo "testcase 2 passed";
	((passed+=1));
else
	echo "testcase 2 failed, Grok filter doesn't match the required pattern";
	((failed+=1))
fi

if [[ test3 -ge 1 ]]; then
	echo "testcase 3 passed";
	((passed+=1));
else
	echo "testcase 3 failed, invalid pipeline configuration";
	((failed+=1))
fi


echo "Total no of testcases: 3"
echo "No of testcases cleared:" $passed
echo "No of testcases failed:" $failed
