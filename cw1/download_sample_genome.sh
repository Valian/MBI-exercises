#!/bin/env bash
mkdir -p /tmp/mbi
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/010/525/GCF_000010525.1_ASM1052v1/GCF_000010525.1_ASM1052v1_genomic.fna.gz
mv GCF_000010525.1_ASM1052v1_genomic.fna.gz /tmp/mbi/sample_genome.fna.gz
