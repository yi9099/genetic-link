library(data.table)
data1 <- fread('./GWAS/CAD.txt', sep = '\t', header = T)
data1 <- data1[data1$p < 5e-8,]
chr1 <- unique(data1[,1])
data2 <- fread('E:/MR/diabetes/diabetes.tsv',sep = '\t', header = T)
data2 <- data2[data2$pval < 5e-8,]
chr2 <- unique(data2[,1])
data3 <- fread('E:/MR/hyperlipidemia/hyperlipidemia.tsv',sep = '\t', header = T)
data3 <- data3[data3$pval < 5e-8,]
chr3 <- unique(data3[,1])
data4 <- fread('E:/MR/hypertension/hypertension.tsv',sep = '\t', header = T)
data4 <- data4[data4$pval < 5e-8,]
chr4 <- unique(data4[,1])
data5 <- fread('E:/MR/obesity/obesity.tsv',sep = '\t', header = T)
data5 <- data5[data5$pval < 5e-8,]
chr5 <- unique(data5[,1])
data6 <- fread('E:/MR/T2D/type 2 diabetes.tsv',sep = '\t', header = T)
data6 <- data6[data6$pval < 5e-8,]
chr6 <- unique(data6[,1])
