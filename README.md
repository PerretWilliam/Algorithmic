# Project SAE S1.02

## Description
This project is a C++ program that implements the following sorting algorithms: stdsort, stable_sort, qsort, quicksortrnd, quicksortdet, bubble sort, insertion sort, selection sort. The program generates three vector : random, half sorted, half reverse sorted and sorts them with the different algorithms. The program then plots the results of the sorting algorithms.

## Struct of the project
- `launch.sh` : Launch a selection menu to run the different scripts.
- `plot.sage` : SageMath script to plot the results of the sorting algorithms.
- `sort/` : Contains the C++ source code for the sorting algorithms.
- `main.cpp` : Main C++ source code to run the sorting algorithms.

## Prerequisites
- Python 3.x
- SageMath
- g++ version 7.1.0 or higher

## Usage

### Launch the script
Launch the script `launch.sh` to run the different scripts.
> If the script doesn't have the permission to execute, run the following command `chmod +x launch.sh`.

```bash
chmod +x launch.sh
```

```bash
./launch.sh
```

### Menu
You will have this menu :

Select an option:
1) Run a specific algorithm"
2) Run all algorithms"
3) Create the plots"
4) Quit
"Enter your choice:

- Option 1 : Run a specific algorithm
- Option 2 : Run all algorithms and create the plots
- Option 3 : Create the plots
> You must have all the data to create the plots.
- Option 4 : Quit the script

### Directory and file creation
- The program will create if it doesn't exist the folder `data/` and will generate the data for the different sorting algorithms in the format `algorithm{vector}.data`, three data for each algorithm, one for the random vector, one for the half sorted vector and one for the half reverse sorted vector will be created. 

- The program will then create the plots of the data in the folder `plots/` in the format `plot.png`, you will have six graphs, three for the random vector, half sorted vector and half reverse sorted vector, with the **fast** algorithms and the three for the **slow** algorithms.

- These folders and files will be create in the `build/` folder.

> The object files and the executable will be created in the `build/` folder then deleted after the execution of the program.

## Author
- Perret William

## License
This project is under MIT license.
