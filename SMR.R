# SMR数据处理
data <- read.table('D:/MR/phenocode-272.1.tsv/hyperlipidemia.tsv', sep = '\t', header = TRUE)
a <- c(-1,-2,-6,-7,-12,-13)
data2 <- data[,a]
names(data2) <- c('SNP','A1','A2','freq','b','se','p')
data3 <- data2
data3$n <- rep(NA,nrow(data3))

data3[,1] <- data2[,3]
data3[,3] <- data2[,1]
data3[,4] <- data2[,7]
data3[,7] <- data2[,4]
data3 <- data3[data3[,1] != "",]
data3 <- data3[-grep(',',data3[,1]),]
write.csv(data4, file = 'C:/SMR/smr-1.3.1-win-x86_64/hypertension_smr.csv', row.names = FALSE, sep = '\t')
write.table(data3, file = 'C:/SMR/hyperlipidemia_smr.txt', row.names = FALSE, sep = '\t', quote = FALSE)

# FDR calculate
data <- read.delim("C:/SMR/SMR_result/CAD/liver_CAD.smr", header = TRUE, stringsAsFactors = FALSE)
rank_data <- data[order(data$p_SMR),]
fdr <- p.adjust(rank_data$p_SMR, method = "BH")
results <- data.frame(rank_data, FDR = fdr)
write.csv(results, "C:/SMR/SMR_result/FDR/liver_CAD.csv", row.names = FALSE, quote = FALSE)

data <- read.table('C:/SMR/Blood_cis-eQTL-SMR/cis-eQTLs-full.epi', sep = '\t', header = FALSE)
data1 <- data[,2]
write.table(data1,'C:/SMR/Blood_cis-eQTL-SMR/GeneID_list.txt', row.names = FALSE, quote = FALSE)

#将ENSEMBL号转换成gene名
BiocManager::install("AnnotationDbi")
BiocManager::install("org.Hs.eg.db")
BiocManager::install("GenomicRanges") 
library("AnnotationDbi")
library("org.Hs.eg.db")
library(GenomicRanges)
data <- read.table('C:/SMR/blood/blood.epi')
gene_id <- data[,2]
df <- data.frame(gene_id)
gene <- select(org.Hs.eg.db, keys = gene_id, column = "SYMBOL", keytype = "ENSEMBL")
gene2 <- mapIds(org.Hs.eg.db, keys = gene_id, column = "SYMBOL", keytype = "ENSEMBL")
B <- data[,2]
map <- Map(function(a, b) ifelse(is.na(a), b, a), gene2, B)
map <- unlist(map, use.names = FALSE) 
data$V5 <- map

write.table(data, 'C:/SMR/Blood_cis-eQTL-SMR/cis-eQTLs-full_new.epi', sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)






