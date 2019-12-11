#!/bin/bash
mkdir data
cd data
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/chromosomes/chr1.fa.gz
gunzip chr1.fa.gz

echo "Download manually https://drive.google.com/uc?authuser=0&id=1UU2IlgQ58TerqkZglASchab5Iu9_kSKQ&export=download"
gunzip coriell_chr1.fq.gz
