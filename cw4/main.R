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

# get list of BAM files
dirPath <- system.file("extdata", package = "WES.1KG.WUGSC")
bamFile <- list.files(dirPath, pattern = '*.bam$')
nrow(bamFile) # there is 100 BAM files
bamFile

# get samples names
bamdir <- file.path(dirPath, bamFile)
sampname <- as.matrix(read.table(file.path(dirPath, "sampname")))
nrow(sampname) 
sampname 

# read BED file
bedFile <- file.path(dirPath, "chr22_400_to_500.bed")
bedFile # the file has information for 100 regions of 22th chormosome
fread(bedFile) # the file has information for 100 regions of 22th chormosome

# calc coverage
chr <- 22
bambedObj <- getbambed(bamdir = bamdir, bedFile = bedFile,
            sampname = sampname, projectname = "CODEX_demo", chr)
bamdir <- bambedObj$bamdir; sampname <- bambedObj$sampname
ref <- bambedObj$ref; projectname <- bambedObj$projectname; chr <- bambedObj$chr
coverageObj <- getcoverage(bambedObj, mapqthres = 20)
Y <- coverageObj$Y; readlength <- coverageObj$readlength
dim(Y) # 100 próbek x 46 plików - macierz integerów - liczby odczytów dla każdego ze 100 regionów
#Objekt Y zawiera dane na temat liczby odczytów dla ka»dego regionu; próbki s¡ zdenio-
#wane w kolejnych kolumnach; regiony w wierszach.
Y_ac <- apply(Y, 2,function(x){(100*x)/width(ref)})
colnames(Y_ac) <- sampname

# print coverage depth statistics
apply(Y_ac, 2, median)
summary <- summary(apply(Y_ac, 2, median))
summary

# show sorted by median coverage
med = apply(Y_ac, 2, median)
med[order(med)]
