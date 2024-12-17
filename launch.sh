#!/bin/bash

# Variables
build_directory=$(pwd)/build
data_directory=$(pwd)/build/data
sort_directory=$(pwd)/sort

# Create the build directory if it does not exist
if [[ ! -d $build_directory ]]; then
    mkdir $build_directory
    mkdir $data_directory
fi

# Check if Sagemath is installed
clear
if ! command -v sage &> /dev/null; then
    echo "Error : Sagemath is not installed or is not in the PATH."
    exit 1
fi

run_algorithm() {
    # $1 is the algorithm to run
    local alg=$1

    # Compile the algorithm
    g++ -Wall -std=c++17 -Ofast -c -I. main.cpp
    mv main.o $build_directory
    g++ -Wall -std=c++17 -Ofast -c $sort_directory/$alg.cpp
    mv $alg.o $build_directory	
    g++ -Wall -Ofast -o $alg $build_directory/main.o $build_directory/$alg.o
    mv $alg $build_directory

    for t in 1 2 3
    do
        rm -f $data_directory/$alg$t.data 
        echo "Algorithm $alg with the vector $t"
        for n in $(seq 1000 100 100000); 
        do
            echo "vector $t of $n elements sorted by : $alg"
            timeout 10m $build_directory/$alg $n $t >> $data_directory/$alg$t.data
            
            ret=$?
            if [[ $ret -gt 120 ]]; then
                echo "Time exceeded or fatal error on $alg with the vector $t"
                break
            fi
        done

        if [[ ! -f "$data_directory/$alg$t.data" ]]; then
            echo "Error : $alg$t.data is missing !"
        fi
    done
    echo "Algorithm $alg has been run."
    rm -f $build_directory/$alg
    echo $alg ran successfully.
}

run_all_algorithms() {
    # Compile the main file
    g++ -Wall -std=c++17 -Ofast -c -I. main.cpp
    mv main.o $build_directory

    # Compile and run all the algorithms
    for alg in stdsort stable_sort qsort quicksortdet quicksortrnd selection_sort insertion_sort cant_believe_it_sort bubble_sort
    do
        g++ -Wall -std=c++17 -Ofast -c $sort_directory/$alg.cpp
        mv $alg.o $build_directory	
        g++ -Wall -Ofast -o $alg $build_directory/main.o $build_directory/$alg.o
        mv $alg $build_directory

        for t in 1 2 3
        do
            rm -f $data_directory/$alg$t.data 
            echo "Algorithm $alg with the vector $t"
            for n in $(seq 1000 1000 100000); 
            do
                echo "vector $t of $n elements sorted by sorting: $alg"
                timeout 10m $build_directory/$alg $n $t >> $data_directory/$alg$t.data
                
                ret=$?
                if [[ $ret -gt 120 ]]; then
                    echo "Time exceeded or fatal error on $alg with the vector $t"
                    break
                fi
            done

            if [[ ! -f "$data_directory/$alg$t.data" ]]; then
                echo "Error : $alg$t.data is missing !"
                exit 1
            fi
        done
        rm -f $build_directory/$alg
        echo $alg ran successfully.
    done
    
    echo "All algorithms have been run."

    echo "Creation of the plots."
    sage plot.sage
    echo "Plots have been created."
}

# Menu
echo "Select an option:"
echo "1) Run a specific algorithm"
echo "2) Run all algorithms"
echo "3) Create the plots"
echo "4) Quit"
read -p "Enter your choice: " choice

# Execute the choice
case $choice in
    1)
        # Select an algorithm
        echo "Available algorithms:"
        select alg in stdsort stable_sort qsort quicksortdet quicksortrnd selection_sort insertion_sort cant_believe_it_sort bubble_sort; do
            if [[ -n $alg ]]; then
                run_algorithm $alg
                break
            else
                echo "Invalid selection. Please try again."
            fi
        done
        ;;
    2)
        # Run all algorithms
        run_all_algorithms
        ;;

    3)
        # Create the plots
        echo "Creation of the plots."
        sage plot.sage
        echo "Plots have been created."
        ;;
    4)
        echo Quitting.
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Clean up
rm -f $build_directory/*.o
rm -f $build_directory/main
rm -f plot.sage.py
echo File cleanup complete.

exit 0