### Done Task 5

language=$1
files=${*:2}
echo "The language passed as argument is $language"

if [[ "$language" != "C" ]]
then
	echo "Invalid language"

else

	for file in $files
	do
		gcc $file -o file.out
		echo "Running $file on test cases"
		for i in 1 2 3
		do
			echo "Running test case $i:"
			input_file=input$i.txt				# input file
			user_output_file=user_output$i.txt	# actual output
			exp_output_file=output$i.txt		# expected output
			err_file=${file}_error${i}.txt
			./file.out < $input_file > $user_output_file 2> $err_file
			exit_code=$?

			if [[ $exit_code -eq 0 ]]
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
				cat $err_file
			fi

			rm ./$user_output_file
			rm ./$err_file

			echo "------------------------------------------"
		done
		rm ./file.out
	done

fi
