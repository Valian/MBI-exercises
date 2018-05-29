#!/bin/env python3

filePath = "data/coriell_chr1.sam"

with open(filePath , 'r') as f:
    lines = f.read().split('\n')
    mappings = lines[2:]
    mappings = [m.split() for m in mappings]
    mappings = [m[:11] for m in mappings if m]
    print(f'found {len(mappings)} mappings')

    # print('\n'.join(m))
    print('Average sequence length (TODO):')
    print(sum(map(int, [m[-3] for m in mappings])))
