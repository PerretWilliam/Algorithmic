#!/bin/bash
build_directory=$(pwd)/build
data_directory=$(pwd)/build/data
sort_directory=$(pwd)/sort

if [[ ! -d $build_directory ]]; then
    mkdir $build_directory
    mkdir $data_directory
fi

echo Check if Sagemath is installed
if ! command -v sage &> /dev/null; then
    echo "Error : Sagemath is not installed or is not in the PATH."
    exit 1
fi

run_algorithm() {
    local alg=$1

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
        for n in $(seq 1000 1000 100000); 
        do
            echo "vector of $n elements sorted by sorting: $alg"
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
    rm -f $build_directory/$alg
}

run_all_algorithms() {
    g++ -Wall -std=c++17 -Ofast -c -I. main.cpp
    mv main.o $build_directory

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
                echo "vector of $n elements sorted by sorting: $alg"
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
        rm -f $build_directory/$alg
    done
    
    echo "Creation of the plots."
    sage plot.sage
}

echo "Select an option:"
echo "1) Run a specific algorithm"
echo "2) Run all algorithms"
echo "3) Create the plots"
echo "4) Quit"
read -p "Enter your choice: " choice

case $choice in
    1)
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
        run_all_algorithms
        ;;

    3)
        echo "Creation of the plots."
        sage plot.sage
        exit 0
        ;;
    4)
        echo Quitting.
        exit 0
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

rm -f $build_directory/*.o
rm -f $build_directory/main

# Example usage:
# run_algorithm stdsort