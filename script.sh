#!/usr/bin/env bash

### Done Task 3
for file in $*
do
	gcc $file -o file.out
	echo "Running $file on test cases"
	for i in 1 2 3
	do
		echo "Running test case $i:"
		# echo "./file.out < input$i.txt > user_output$i.txt 2> /dev/null"
		./file.out < input$i.txt > user_output$i.txt 2> /dev/null

		passed=$(diff output$i.txt user_output$i.txt)
		if [[ "$passed" == "" ]]
		then
			echo "Test case $i passed"
		else
			echo "Test case $i failed"
			echo "User output:"
			cat user_output$i.txt
			echo "Expected output:"
			cat output$i.txt
		fi
		echo "------------------------------------------"
	done
	rm ./file.out
done
