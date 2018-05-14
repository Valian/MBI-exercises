#!/bin/env python3
import re

MIN_SCAFFOLD_LENGTH = 100 * 1000 #  100 kbp

with open('/tmp/mbi2/genome.fa', 'r') as f:
    prefix = 'HDID_scaffold'
    scaffolds = list(filter(lambda x: x[:len(prefix)]==prefix, f.read().split('>')))
    print('found', len(scaffolds), 'scaffolds')
    regex = r'HDID_scaffold(\d+) length=(\d+)'
    regex =re.compile(regex)
    for s in scaffolds:
        match = regex.match(s)
        scaffold_id, scaffold_length = match.group(1,2)
        if int(scaffold_length) >= MIN_SCAFFOLD_LENGTH:
            print('got scaffold', scaffold_id, 'of length', scaffold_length)
            break

with open('/tmp/mbi2/single_scaffold.fa', 'w') as f:
    # header = (s.split('\n')[0]).split(' ')[0]
    # f.write(header + '\n' + '\n'.join(s.split('\n')[1:]))
    f.write(s)
