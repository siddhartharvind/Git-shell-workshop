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
		

		echo "Running test case $i:"
		python3 $file < $input_file > $user_output_file
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

		echo "--------------------------------"
		rm ./$user_output_file

	done
done

echo "The language passed as argument is $language"

echo "User output:"
python3 $filename < input1.txt

echo "Expected output:"
cat output1.txt
