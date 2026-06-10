"""
01- collatz conjecture
Pick any n. If even → n/2. If odd → 3n+1. Repeat until you reach 1. 
Nobody has proven this always terminates. Nobody has disproven it.
Verified up to 2^68. It is "the simplest impossible problem."
"""

import matplotlib.pyplot as plt
import matplotlib.cm as cm

def collatz(n):
    """Generate the Collatz sequence from n down to 1.

    Uses 'yield' to produce one step at a time - no full list
    is built until we actually need it. Try it interactively:
        >>> list(collatz(6))
        [6, 3, 10, 5, 16, 8, 4, 2, 1]
    """
    while n != 1:
        yield n 
        n = n // 2 if n % 2 == 0 else 3 * n + 1
    yield 1

def visualize(max_n=200):
    sequences = [list(collatz(n)) for n in range(1, max_n + 1)]
    lengths = [len(s) for s in sequences]
    max_len = max(lengths)

    fig, ax = plt.subplots(figsize=(13,6))
    fig.patch.set_facecolor('#111111')
    ax.set_facecolor('#111111')

    # draw all sequences, colored by path length (short = dark, long = bright)
    cmap = cm.plasma
    for seq, length in zip(sequences, lengths):
        ax.plot(seq, color=cmap(length / max_len), alpha=0.25, linewidth=0.6)

    # highlight the longest sequence in white
    peak_i = lengths.index(max_len)
    ax.plot(
        sequences[peak_i],
        color='white', linewidth=1.4, zorder=5,
        label=f'n = {peak_i + 1} → {max_len} steps to reach 1'
    )

    ax.set_title(f'collatz conjecture  ・  n = 1 to {max_n}',
                 color='#cccccc', fontsize=13, pad=16, loc='left')
    ax.set_xlabel('step', color='#666666', fontsize=10)
    ax.set_ylabel('value', color='#666666', fontsize=10)
    ax.tick_params(colors='#555555', labelsize=9)
    for spine in ax.spines.values():
        spine.set_edgecolor('#2a2a2a')

    ax.legend(framealpha=0, labelcolor='#aaaaaa', fontsize=9)
    plt.tight_layout()
    plt.savefig('preview.png', dpi=150, bbox_inches='tight', facecolor='#111111')
    plt.show()

    # print a few observations to the console
    seq_27 = list(collatz(27))
    print(f'\nlongest path : n = {peak_i + 1} → {max_len} steps')
    print(f'fun fact   : n = 27 → {len(seq_27)} steps, peaks at {max(seq_27)}')
    
if __name__ == '__main__':
    visualize()