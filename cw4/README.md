Order
=====

```
mkdir outputs
docker build -t mbi4 .
docker run --rm -i mbi4 R < main.R --no-save > outputs/output_main.txt 2>&1
docker run --rm -i mbi4 R < codex.R --no-save > outputs/output_codex.txt 2>&1
```
