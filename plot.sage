from sage.all import *
import os

def create_plots_directory():
    if not os.path.exists("./build/plots"):
        os.makedirs("./build/plots")

def read_file(filename):
    if not os.path.exists("./build/data/" + filename):
        print(f"Missing file: {filename}")
        return []  # Return an empty list if the file does not exist
    data = []
    with open("./build/data/" + filename, 'r') as f:
        for line in f:
            n, t, time = map(float, line.split())
            data.append((n, time))
    return data

def create_plots(algorithm, color):
    # Create the plots for each type of vector
    for t in range(1, 4):  
        # Create the graphics
        fast = Graphics()  
        slow = Graphics()
        
        # Create the lines for each algorithm
        for idx, alg in enumerate(algorithms):
            data = read_file(f"{alg}{t}.data")
            if not data: 
                print(f"Aucune donnée pour {alg} - Type {t}")
                continue

            # Create the line
            linestyle = {1: "solid", 2: "dashed", 3: "dotted"}[t]
            color = colors[idx % len(colors)] 
            
            # Add the line to the graphics
            if(alg == "stdsort" or alg == "stable_sort" or alg == "qsort" or alg == "quicksortrnd"): 
                fast += line(data, legend_label=f"{alg} - Vector {t}", linestyle=linestyle, color=color, axes_labels=['Vector size', 'time'], title=f"Vector {t}")
            else:
                slow += line(data, legend_label=f"{alg} - Vector {t}", linestyle=linestyle, color=color, axes_labels=['Vector size', 'time (ms * 10⁷)'], title=f"Vector {t}")

        # Create the filename
        filename = f"vector_type{t}_{'random' if t == 1 else 'half_sorted' if t == 2 else 'half_sorted_invers'}.png"
        
        print()

        # Show and save the graphics
        print(f"Create graphic for vector {t}")
        if (len(fast) > 0): 
            fast.show()
            fast.save("./build/plots/fast_alg_" + filename)  
            print(f"Save graphic with the name : fast_alg_{filename}")
        if (len(slow) > 0):
            slow.show()
            slow.save("./build/plots/slow_alg_" + filename)
            print(f"Save graphic with the name : slow_alg_{filename}")

# List of algorithms
algorithms = ["stdsort", "stable_sort", "qsort", "selection_sort", "insertion_sort", "bubble_sort", "quicksortdet", "quicksortrnd", "cant_believe_it_sort"]

# Color for each algorithm
colors = ["green", "orange", "purple", "cyan", "magenta", "black", "red", "blue", "brown"]

# Create the plots directory
create_plots_directory()

# Create the plots
create_plots(algorithms, colors)


