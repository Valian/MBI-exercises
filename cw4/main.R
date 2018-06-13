library(data.table)
library(parallel)
library(RCurl)
library(gdata)
library(Hmisc)
library(matrixStats)
library(DNAcopy)
library(GenomicRanges)
library(Rsubread)
library(WES.1KG.WUGSC)
library(CODEX)

#set number of available cores
cores <- 4


# calc coverage

# preview bedFile
fread(bedFile)

dirPath <- system.file("extdata", package = "WES.1KG.WUGSC")
bamFile <- list.files(dirPath, pattern = '*.bam$')
bamdir <- file.path(dirPath, bamFile)
sampname <- as.matrix(read.table(file.path(dirPath, "sampname")))
bedFile <- file.path(dirPath, "chr22_400_to_500.bed")
chr <- 22
bambedObj <- getbambed(bamdir = bamdir, bedFile = bedFile,
sampname = sampname, projectname = "CODEX_demo", chr)
bamdir <- bambedObj$bamdir; sampname <- bambedObj$sampname
ref <- bambedObj$ref; projectname <- bambedObj$projectname; chr <- bambedObj$chr
coverageObj <- getcoverage(bambedObj, mapqthres = 20)

# information about reads for each region
Y <- coverageObj$Y; readlength <- coverageObj$readlength
Objekt Y zawiera dane na temat liczby odczytów dla ka»dego regionu; próbki s¡ zdenio-
wane w kolejnych kolumnach; regiony w wierszach.
Y_ac <- apply(Y, 2,function(x){(100*x)/width(ref)})
colnames(Y_ac) <- sampname

# coverage depth statistics
summary(apply(Y_ac, 2, median))
