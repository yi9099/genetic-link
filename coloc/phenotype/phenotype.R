library(data.table)
data <- fread('E:/MR/ebi-a-GCST005194.vcf/CAD.txt', sep = '\t', header = T)
data$topSNP <- 'rs'
data1 <- data[data$p < 5e-8,]
data_top <- data1[0,]

for (i in 1:22){
  data_chr <- data1[data1$CHROM == i,]
  data_chr1 <- data[data$CHROM == i,]
  snp_list <- data_chr$ID
  pos_list <- data_chr1$POS
  n <- 0
  for (i in 1:length(snp_list)){
    snp <- snp_list[i]
    data_snp <- data_chr[data_chr$ID == snp,]
    position <- data_snp$POS
    pos <- pos_list[pos_list >= position-500000 & pos_list <= position+500000]
    data_pos <- data_chr1[data_chr1$POS %in% pos,]
    index <- which(pos == position)
    n <- n + 1
    print(snp)
    print(n)
    p_list <- data_pos$p
    if (p_list[index] == min(p_list)){
      data_pos$topSNP <- snp_list[i]
      data_top <- rbind(data_top,data_pos)
    }
  }
}
fwrite(data_top, "C:/SMR/coloc/phenotype/CAD_coloc.txt", sep = '\t', quote = F, row.names = F)

data <- fread('E:/MR/T2D/type 2 diabetes.tsv', sep = '\t', header = T)
data <- data %>%  group_by(rsids) %>%  filter(n() == 1) %>% ungroup()
data1 <- data[data$pval < 5e-8,]
col <- c(-7,-12,-13)
data1 <- data.frame(data1)
data1 <- data1[,col]
data1$topSNP <- 'rs'
data_top <- data1[0,]
data1 <- data1 %>%  group_by(rsids) %>%  filter(n() == 1) %>% ungroup()

chr <- unique(data1$chrom)
for (i in chr){
  data_chr <- data1[data1$chrom == i,]
  data_chr1 <- data[data$chrom == i,]
  snp_list <- data_chr$rsids
  pos_list <- data_chr1$pos
  n <- 0
  for (i in 1:length(snp_list)){
    snp <- snp_list[i]
    data_snp <- data_chr[data_chr$rsids == snp,]
    position <- data_snp$pos
    posi <- pos_list[pos_list >= position-500000 & pos_list <= position+500000]
    data_pos <- data_chr1[data_chr1$pos %in% posi,]
    index <- which(posi == position)
    n <- n + 1
    print(snp)
    print(n)
    p_list <- data_pos$pval
    if (p_list[index] == min(p_list)){
      data_pos$topSNP <- snp_list[i]
      data_top <- rbind(data_top,data_pos)
    }
  }
}
fwrite(data_top, "C:/SMR/coloc/phenotype/T2D_coloc.txt", sep = '\t', quote = F, row.names = F)
