#!/bin/bash

#      user    nice   system  idle      iowait irq   softirq  steal  guest  guest_nice
# cpu  74608   2520   24433   1117073   6176   4054  0        0      0      0

# PrevIdle = previdle + previowait
# Idle = idle + iowait  
# IDLE=${CPU[1]}
# 
# PrevNonIdle = prevuser + prevnice + prevsystem + previrq + prevsoftirq + prevsteal
# NonIdle = user + nice + system + irq + softirq + steal
# 
# PrevTotal = PrevIdle + PrevNonIdle
# Total = Idle + NonIdle
# 
# # differentiate: actual value minus the previous one
# totald = Total - PrevTotal
# idled = Idle - PrevIdle
# 
# CPU_Percentage = (totald - idled)/totald

PRE_CPU=(`cat /proc/stat | grep '^cpu'`);
unset PRE_CPU[0];

let PRE_IDLE=$((${PRE_CPU[4]}+${PRE_CPU[5]}));
let PRE_NON_IDLE=$((${PRE_CPU[1]}+${PRE_CPU[2]}+${PRE_CPU[3]}+${PRE_CPU[6]}+${PRE_CPU[7]}+${PRE_CPU[8]}));
let PRE_TOTAL=$(($PRE_IDLE+$PRE_NON_IDLE));

sleep 1;

CUR_CPU=(`cat /proc/stat | grep '^cpu'`);
unset CUR_CPU[0];

let CUR_IDLE=$((${CUR_CPU[4]}+${CUR_CPU[5]}));
let CUR_NON_IDLE=$((${CUR_CPU[1]}+${CUR_CPU[2]}+${CUR_CPU[3]}+${CUR_CPU[6]}+${CUR_CPU[7]}+${CUR_CPU[8]}));
let CUR_TOTAL=$(($CUR_IDLE+$CUR_NON_IDLE));

let IDLE_DIFF=$(($CUR_IDLE-$PRE_IDLE));
let TOTAL_DIFF=$(($CUR_TOTAL-$PRE_TOTAL));

echo "($TOTAL_DIFF-$IDLE_DIFF)*100/$TOTAL_DIFF" | bc; 

