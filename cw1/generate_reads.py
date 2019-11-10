#!/bin/env python3
# coding=utf-8

from subprocess import call

cmd = 'docker run --rm -v mbi:/tmp -w /tmp wkusmirek/pirs pirs simulate'.split(' ')
params = [
    '--coverage', '50',          # pokrycie genomy odczytami: 50x
    '--insert-len-mean', '400',  # odległość pomiędzy sparowanymi końcami (average length of inserts) 400 bp
    '--insert-len-sd', '20',     # stddev powyższego
    '--read-len', '100',         # długość odczytów: 100 bp
    '--error-rate', '0.01',      # współczynnik błędów podstawienia 1%
    '--random-seed', '123',      # żeby eksperyment był powtarzalny
    'sample_genome.fna.gz'
]

call(cmd + params)
