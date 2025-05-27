library(coloc)
library(dplyr)
library(data.table)
N_out <- c(296525)
case_out <- c(34541)
N_exp <- c(408959, 408878, 408343, 408792, 407763, 407701)
case_exp <- c(20203, 35844, 77977, 10799, 6484, 18945)
CAD <- fread('C:/SMR/coloc/phenotype/CAD_coloc.txt', sep = '\t', header = T)
names(CAD)[3] <- 'rsids'
exp1 <- fread('C:/SMR/coloc/phenotype/diabetes_coloc.txt', sep = '\t', header = T)
exp2 <- fread('C:/SMR/coloc/phenotype/hyperlipidemia_coloc.txt', sep = '\t', header = T)
exp3 <- fread('C:/SMR/coloc/phenotype/hypertension_coloc.txt', sep = '\t', header = T)
exp4 <- fread('C:/SMR/coloc/phenotype/obesity_coloc.txt', sep = '\t', header = T)
exp5 <- fread('C:/SMR/coloc/phenotype/T2D_coloc.txt', sep = '\t', header = T)
exp <- list(exp1,exp2,exp3,exp4,exp5)
exposure_names <- c("diabetes", "hyperlipidemia", "hypertension", "obesity", "T2D")
summary_data <- data[0,]
#按代谢类疾病的topSNP进行coloc
for (i in 5){
  outcome <- 'CAD'
  exposure <- exposure_names[i]
  ngwas <- N_exp[i]
  case_e <- case_exp[i]
  merge_data <- merge(CAD, exp[i], by = "rsids")
  merge_data <- merge_data %>%  group_by(rsids) %>%  filter(n() == 1) %>% ungroup()
  topSNP <- unique(merge_data$topSNP.y)
  for (i in topSNP){
    input <- merge_data[merge_data$topSNP.y == i,]
    re <- coloc.abf(dataset1 = list(pvalues = input$p, snp = input$rsids, type ="cc", N = 296525, s = case_out/296525),
                    dataset2 = list(pvalues = input$pval, snp = input$rsids, type ="cc", N = ngwas, s = case_e/ngwas), MAF = input$eaf)
    data <- re$summary
    data$chrom <- input[1,2]
    data$topSNP.y <- i
    CAD_top <- unique(input$topSNP.x)
    data$topSNP.x <- CAD_top
    data <- as.data.frame(data)
    summary_data <- rbind(summary_data, data[1,])
    }
}
summary_data <- summary_data[order(summary_data$PP.H4.abf, decreasing = TRUE),]
command_output <- paste("C:/SMR/coloc/phenotype/topSNP_diseases/", exposure, "_", outcome, "_",exposure,".txt",sep = '')
write.table(summary_data, command_output, row.names = FALSE, sep = "\t", quote = FALSE)
#按CAD的topSNP进行coloc
summary_data1 <- data[0,]
for (i in 5){
  outcome <- 'CAD'
  exposure <- exposure_names[i]
  ngwas <- N_exp[i]
  case_e <- case_exp[i]
  merge_data <- merge(CAD, exp[i], by = "rsids")
  merge_data <- merge_data %>%  group_by(rsids) %>%  filter(n() == 1) %>% ungroup()
  topSNP <- unique(merge_data$topSNP.x)
  for (i in topSNP){
    input <- merge_data[merge_data$topSNP.x == i,]
    re <- coloc.abf(dataset1 = list(pvalues = input$p, snp = input$rsids, type ="cc", N = 296525, s = case_out/296525),
                    dataset2 = list(pvalues = input$pval, snp = input$rsids, type ="cc", N = ngwas, s = case_e/ngwas), MAF = input$eaf)
    data <- re$summary
    data$chrom <- input[1,2]
    data$topSNP.x <- i
    CAD_top <- unique(input$topSNP.y)
    data$topSNP.y <- CAD_top
    data <- as.data.frame(data)
    summary_data1 <- rbind(summary_data1, data[1,])
  }
}
summary_data1 <- summary_data1[order(summary_data1$PP.H4.abf, decreasing = TRUE),]
command_output1 <- paste("C:/SMR/coloc/phenotype/topSNP_CAD/", exposure, "_", outcome, "_CAD.txt",sep = '')
write.table(summary_data1, command_output1, row.names = FALSE, sep = "\t", quote = FALSE)

data_rbind <- unique(rbind(summary_data, summary_data1))
data_rbind <- data_rbind[order(data_rbind$PP.H4.abf, decreasing = T),]
command <- paste("C:/SMR/coloc/phenotype/coloc_bind/", exposure, "_", outcome, ".txt",sep = '')
write.table(data_rbind,command,row.names = FALSE, sep = "\t", quote = FALSE)
