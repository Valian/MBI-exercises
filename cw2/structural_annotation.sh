#!/bin/env bash

# generate configuration files
docker run --rm -v /tmp/mbi2:/tmp -w /tmp wkusmirek/maker maker -CTL

config=/tmp/mbi2/maker_opts.ctl
sed -i -e 's/^genome=/genome=\/tmp\/single_scaffold.fa.masked/g' $config
sed -i -e 's/^est=/est=\/tmp\/mRNA.fa/g' $config
sed -i -e 's/^protein=/protein=\/tmp\/protein.fa/g' $config

docker run --rm -v /tmp/mbi2:/tmp -w /tmp wkusmirek/maker maker
