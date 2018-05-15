#!/bin/env python3
import glob
file = glob.glob(
    '/tmp/mbi2/single_scaffold.fa.maker.output/single_scaffold.fa_datastore/**/**/**/*.gff')
assert len(file) == 1
file = file[0]
with open(file, 'r') as f:
    lines = f.read().split('\n')

print('-'*50)
print('10 first lines of .gff file')
print('\n'.join(lines[:10]))

print('-'*50)
for l in lines:
    if l.find('expressed_sequence_match') != -1:
        print('found line:\n', l)
        l = [i for i in l.split() if i]
        i, j = l[3:5]
        print()
        print('expressed_sequence_match', i, j)
        break

print('-'*50)
print('Nucleotides of the sequence')
with open('/tmp/mbi2/single_scaffold.fa', 'r') as f:
    nucleotides = f.read().split('\n')
    nucleotides = ''.join(nucleotides[1:])
    print(nucleotides[int(i):int(j)])
