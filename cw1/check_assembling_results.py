#!/bin/env python3

from subprocess import call

call(['gzip', '-d', '--keep', '/tmp/mbi/sample_genome.fna.gz'])

cmd = 'docker run --rm -v /tmp/mbi:/tmp -w /tmp wkusmirek/quast quast.py -R'.split(' ')

files = [
    'sample_genome.fna',    # referencyjny
    'de_novo_output',       # wynik assemblingu
]

call(cmd + files)
