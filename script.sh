#!/usr/bin/env bash

language=$1
files=${*:2}
num_testcases=3

echo "The language passed as argument is $language"

if [[ "$language" != "C" && "$language" != "Python" ]] ; then
	echo "Invalid language"
	exit 1
else
	echo "Language verified as $language"

	function get_command_name {
		# Takes single argument as name of file
		cmd="python3 $1"
		if [[ "$language" == "C" ]] ; then
			gcc $1 -o file.out
			cmd=./file.out
		fi
	}
fi

for file in $files
do
	# $cmd -> global variable from function `get_command_name`
	echo "Running $file on test cases"
	get_command_name $file

	for i in $(seq $num_testcases)
	do
		echo "Running test case $i:"

		input_file=input$i.txt						# input file
		exp_output_file=output$i.txt				# expected output
		user_output_file=user_${exp_output_file}	# actual output
		error_file=error.txt						# error file

		echo "$cmd < $input_file > $user_output_file 2> $error_file"
		$cmd < ${input_file} > ${user_output_file} 2> ${error_file}
		exit_code=$?

		if [[ ${exit_code} == 0 ]]
		then
			echo "Code ran without run-time errors"

			passed=$(diff $exp_output_file $user_output_file)

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

		rm ./$user_output_file
		echo "------------------------------------------"

	done

done

rm ./${error_file}

if [[ "$language" == "C" ]] ; then
	rm $cmd
fi

