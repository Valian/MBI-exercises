#!/bin/env bash
wget            https://github.com/NGSchoolEU/2017/raw/master/CNV_detection/data/DGV.tar.gz
wget            https://github.com/NGSchoolEU/2017/raw/master/CNV_detection/data/TGP_SV.tar.gz
wget            https://github.com/NGSchoolEU/2017/raw/master/CNV_detection/data/bed.tar.gz
wget            https://github.com/NGSchoolEU/2017/raw/master/CNV_detection/data/codex_output_all.tar.gz
wget            https://github.com/NGSchoolEU/2017/raw/master/CNV_detection/data/coverage.tar.gz
wget            https://github.com/NGSchoolEU/2017/raw/master/CNV_detection/data/refFlat.tar.gz
wget            https://github.com/NGSchoolEU/2017/raw/master/CNV_detection/data/segDups.tar.gz

find . -name '*.tar.gz' -exec tar -xzvf {} \;
