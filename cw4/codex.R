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
workDir="./"

#set number of available cores
cores <- 4

#------------------------Zde􏰁niuj nazw¦ projektu oraz utwórz katalog wyj±ciowy:
projectname <- "TGP99"
outputDir <- paste0(workDir,"codex_output/")
dir.create(outputDir)



#--------------------------------Zaaaduj wst¦pnie przeliczone dane o ga¦boko±ci pokrycia
# dla 99 próbek z 1000 Genomes i przygotuj dane dla chromosomu 20:
cfiles <- dir("/data/coverage/", "*bam.coverage*")
cdf <- rbindlist(mclapply(cfiles, function(f){
  print(f);
  df <- fread(paste0("/data/coverage/",f));
  df$SampleName <- strsplit(f, "\\.")[[1]][1];df
},mc.cores=cores))
colnames(cdf) <- c("Chr", "Start", "Stop", "ReadCount", "SampleName")
cdf <- cdf[order(cdf$SampleName, cdf$Chr, cdf$Start, cdf$Stop),]
dim(cdf)
#[1] 465498        5
head(cdf)
#   Chr  Start   Stop ReadCount SampleName
#1:  20  68319  68439
#2:  20  76611  77091
#3:  20 123208 123358
#4:  20 125995 126389
#5:  20 138119 138269
#6:  20 139359 139719
bedFile <- paste0("/data/bed/20130108.exome.targets.bed")
sampname <- unique(cdf$SampleName)
chr <- "20"
targetsChr <-  cdf[which(cdf$Chr==chr & cdf$SampleName == cdf$SampleName[1]),
                   c("Chr", "Start",  "Stop")]
selChr <- cdf[which(cdf$Chr==chr),]
Y <- t(do.call(rbind,lapply(sampname,
                            function(s){selChr$ReadCount [which(selChr$SampleName == s)]})))
colnames(Y) <- sampname
rownames(Y) <- 1:nrow(Y)
dim(Y)
#103    NA06985
#129    NA06985
#69    NA06985
#105    NA06985
#37    NA06985
#156    NA06985
#4
#[1] 4702   99
dim(targetsChr)
#[1] 4702    3
ref <- IRanges(start = targetsChr$Start, end = targetsChr$Stop)
gc <- getgc(chr, ref)
mapp <- getmapp(chr, ref)




#-------------------------------------------------Przeprowad1 kontrol¦ jako±ci:
mapp_thresh <- 0.9 # remove exons with mapability < 0.9
cov_thresh_from <- 20 # remove exons covered by less than 20 reads
cov_thresh_to <- 4000 #  remove exons covered by more than 4000 reads
length_thresh_from <- 20 # remove exons of size < 20
length_thresh_to <- 2000 # remove exons of size > 2000
gc_thresh_from <- 30 # remove exons with GC < 20
gc_thresh_to <- 70 # or GC > 80
qcObj <- qc(Y, sampname, chr, ref, mapp, gc,
            cov_thresh = c(cov_thresh_from, cov_thresh_to),
            length_thresh = c(length_thresh_from, length_thresh_to),
            mapp_thresh = mapp_thresh,
            gc_thresh = c(gc_thresh_from, gc_thresh_to))
Y_qc <- qcObj$Y_qc; sampname_qc <- qcObj$sampname_qc; gc_qc <- qcObj$gc_qc
mapp_qc <- qcObj$mapp_qc; ref_qc <- qcObj$ref_qc; qcmat <- qcObj$qcmat
#Ile eksonów (regionów) zostaao usuni¦tych w wyniku kontroli jako±ci?
#  Ile eksonów (regionów) b¦dzie usuni¦tych je»eli zmienimy progi odci¦cia za- warto±ci GC (gc_thresh_from, gc_thresh_to)? Podaj wynik dla wybranych przez Ciebie progów.




#-----------------------------------------------Przeprowad1 normalizacj¦ ga¦boko±ci pokrycia oraz segmentacj¦:
normObj <- normalize(Y_qc, gc_qc, K = 1:9)
Yhat <- normObj$Yhat; AIC <- normObj$AIC; BIC <- normObj$BIC
RSS <- normObj$RSS; K <- normObj$K
optK <- choiceofK(AIC, BIC, RSS, K,
                  filename = paste(projectname, "_", chr, "_choiceofK", ".pdf", sep = ""))
finalcall <- CODEX::segment(Y_qc, Yhat, optK = optK,
                            K = K, sampname_qc,
                            ref_qc, chr, lmax = 200,
                            mode = "integer")
finalcall <- data.frame(finalcall, stringsAsFactors=F)
finalcall$targetCount <- as.numeric(finalcall$ed_exon) - as.numeric(finalcall$st_exon)


plotCall <- function(calls,i , Y_qc, Yhat_opt){
  startIdx <- as.numeric(calls$st_exon[i])
  stopIdx <- as.numeric(calls$ed_exon[i])
  sampleName <- calls$sample_name[i]
  wd <- 20
  startPos <- max(1,(startIdx-wd))
  stopPos <- min((stopIdx+wd), nrow(Y_qc))
  selQC <- Y_qc[startPos:stopPos,]
  selQC[selQC ==0] <- 0.00001
  selYhat <- Yhat_opt[startPos:stopPos,]
  matplot(matrix(rep(startPos:stopPos, ncol(selQC)),
                 ncol=ncol(selQC)), log(selQC/selYhat,2),
          type="l",lty=1, col="dimgrey",  lwd=1,
          xlab="exon nr", ylab="logratio(Y/Yhat)")
  lines(startPos:stopPos,log( selQC[,sampleName]/ selYhat[,sampleName],2), lwd=3, col="red")
}
cnvId <- 1    # indeks zmiany dla której zostanie sporz¡dzony wykres
plotCall(finalcall, cnvId, Y_qc, Yhat[[optK]])
