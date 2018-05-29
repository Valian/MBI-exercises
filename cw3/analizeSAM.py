#!/bin/env python3
import numpy as np

filePath = "data/coriell_chr1.sam"

with open(filePath , 'r') as f:
    lines = f.read().split('\n')
    mappings = lines[2:]
    mappings = [m.split() for m in mappings]
    mappings = [m[:11] for m in mappings if m]
    print(f'found {len(mappings)} mappings')

    print('Average sequence length:')
    lengths = [len(m[9]) for m in mappings]
    print(np.mean(lengths))
    print('Sequence length stddev:')
    print(np.std(lengths))
