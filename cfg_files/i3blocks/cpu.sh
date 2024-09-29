#/bin/sh

jiffs1=$(cat /proc/stat | grep -E  "^cpu \s*" | sed 's/cpu//g');
total1=0;
work1=0
index1=0
for i in $jiffs1; do
    #echo $i;
    if [ $index1 -lt 3 ]; then
        work1=$(($work1 + $i));
    fi
    total1=$(($total1 + $i));
    index1=$(($index1+1));

done
# echo "Total is: $total1";
# echo "Work is: $work1";
# echo "Length is: $index1";


sleep 0.1;


jiffs2=$(cat /proc/stat | grep -E  "^cpu \s*" | sed 's/cpu//g');
total2=0;
work2=0
index2=0
for j in $jiffs2; do
    #echo $i;
    if [ $index2 -lt 3 ]; then
        work2=$(($work2 + $j));
    fi
    total2=$(($total2 + $j));
    index2=$(($index2+1));

done

# echo "Total is: $total2";
# echo "Work is: $work2";
# echo "Length is: $index2";


wop=$(($work2 - $work1));
top=$(($total2 - $total1));

# echo "work_p : $wop";
# echo "tot_p : $top";

usage=$(($wop/$top));
percentage=$(echo "scale=2; $wop/$top*100" | bc -l);
echo "$percentage%  "

