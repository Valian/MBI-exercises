#!/bin/env python3

from subprocess import call

call('docker run --rm -v mbi:/tmp -w /tmp wkusmirek/quast gzip -d --keep sample_genome.fna.gz'.split(' '))
cmd = 'docker run --rm -v mbi:/tmp -w /tmp wkusmirek/quast quast.py -R'.split(' ')
files = [
    'sample_genome.fna',    # referencyjny
    'de_novo_output',       # wynik assemblingu
]
call(cmd + files)
