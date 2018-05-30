#!/bin/bash

dataDir=`pwd`/data
echo $dataDir

docker run -v $dataDir:/data biocontainers/samtools \
    samtools index coriell_chr1.bam
