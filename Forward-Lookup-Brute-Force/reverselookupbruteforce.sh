#!/bin/bash

echo 'hello' $1

for line in $(cat list.txt); 
  do host $line.megacorpone.com; 
done
