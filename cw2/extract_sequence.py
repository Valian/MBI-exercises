#!/bin/env python3
import re
import random


MIN_SCAFFOLD_LENGTH = 100 * 1000 #  100 kbp

with open('/tmp/mbi2/genome.fa', 'r') as f:
    prefix = 'HDID_scaffold'
    scaffolds = list(filter(lambda x: x[:len(prefix)]==prefix, f.read().split('>')))
    print('found', len(scaffolds), 'scaffolds')
    regex = r'HDID_scaffold(\d+) length=(\d+)'
    regex = re.compile(regex)
    valid_scaffolds = [s for s in scaffolds if int(regex.match(s).group(2)) >= MIN_SCAFFOLD_LENGTH]
    print('found ', len(valid_scaffolds), ' scaffolds longer than ', MIN_SCAFFOLD_LENGTH)
    chosen_scaffold = random.choice(valid_scaffolds)
    scaffold_id, scaffold_length = regex.match(chosen_scaffold).group(1, 2)
    print('got scaffold', scaffold_id, 'of length', scaffold_length)

    with open('/tmp/mbi2/single_scaffold.fa', 'w') as f:
        # header = (s.split('\n')[0]).split(' ')[0]
        # f.write(header + '\n' + '\n'.join(s.split('\n')[1:]))
        f.write('>' + chosen_scaffold)
