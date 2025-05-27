library(data.table)
# SMR数据处理
data <- read.table('C:/SMR/GWAS/osteoporosis_smr.txt', sep = '\t', header = TRUE)
data <- fread('C:/SMR/GWAS/CAD.txt', sep = '\t', header = TRUE)

a <- c(-1,-2,-6,-7,-12,-13)
data2 <- data[,a]
col_names <- names(data2)
names(data3) <- c('SNP','A1','A2','freq','b','se','p')
data3$n <- rep(NA,nrow(data3))
write.csv(data4, file = 'C:/SMR/smr-1.3.1-win-x86_64/hypertension_smr.csv', row.names = FALSE, sep = '\t')
write.table(data3, file = 'C:/SMR/osteoporosis_smr.txt', row.names = FALSE, sep = '\t', quote = FALSE)
data3 <- data2
data3[,1] <- data2[,3]
data3[,2] <- data2[,]
data3[,3] <- data2[,1]
data3[,4] <- data2[,7]
data3[,5] <- data2[,]
data3[,6] <- data2[,]
data3[,7] <- data2[,4]
data2u <- unique(data2)
row.names(data2u) <- data2u[,1]
data4 <- data4[-620,]
e <- data[620,]
data3 <- data[data[,1] != "",]
data3 <- data3[-grep(',',data3[,1]),]


# FDR calculate
data <- read.delim("C:/SMR/SMR_result/osteoporosis/liver_osteoporosis.smr", header = TRUE, stringsAsFactors = FALSE)
fdr <- p.adjust(data$p_SMR, method = "BH")
results <- data.frame(data, FDR = fdr)
write.csv(results, "C:/SMR/SMR_result/FDR/liver_osteoporosis.csv", row.names = FALSE, quote = FALSE)



