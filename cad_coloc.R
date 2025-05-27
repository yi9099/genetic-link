data <- read.table('./SMR_result/FDR/brain_CAD.csv',sep = ',', header = T)
data <- data[data$FDR < 0.05,]
topSNP <- data[,5]
topSNP <- rev(topSNP)
for (i in 1:length(topSNP)){
  print(topSNP[[i]])
  commands <- paste("smr-1.3.1-win.exe --beqtl-summary ./brain/my_sparse --query 5.0e-8 --snp ", topSNP[[i]], " --snp-wind 500 --out ./flanking_region_snp/brain/CAD",  "/", topSNP[[i]], sep = "")
  system(commands)
}

data1 <- read.table('./SMR_result/FDR/liver_CAD.csv',sep = ',', header = T)
data1 <- data1[data1$FDR < 0.05,]
topSNP1 <- data1[,5]
for (i in 1:length(topSNP1)){
  print(topSNP1[[i]])
  commands <- paste("smr-1.3.1-win.exe --beqtl-summary ./liver/liver --query 5.0e-8 --snp ", topSNP1[[i]], " --snp-wind 500 --out ./flanking_region_snp/liver/CAD",  "/", topSNP1[[i]], sep = "")
  system(commands)
}

#提取目的基因
data <- read.table('./SMR_result/FDR/brain_CAD.csv',sep = ',', header = T)
data <- data[data$FDR < 0.05,]
snp <- data[,5]
gene <- data[,3]
for (i in 1:length(snp)){
  command1 <- paste("./flanking_region_snp/brain/CAD/",snp[[i]], ".txt", sep = "")
  command2 <- paste(gene[[i]], sep = "")
  command3 <- paste("./flanking_region_snp/brain/normalization/CAD/", snp[[i]], ".txt", sep = "")
  coloc1 <- read.table(command1, sep = "\t", header = TRUE)
  coloc2 <- coloc1[coloc1$Gene == command2,]
  write.table(coloc2, file = command3, row.names = FALSE, sep = "\t", quote = FALSE)
}
#将eaf转换为maf
for (i in 1:length(snp)){
  command1 <- paste("C:/SMR/flanking_region_snp/brain/normalization/CAD", "/", snp[[i]], ".txt", sep = "")
  command2 <- paste("C:/SMR/flanking_region_snp/brain/freq/CAD", "/", snp[[i]], ".txt", sep ="")
  coloc1 <- read.table(command1, sep = "\t", header = TRUE)
  coloc1$Freq[coloc1$Freq > 0.5] <- 1 - coloc1$Freq[coloc1$Freq > 0.5]
  write.table(coloc1, file = command2, row.names = FALSE, sep = "\t", quote = FALSE)
}
# 从GTEx数据中获取缺失的MAF
table3 <- read.table('./liver/merge_table.txt', sep = '\t', header = T)
names(table3)[4] <- 'SNP'
for (i in 1:length(snp)){
  command1 <- paste("C:/SMR/flanking_region_snp/liver/normalization/CAD", "/", snp[[i]], ".txt", sep = "")
  command2 <- paste("C:/SMR/flanking_region_snp/liver/freq/CAD", "/", snp[[i]], ".txt", sep ="")
  coloc1 <- read.table(command1, sep = "\t", header = TRUE)
  coloc1 <- coloc1[order(coloc1[,1]),]
  list <- coloc1$SNP
  list <- as.data.frame(list)
  names(list)[1] <- "SNP"
  table <- merge(list, table3, by = "SNP")
  table <- table[,-5]
  table2 <- unique(table)
  coloc1$Freq <- table2$maf
  write.table(coloc1, file = command2, row.names = FALSE, sep = "\t", quote = FALSE)
}
# coloc
data <- read.table('C:/SMR/SMR_result/FDR/liver_CAD.csv',sep = ',', header = T)
data <- data[data$FDR<0.05,]
snp <- data[,5]
ngwas <- c(296525)
case <- c(34541)
neqtl <- c(226)
gwas <- fread('C:/SMR/CAD_smr.txt',sep = '\t', header = T)
outcome <- 'CAD'
exposure <- 'liver'
summary_data <- data[0,]
for (i in 1:length(snp)){
  
  command_out <- paste("C:/SMR/", outcome, "_smr.txt", sep = "")
  command_exp <- paste("C:/SMR/flanking_region_snp/", exposure, "/freq/", outcome, "/", snp[i], ".txt", sep = "")
  eqtl <- read.table(command_exp, sep = "\t", header = TRUE)
  input <- merge(eqtl, gwas, by = "SNP")
  input <- input %>%  group_by(SNP) %>%  filter(n() == 1) %>% ungroup()
  input <- input %>%  filter(p.x != 0)
  re <- coloc.abf(dataset1 = list(pvalues = input$p.y, snp = input$SNP, type = "cc", N = ngwas, s = case/ngwas),
                  dataset2 = list(pvalues = input$p.x, snp = input$SNP, type = "quant", N = neqtl), MAF = input$Freq)
  data <- re$summary
  data$gene <- eqtl$Gene[1]
  data <- as.data.frame(data)
  summary_data <- rbind(summary_data, data[1,])
}
summary_data <- summary_data[order(summary_data$PP.H4.abf, decreasing = TRUE),]
command_output <- paste("C:/SMR/coloc/", exposure, "_", outcome, ".txt",sep = '')
summary_data <- unique(summary_data)
write.table(summary_data, command_output, row.names = FALSE, sep = "\t", quote = FALSE)


