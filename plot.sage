from sage.all import *
import os

def create_plots_directory():
    if not os.path.exists("./build/plots"):
        os.makedirs("./build/plots")

def read_file(filename):
    if not os.path.exists("./build/data/" + filename):
        print(f"Fichier manquant : {filename}")
        return []  # Retourne une liste vide si le fichier n'existe pas
    data = []
    with open("./build/data/" + filename, 'r') as f:
        for line in f:
            n, t, time = map(float, line.split())
            data.append((n, time))
    return data

def create_plots(algorithm, color):
    for t in range(1, 4):  
        fast = Graphics()  
        slow = Graphics()
        for idx, alg in enumerate(algorithms):

            data = read_file(f"{alg}{t}.data")
            if not data: 
                print(f"Aucune donnée pour {alg} - Type {t}")
                continue

            linestyle = {1: "solid", 2: "dashed", 3: "dotted"}[t]
            color = colors[idx % len(colors)] 

            if(data[len(data) - 1][1] >= 100000):
                slow += line(data, legend_label=f"{alg} - Vector {t}", linestyle=linestyle, color=color)
            else:
                fast += line(data, legend_label=f"{alg} - Vector {t}", linestyle=linestyle, color=color)

        filename = f"vector_type{t}_{'aleatoire' if t == 1 else 'moitie_trie' if t == 2 else 'moitie_inverse'}.png"
        
        print()
        print(f"Create graphic for vector {t}")
        if (len(fast) > 0): 
            fast.show()
            fast.save("./build/plots/fast_alg_" + filename)  
        print(f"Save graphic with the name : fast_alg_{filename}")
        if (len(slow) > 0):
            slow.show()
            slow.save("./build/plots/slow_alg_" + filename)
        print(f"Save graphic with the name : slow_alg_{filename}")



algorithms = ["stdsort", "stable_sort", "qsort", "selection_sort", "insertion_sort", "bubble_sort", "quicksortdet", "quicksortrnd"]

# Couleurs pour chaque algorithme
colors = ["green", "orange", "purple", "cyan", "magenta", "black", "red", "blue"]

create_plots_directory()
create_plots(algorithms, colors)


