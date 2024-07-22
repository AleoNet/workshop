#!/bin/bash
# A script to check that all examples compile and run.
# Run this script from the root directory of the workshop repository.
# Note that this script is expected to run successfully.

#!/bin/bash
# A script to check that all examples compile and run.
# Run this script from the root directory of the workshop repository.
# Note that this script is expected to run successfully

# Function to check and run scripts in each directory.
function check_example(){
    local name=$1
    # Check if the directory exists
    if [ ! -d $name ]
    then
        echo "ERROR: Directory $name does not exist."
        return 1
    fi

    cd $name || exit 
    echo "CHECK: CHECKING THE $(echo "$name" | tr '[:lower:]' '[:upper:]') EXAMPLE"

    # Check if the run.sh sript exists
    if [ ! -f ./run.sh ]
    then
        echo "ERROR: run.sh not found in $name."
        cd ..
        return 1
    fi

    #Make the run.sh script executable and run it
    chmod +x ./run.sh
    ./run.sh || { echo "ERROR: Failed to execute run.sh in $name."; cd ..; return 1; }
    cd ..
}

# A list of all the examples
examples_list=("auction" "basic_bank" "battleship" "tictactoe" "token" "vote")


# Loop through each example and check it
for example in ${examples_list[@]}
do
    if ! check_example $example
    then
        echo "ERROR: An error occured while checking $example"
    fi
done
