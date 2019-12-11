#!/bin/bash

dataDir=`pwd`/data
docker run -v $dataDir:/data biocontainers/samtools:1.3.1 \
    samtools index coriell_chr1.bam
