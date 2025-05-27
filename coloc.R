library(coloc)
library(data.table)
data1 <- read.table('C:/SMR/SMR_result/FDR/blood_diabetes.csv', sep = ',', header = TRUE)
data2 <- read.table('C:/SMR/SMR_result/FDR/blood_hyperlipidemia.csv', sep = ',', header = TRUE)
data3 <- read.table('C:/SMR/SMR_result/FDR/blood_hypertension.csv', sep = ',', header = TRUE)
data4 <- read.table('C:/SMR/SMR_result/FDR/blood_obesity.csv', sep = ',', header = TRUE)
data5 <- read.table('C:/SMR/SMR_result/FDR/blood_osteoporosis.csv', sep = ',', header = TRUE)
data6 <- read.table('C:/SMR/SMR_result/FDR/blood_type_2_diabetes.csv', sep = ',', header = TRUE)

data1 <- data1[data1$FDR < 0.05,]
data2 <- data2[data2$FDR < 0.05,]
data3 <- data3[data3$FDR < 0.05,]
data4 <- data4[data4$FDR < 0.05,]
data5 <- data5[data5$FDR < 0.05,]
data6 <- data6[data6$FDR < 0.05,]

topSNP1 <- data1[,5]
topSNP1 <- c("diabetes", topSNP1)
topSNP2 <- data2[,5]
topSNP2 <- c("hyperlipidemia", topSNP2)
topSNP3 <- data3[,5]
topSNP3 <- c("hypertension", topSNP3)
topSNP4 <- data4[,5]
topSNP4 <- c("obesity", topSNP4)
topSNP5 <- data5[,5]
topSNP5 <- c("osteoporosis", topSNP5)
topSNP6 <- data6[,5]
topSNP6 <- c("type_2_diabetes", topSNP6)

snp_list <- list(topSNP1, topSNP2, topSNP3, topSNP4, topSNP5, topSNP6)

for (i in 1:6){
  topSNP <- snp_list[[i]]
  for (i in 1:length(topSNP)){
    commands <- paste("smr-1.3.1-win.exe --beqtl-summary ./blood/blood --query 5.0e-8 --snp ", topSNP[[i]], " --snp-wind 500 --out ./flanking_region_snp/blood/CAD",  "/", topSNP[[i]], sep = "")
    system(commands)
  }
}




#提取目的基因
data1 <- read.table('C:/SMR/SMR_result/FDR/liver_diabetes.csv', sep = ',', header = TRUE)
data2 <- read.table('C:/SMR/SMR_result/FDR/liver_hyperlipidemia.csv', sep = ',', header = TRUE)
data3 <- read.table('C:/SMR/SMR_result/FDR/liver_hypertension.csv', sep = ',', header = TRUE)
data4 <- read.table('C:/SMR/SMR_result/FDR/liver_obesity.csv', sep = ',', header = TRUE)
data5 <- read.table('C:/SMR/SMR_result/FDR/liver_osteoporosis.csv', sep = ',', header = TRUE)
data6 <- read.table('C:/SMR/SMR_result/FDR/liver_type_2_diabetes.csv', sep = ',', header = TRUE)

data1 <- data1[data1$FDR < 0.05,]
data2 <- data2[data2$FDR < 0.05,]
data3 <- data3[data3$FDR < 0.05,]
data4 <- data4[data4$FDR < 0.05,]
data5 <- data5[data5$FDR < 0.05,]
data6 <- data6[data6$FDR < 0.05,]

topSNP1 <- data1[,5]
topSNP1 <- c("diabetes", topSNP1)
topSNP2 <- data2[,5]
topSNP2 <- c("hyperlipidemia", topSNP2)
topSNP3 <- data3[,5]
topSNP3 <- c("hypertension", topSNP3)
topSNP4 <- data4[,5]
topSNP4 <- c("obesity", topSNP4)
topSNP5 <- data5[,5]
topSNP5 <- c("osteoporosis", topSNP5)
topSNP6 <- data6[,5]
topSNP6 <- c("type_2_diabetes", topSNP6)

snp_list <- list(topSNP1, topSNP2, topSNP3, topSNP4, topSNP5, topSNP6)

gene1 <- data1[,3]
gene1 <- c("diabetes", gene1)
gene2 <- data2[,3]
gene2 <- c("hyperlipidemia", gene2)
gene3 <- data3[,3]
gene3 <- c("hypertension", gene3)
gene4 <- data4[,3]
gene4 <- c("obesity", gene4)
gene5 <- data5[,3]
gene5 <- c("osteoporosis", gene5)
gene6 <- data6[,3]
gene6 <- c("type_2_diabetes", gene6)

gene_list <- list(gene1, gene2, gene3, gene4, gene5, gene6)

for (i in 1:6){
  snp <- snp_list[[i]]
  gene <- gene_list[[i]]
  for (i in 2:length(snp)){
    command1 <- paste("K:/SMR/flanking_region_snp/blood/", snp[[1]], "/", snp[[i]], ".txt", sep = "")
    command2 <- paste(gene[[i]], sep = "")
    command3 <- paste("K:/SMR/flanking_region_snp/blood/normalization/", snp[[1]], "/", snp[[i]], ".txt", sep = "")
    coloc1 <- read.table(command1, sep = "\t", header = TRUE)
    coloc2 <- coloc1[coloc1$Gene == command2,]
    write.table(coloc2, file = command3, row.names = FALSE, sep = "\t", quote = FALSE)
  }
}


