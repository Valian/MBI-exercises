install.packages("data.table")
install.packages("RCurl")
install.packages("gdata")
install.packages("Hmisc")
install.packages("matrixStats")

source("https://bioconductor.org/biocLite.R")  # bioconductor
biocLite("DNAcopy")
biocLite("GenomicRanges")
biocLite("Rsubread")
biocLite("WES.1KG.WUGSC")
biocLite("CODEX")

# TODO: checkout problems: https://stackoverflow.com/questions/41839214/installation-path-not-writable-r-unable-to-update-packages
