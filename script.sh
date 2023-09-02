# Task 1: 
# The first argument provided from cmd must be the language you are running it in
# Just plainly print the first argument that was provided 
# The second argument is the name of the python/C file that must be run 
# Run the python file, using input1.txt as stdin, and write the output to a file user_output1.txt 
# Display user_output1.txt to the user as user output, and the file output1.txt as the expected output 
# Once you have tested out the script and verified it's working, commit it to a branch: <your_name>


### Task 3
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


### Task 2
# for file in $*
# do
# 	echo "Running $file on test cases"
# 	for i in 1 2 3
# 	do
# 		echo "Running test case $i:"
# 		gcc file$i.c
# 		echo "User output:"
# 		./a.out < input$i.txt
# 		echo "Expected output:"
# 		cat output$i.txt
# 		echo "------------------------------------------"
# 	done
# done

# rm ./a.out


### Task 1
# echo The language passed as argument is $1
# echo User output:

# gcc $2
# ./a.out < input1.txt

# echo Expected output:
# cat output1.txt

# rm ./a.out
