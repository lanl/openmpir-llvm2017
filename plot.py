import numpy as np
import matplotlib.pyplot as plt
import glob

pdat = {}
pdat['alignment'] = {'title' : "Alignment"}
pdat['fft'] = {'title' : "FFT"}
pdat['fib'] = {'title' : "Fibonacci"}
pdat['floorplan'] = {'title' : "Floorplan"}
pdat['health'] = {'title' : "Health"}
pdat['nqueens'] = {'title' : "NQueens"}
pdat['sort'] = {'title' : "Sort"}
pdat['sparselu'] = {'title' : "SparseLU"}
pdat['strassen'] = {'title' : "Strassen"}

types = ['tapir', 'icc', 'clang', 'gcc']

for p in pdat:
    for t in types:
        print(p, t)
        fs = glob.glob('./data/%s.%s.*' %(p,t))
        pdat[p][t] = [np.nan if len([l.split()[3] for l in open(f).readlines() if len(l.split()) > 3 and l.split()[0] == "Time"]) == 0
                         else float([l.split()[3] for l in open(f).readlines() if len(l.split()) > 3 and l.split()[0] == "Time"][0]) 
                         for f in fs]
        print(np.mean(pdat[p][t]))

width=0.75

for p in pdat:
    fig, ax = plt.subplots()
    means = [np.mean(pdat[p][t]) for t in types]
    means = [m for m in means if not np.isnan(m)]
    stds = [np.std(pdat[p][t]) for t in types]
    stds = [m for m in stds if not np.isnan(m)]
    ind = np.arange(len(means))
    ax.bar(ind, means, width, yerr=stds)
    ax.set_ylabel("Time (Seconds, lower is better)")
    ax.set_xticks(ind)
    ax.set_xticklabels(types)
    ax.set_title(pdat[p]['title'])
    plt.savefig('figs/%s.pdf' %(p))
    

