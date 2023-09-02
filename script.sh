#!/usr/bin/env bash

files=$*

for file in $files
do
	echo "Running $file on test cases"

	for i in $(seq 3)
	do
		echo "Running test case $i:"
		echo "User output:"
		python3 $file < input$i.txt
		echo "Expected output:"
		cat output$i.txt
		echo "--------------------------------"
	done

done

echo "The language passed as argument is $language"

echo "User output:"
python3 $filename < input1.txt

echo "Expected output:"
cat output1.txt
