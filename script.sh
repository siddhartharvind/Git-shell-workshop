#!/usr/bin/env bash

files=$*

for file in $files
do
	echo "Running $file on test cases"

	for i in $(seq 3)
	do
		input_file=input$i.txt
		exp_output_file=output$i.txt
		user_output_file=user_${exp_output_file}
		error_file=error_file.txt

		echo "Running test case $i:"
		python3 $file < $input_file > $user_output_file 2> $error_file
		exit_code=$?

		if [[ $exit_code == 0 ]]
		then
			echo "Code ran without run-time errors"

			passed=$(diff $user_output_file $exp_output_file)
			if [[ "$passed" == "" ]]
			then
				echo "Test case $i passed"
			else
				echo "Test case $i failed"
				echo "User output:"
				cat $user_output_file
				echo "Expected output:"
				cat $exp_output_file
			fi

		else
			echo "Code has run-time errors"
			cat $error_file
		fi		

		echo "--------------------------------"
		rm ./$user_output_file

	done
done

rm ./$error_file
