library(data.table)
library(vcfR)
datad <- fread('C:/SMR/GWAS/CAD_smr.txt', sep = '\t', header = T)
data1 <- fread('E:/MR/bbj-a-159.vcf/bbj-a-159.vcf', sep = ',', header = T)
#清空
rm(list=ls())
gc()
#设置工作目录
setwd("C:/SMR")
#读取文件
install.packages("vcfR")
data <- vcfR::read.vcfR("E:/MR/ebi-a-GCST005194.vcf/ebi-a-GCST005194.vcf") #读取VCF文件
gt <- data.frame(data@gt)#ES代表beta值、SE代表se、LP代表-log10（P值）、AF代表eaf、“ID”代表SNP的ID
dat <- as.character(unlist(strsplit(gt$bbj.a.159, split = ":")))#strsplit切分；unlist解开
fix<-data.frame(data@fix)#为SNP位点的基本信息


split <- strsplit(gt$EBI.a.GCST005194, ":")
split <- do.call(rbind, split)
split <- as.data.frame(split)
colnames(split) <- c("ES","SE","LP","AF","ID")
data2 <- cbind(fix, split)
col <- c(-1,-2,-6,-7,-8)
data2 <- data2[,col]
data2 <- data2[,-8]
Pvalue <- data2[,6]
Pvalue <- as.numeric(Pvalue)
pvalue <- 10^(-Pvalue)
data3 <- data2
data3[,6] <- pvalue
data4 <- data.frame(SNP=data3$ID, A1=data3$ALT, A2=data3$REF, freq=data3$AF, b=data3$ES, se=data3$SE, p=data3$LP)
data4$n <- 296525
positive <- data4[data4$p < 5e-8,]
data4 <- data4[!is.na(data4$p),]
write.table(Na, 'C:/SMR/CAD_smr.txt', sep = '\t', quote = F, row.names = F)
fwrite(data4, 'C:/SMR/CAD_smr.txt', sep = '\t', quote = F, row.names = F)
