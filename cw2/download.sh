#!/bin/env bash
mkdir /tmp/mbi2/

cd /tmp/mbi2/

prefix="ftp://ftp.ebi.ac.uk/pub/databases/wormbase/parasite/releases/WBPS10/species/hymenolepis_diminuta/PRJEB507/"

# wyniki assemblingu tasiemca (plik ze skafoldami)
genome="hymenolepis_diminuta.PRJEB507.WBPS10.genomic.fa.gz"

# sekwencja znanych białek dla tasiemca
protein="hymenolepis_diminuta.PRJEB507.WBPS10.protein.fa.gz"

# sekwencja mRNA dla tasiemca
mRNAtranscripts="hymenolepis_diminuta.PRJEB507.WBPS10.mRNA_transcripts.fa.gz"

wget $prefix$genome
wget $prefix$protein
wget $prefix$mRNAtranscripts

mv $genome genome.fa.gz
mv $protein protein.fa.gz
mv $mRNAtranscripts mRNA.fa.gz

gzip -d genome.fa.gz
gzip -d protein.fa.gz
gzip -d mRNA.fa.gz
