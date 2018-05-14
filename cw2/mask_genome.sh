#!/bin/env bash
docker run -it --rm -v /tmp/mbi2:/tmp -w /tmp wkusmirek/repeatmasker RepeatMasker --species arabidopsis /tmp/single_scaffold.fa
