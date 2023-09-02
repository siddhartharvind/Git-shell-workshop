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
			./file.out < input$i.txt > user_output$i.txt 2> $file_error$i.txt
			exit_code=$?

			if [[ $exit_code -eq 0 ]]
			then
				echo "Code ran without run-time errors"

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

			else
				echo "Code has run-time errors"
				cat $file_error$i.txt
			fi

			echo "------------------------------------------"
		done
		rm ./file.out
	done

fi