for (i in 1:length(snp)){
  command1 <- paste("C:/SMR/flanking_region_snp/liver/normalization/HF", "/", snp[[i]], ".txt", sep = "")
  command2 <- paste("C:/SMR/flanking_region_snp/liver/freq/HF", "/", snp[[i]], ".txt", sep ="")
  coloc1 <- read.table(command1, sep = "\t", header = TRUE)
  coloc1$Freq[coloc1$Freq > 0.5] <- 1 - coloc1$Freq[coloc1$Freq > 0.5]
  write.table(coloc1, file = command2, row.names = FALSE, sep = "\t", quote = FALSE)
}

for (i in 1:length(snp)){
  command1 <- paste("C:/SMR/flanking_region_snp/liver/normalization/HF", "/", snp[[i]], ".txt", sep = "")
  command2 <- paste("C:/SMR/flanking_region_snp/liver/freq/HF", "/", snp[[i]], ".txt", sep ="")
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



# EAF转换为MAF
data <- read.table("C:/SMR/flanking_region_snp/blood/region/diabetes/rs1009358.txt", sep = "\t", header = TRUE)
data1 <- data[data$Freq > 0.5,]
for (i in 1:6){
  snp <- snp_list[[i]]
  for (i in 2:length(snp)){
    command1 <- paste("C:/SMR/flanking_region_snp/blood/normalization/HF", "/", snp[[i]], ".txt", sep = "")
    command2 <- paste("C:/SMR/flanking_region_snp/blood/freq/HF", "/", snp[[i]], ".txt", sep ="")
    coloc1 <- read.table(command1, sep = "\t", header = TRUE)
    coloc1$Freq[coloc1$Freq > 0.5] <- 1 - coloc1$Freq[coloc1$Freq > 0.5]
    write.table(coloc1, file = command2, row.names = FALSE, sep = "\t", quote = FALSE)
  }
}
# 从GTEx数据中获取缺失的MAF
for (i in 1:6){
  snp <- snp_list[[i]]
  for (i in 2:length(snp)){
    command1 <- paste("C:/SMR/flanking_region_snp/liver/normalization/", snp[[1]], "/", snp[[i]], ".txt", sep = "")
    command2 <- paste("C:/SMR/flanking_region_snp/liver/freq/", snp[[1]], "/", snp[[i]], ".txt", sep ="")
    coloc1 <- read.table(command1, sep = "\t", header = TRUE)
    coloc1 <- coloc1[order(coloc1[,1]),]
    list <- coloc1$SNP
    list <- as.data.frame(list)
    names(list)[1] <- "SNP"
    table <- merge(list, table, by = "SNP")
    table2 <- unique(table)
    coloc1$Freq <- table2$maf
    write.table(coloc1, file = command2, row.names = FALSE, sep = "\t", quote = FALSE)
  }
}

exposure_names <- c("blood", "brain", "liver")
outcome_names <- c("diabetes", "hyperlipidemia", "hypertension", "obesity", "osteoporosis", "type_2_diabetes")
for (i in 1:length(exposure_names)){
  names1 <- exposure_names[i]
  for (i in 1:length(outcome_names)){
    names2 <- outcome_names[i]
    command <- paste(names1, "_", names2, sep = "")
    dir.create(command)
  }
}

# coloc
N_out <- c(408959, 408878, 408343, 408792, 407763, 407701)
N_exp <- c(31684, 2865, 226)
cases <- c(20203, 35844, 77977, 10799, 6484, 18945)
GWAS1 <- fread("C:/SMR/diabetes_smr.txt",sep = "\t", header = TRUE)
GWAS2 <- fread("C:/SMR/hyperlipidemia_smr.txt",sep = "\t", header = TRUE)
GWAS3 <- fread("C:/SMR/hypertension_smr.txt",sep = "\t", header = TRUE)
GWAS4<- fread("C:/SMR/obesity_smr.txt",sep = "\t", header = TRUE)
GWAS5 <- fread("C:/SMR/osteoporosis_smr.txt",sep = "\t", header = TRUE)
GWAS6 <- fread("C:/SMR/type_2_diabetes_smr.txt",sep = "\t", header = TRUE)
GWAS <- list(GWAS1, GWAS2, GWAS3, GWAS4, GWAS5, GWAS6)
for (i in 1){
  exposure <- exposure_names[i]
  neqtl <- c(N_exp[i])
  for (i in 1:6){
    outcome <- outcome_names[i]
    ngwas <- c(N_out[i])
    case <- c(cases[i])
    snp <- snp_list[[i]]
    gwas <- GWAS[i]
    for (i in 2:length(snp)){
      
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
    command_output <- paste("C:/SMR/coloc/", exposure, "_", outcome, ".txt")
    write.table(summary_data, command_output, row.names = FALSE, sep = "\t", quote = FALSE)
    summary_data <- data[0,]
  }
}

data <- read.table('C:/SMR/SMR_result/FDR/liver_HF.csv',sep = ',', header = T)
data <- data[data$FDR<0.05,]
snp <- data[,5]
ngwas <- c(977323)
case <- c(47309)
neqtl <- c(226)
gwas <- fread('C:/SMR/HF_smr.txt',sep = '\t', header = T)
outcome <- 'HF'
exposure <- 'liver'
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
write.table(summary_data, command_output, row.names = FALSE, sep = "\t", quote = FALSE)
summary_data <- data[0,]
summary_data <- unique(summary_data)
