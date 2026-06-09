"""
01- collatz conjecture
Pick any n. If even → n/2. If odd → 3n+1. Repeat until you reach 1. 
Nobody has proven this always terminates. Nobody has disproven it.
Verify up to 2^68. It is "the simpliest impossible problem."
"""

import matplotlib.pyplot as plt
import matplotlib.cm as cm

def collatz(n):
    """Generate the Collatz sequence from n down to 1.

    Uses 'yield' to produce one step at a time - no full list
    is built until we actually need it. Try it interactively:
        >>> list(collatz(6))
        [6 ,3 ,10 ,5 ,16 ,8 ,4 ,2 ,1]
    """
    while n != 1:
        yield n 
        n = n // 2 if n % 2 == 0 else 3 * n + 1
    yield 1