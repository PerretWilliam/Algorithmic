#!/bin/bash

g++ -Wall -Ofast -c main.cpp
for alg in stdsort stable_sort qsort selection_sort insertion_sort bubble_sort quicksortdet quicksortrnd
do
  echo Algorithm: $alg
  g++ -Wall -Ofast -c ./sort/$alg.cpp
  g++ -Wall -Ofast -o $alg main.o $alg.o
  for t in 1 2 3
  do
    rm $alg$t.data
    for i in $(seq 1 100)
    do
      n=$((i * 1000))
      echo $alg $n $t
      timeout 10m ./$alg $n $t >> $alg$t.data
      ret=$?
      if [[ $ret -gt 120 ]]
      then
        echo TIMEOUT OR CORE DUMP ON $alg $t
      break
      fi
    done
  done
done

rm *.o
echo Creating plots
sage plot.sage