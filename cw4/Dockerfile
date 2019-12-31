FROM r-base

RUN apt-get update && apt-get install -y libcurl4-openssl-dev libxml2-dev
RUN echo 'options(repos=structure(c(CRAN="cran.rstudio.org")))' > ~/.Rprofile

RUN Rscript -e 'install.packages("data.table")'
RUN Rscript -e 'install.packages("RCurl")'
RUN Rscript -e 'install.packages("gdata")'
RUN Rscript -e 'install.packages("Hmisc")'
RUN Rscript -e 'install.packages("matrixStats")'
RUN Rscript -e 'install.packages("XML")'

RUN Rscript -e 'install.packages("BiocManager")'
RUN Rscript -e 'BiocManager::install(c("GenomicRanges", "DNAcopy", "Rsubread", "WES.1KG.WUGSC", "CODEX"))'

COPY download.sh .
RUN mkdir /data && cd data && bash ../download.sh

WORKDIR /srv

