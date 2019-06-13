############ Adapted from ############
#### https://www.astroml.org/book_figures/chapter8/fig_huber_func.html ####
######################################

import numpy as np
from matplotlib import pyplot as plt
import matplotlib as mpl
#----------------------------------------------------------------------
# This function adjusts matplotlib settings for a uniform feel in the textbook.
# Note that with usetex=True, fonts are rendered with LaTeX.  This may
# result in an error if LaTeX is not installed on your system.  In that case,
# you can set usetex to False.
from astroML.plotting import setup_text_plots
setup_text_plots(fontsize=8, usetex=True)


#------------------------------------------------------------
# Define the Huber loss
def Phi(t, c):
    t = abs(t)
    flag = (t > c)
    return (~flag) * (0.5 * t ** 2) - (flag) * c * (0.5 * c - t)

#------------------------------------------------------------
# Plot for several values of c
fig = plt.figure(figsize=(5, 3.75))
ax = fig.add_subplot(111)


cmap = plt.cm.get_cmap('RdBu')
mpl.style.use('seaborn')


line_colors = cmap(np.linspace(0,1,6))

x = np.linspace(-10, 10, 100)

for i, c in enumerate([0, 0.5, 2, 3, 5, 1000]):
    y = Phi(x, c)
    ax.plot(x, y, '-k', c=line_colors[i])

    if c > 10:
        s = r'\infty'
    else:
        s = str(c)

    ax.text(x[6], y[6], '$\delta=%s$' % s,
            ha='center', va='center',
            bbox=dict(boxstyle='round', ec='k', fc='w'))

ax.set_xlabel('$\delta$')
ax.set_ylabel(r'$L_\delta$')

plt.savefig('/Users/ssingh/Documents/EPFL_courses/Sem3/convex_optimization/project/loss.pdf', format='pdf', dpi=1000)
plt.show()