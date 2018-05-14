#!/bin/env bash
docker run -it --rm -v /tmp/mbi2:/tmp -w /tmp wkusmirek/repeatmasker RepeatMasker --species arabidopsis /tmp/single_scaffold.fa

echo "Masked nucleotides count: "
python3 -c "print(open('/tmp/mbi2/single_scaffold.fa.masked', 'r').read().count('N'))"
