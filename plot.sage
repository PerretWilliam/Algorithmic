def readFile(filename):
    """Lit un fichier et retourne une liste de listes contenant des floats."""
    v = []
    with open(filename) as f:
        for line in f:
            v.append([float(x) for x in line.split()])
    return v

def create_curve(tab, color, index):
  if len(tab) > 1:
    spline_interpolation = spline(tab)

    curve = plot(spline_interpolation, min(x for x, y in tab), max(x for x, y in tab), color=color, legend_label="vector" + str(index))
    return curve

def create_plot(alg):

  colors=["green", "pink", "red"]
  g = Graphics()

  for i in range(1, 4):
    color = colors[i - 1]
    tab = []
    v = readFile(alg + str(i) + ".data") 
    elements = 1000

    for elt in v:
      tab.append((elements, elt[0]))
      elements += 1000
    g += create_curve(tab, color, i)     
    g += point(tab, color=color, size=20)
  g.axes_label_color((1,1,1))
  g.save(alg + ".png", title=alg, figsize=(14, 10), axes_labels=['Elements', 'Time (in microsenconds)'], xmax=100000)

algs = ["stdsort", "stable_sort", "qsort", "selection_sort", "insertion_sort", "bubble_sort", "quicksortdet", "quicksortrnd"]

for alg in algs:
  create_plot(alg)


