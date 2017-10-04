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

colors=['#2D8632', '#236467', '#AA6D39', '#AA3C39']

for p in ['alignment', 'fft', 'fib', 'nqueens', 'sort', 'sparselu', 'strassen']:
    fig, ax = plt.subplots()
    means = [np.mean(pdat[p][t]) for t in types]
    means = [m for m in means if not np.isnan(m)]
    stds = [np.std(pdat[p][t]) for t in types]
    stds = [m for m in stds if not np.isnan(m)]
    ind = np.arange(len(means))
    ax.bar(ind, means, width, yerr=stds, color=colors)
    ax.set_ylabel("Time (Seconds, lower is better)")
    ax.set_xticks(ind)
    ax.set_xticklabels(types)
    ax.set_title(pdat[p]['title'])
    plt.savefig('figs/%s.pdf' %(p))

for p in ['health', 'floorplan']: 
    fig = plt.figure()
    axb = fig.add_subplot(111)
    ax = fig.add_subplot(211)
    ax2 = fig.add_subplot(212, sharex=ax)

    means = [np.mean(pdat[p][t]) for t in types]
    means = [m for m in means if not np.isnan(m)]
    stds = [np.std(pdat[p][t]) for t in types]
    stds = [m for m in stds if not np.isnan(m)]
    ind = np.arange(len(means))
    ax.bar(ind, means, width, yerr=stds, color=colors)
    ax2.bar(ind, means, width, yerr=stds, color=colors)
    if p == 'health':
        ax.set_ylim(420, 480)
        ax2.set_ylim(0, 20)
    if p == 'floorplan':
        ax.set_ylim(170, 190)
        ax2.set_ylim(0,3)


# hide the spines between ax and ax2
    ax.spines['bottom'].set_visible(False)
    ax2.spines['top'].set_visible(False)
    ax.xaxis.tick_top()
    ax.tick_params(labeltop='off')  # don't put tick labels at the top
    ax2.xaxis.tick_bottom()

# This looks pretty good, and was fairly painless, but you can get that
# cut-out diagonal lines look with just a bit more work. The important
# thing to know here is that in axes coordinates, which are always
# between 0-1, spine endpoints are at these locations (0,0), (0,1),
# (1,0), and (1,1).  Thus, we just need to put the diagonals in the
# appropriate corners of each of our axes, and so long as we use the
# right transform and disable clipping.

    d = .015  # how big to make the diagonal lines in axes coordinates
# arguments to pass to plot, just so we don't keep repeating them
    kwargs = dict(transform=ax.transAxes, color='k', clip_on=False)
    ax.plot((-d, +d), (-d, +d), **kwargs)        # top-left diagonal
    ax.plot((1 - d, 1 + d), (-d, +d), **kwargs)  # top-right diagonal

    kwargs.update(transform=ax2.transAxes)  # switch to the bottom axes
    ax2.plot((-d, +d), (1 - d, 1 + d), **kwargs)  # bottom-left diagonal
    ax2.plot((1 - d, 1 + d), (1 - d, 1 + d), **kwargs)  # bottom-right diagonal

    axb.set_ylabel("Time (Seconds, lower is better)")
    axb.spines['top'].set_color('none')
    axb.spines['bottom'].set_color('none')
    axb.spines['left'].set_color('none')
    axb.spines['right'].set_color('none')
    axb.tick_params(labelcolor='w', top='off', bottom='off', left='off', right='off')

    ax.set_xticks(ind)
    ax.set_xticklabels(types)
    ax.set_title(pdat[p]['title'])
    plt.savefig('figs/%s.pdf' %(p))
