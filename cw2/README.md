# Order

```
bash download.sh
python3 extract_sequence.py > outputs/extract_sequence_output.txt
bash mask_genome.sh > outputs/mask_genome_output.txt 
bash structural_annotation.sh > outputs/structural_annotation_output.txt 2>&1
python3 get_sequence_for_blastx.py > outputs/get_sequence_for_blastx_output.txt
```
