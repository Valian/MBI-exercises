#!/bin/env python3

from subprocess import call

cmd = 'docker run --rm -v mbi:/tmp -w /tmp wkusmirek/dnaasm dnaasm -assembly'.split(' ')
params = [
    '-k', '55',          	 	  	# wymiar grafu de Bruijn'a: 55
    '-genome_length', '5369772',     	  	# dlugosc genomu, liczba nukleotydow w badanej sekwencji DNA bakterii
    '-paired_reads_algorithm', '1',		# wlaczenie parowanych odczytow
    '-insert_size_mean_inward', '400',    	# moda odleglosci pomiedzy sparowanymi odczytami: 400 bp
    '-insert_size_std_dev_inward', '20',  	# odchylenie standardowe od odleglosci pomiedzy sparowanymi odczytami: 20
    '-single_edge_counter_threshold', '5',      # prog krawedzi grafu de Bruin :5(parametr-single_edge_counter_threshold)
    '-output_file_name', 'de_novo_output',     	# nazwa pliku wyjsciowego
    '-i1_1', 'Sim_100_400_1.fq',
    '-i1_2', 'Sim_100_400_2.fq',
    '-bfcounter_threshold', '2',
]

call(cmd + params)

