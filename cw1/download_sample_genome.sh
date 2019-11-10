#!/bin/env bash
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/189/295/GCF_001189295.1_ASM118929v1/GCF_001189295.1_ASM118929v1_genomic.fna.gz -O sample_genome.fna.gz

docker run -v mbi:/data --name helper busybox true
docker cp sample_genome.fna.gz helper:/data
docker rm -f helper

rm sample_genome.fna.gz