#!/bin/bash
mkdir data
cd data
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr1.fa.gz
gunzip chr1.fa.gz
wget https://www.dropbox.com/s/4ocl1vuc4z1oxgh/coriell_chr1.fq.gz?dl=0
mv coriell_chr1.fq.gz\?dl\=0 coriell_chr1.fq.gz
gunzip coriell_chr1.fq.gz
