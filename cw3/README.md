Order
=====

```
./download.sh
bash mapping.sh > outputs/outout_mapping.txt 2>&1
python3 analizeSAM.py > outputs/output_analizeSAM.txt
bash indexBam.sh > outputs/output_indexBam.txt 2>&1

# Wykrywanie i filtrowanie wariantów
bash genVCF.sh > outputs/output_genVCF.txt 2>&1
```
