diseases <- c('diabetes','hyperlipidemia','hypertension','obesity','T2D')

summary <- data[0,]
for (i in diseases){
  command <- paste0('C:/SMR/coloc/phenotype/coloc_bind/',i,'_CAD.txt')
  data <- read.table(command, sep = '\t', header = T)
  data <- data[,-1]
  data <- data[data$PP.H4.abf >= 0.6,]
  data$disease <- i
  summary <- rbind(summary, data)
}
write.table(summary, 'C:/SMR/coloc/phenotype/coloc_bind/metabolic_CAD.txt', sep = '\t', quote = F, row.names = F)
CAD <- fread('C:/SMR/coloc/phenotype/CAD_coloc.txt', sep='\t', header = T)
#获得CAD.topSNP的pos
CAD_topSNP <- summary$topSNP.x
pos <- list()
for (i in CAD_topSNP){
  topSNP <- CAD[CAD$ID == i,]
  POS <- topSNP$POS
  pos <- c(pos, POS)
}
summary$CAD.pos <- pos
#获得disease.topSNP的pos
disese1 <- fread('C:/SMR/coloc/phenotype/diabetes_coloc.txt', sep='\t', header = T)
disese2 <- fread('C:/SMR/coloc/phenotype/hyperlipidemia_coloc.txt', sep='\t', header = T)
disese3 <- fread('C:/SMR/coloc/phenotype/hypertension_coloc.txt', sep='\t', header = T)
disese4 <- fread('C:/SMR/coloc/phenotype/obesity_coloc.txt', sep='\t', header = T)
disese5 <- fread('C:/SMR/coloc/phenotype/T2D_coloc.txt', sep='\t', header = T)
dis_topSNP <- summary$topSNP.y
pos <- list()
for (i in dis_topSNP[1:2]){
  topSNP <- disese1[disese1$rsids == i,]
  POS <- topSNP$pos
  pos <- c(pos, POS)
}
for (i in dis_topSNP[3:19]){
  topSNP <- disese2[disese2$rsids == i,]
  POS <- topSNP$pos
  pos <- c(pos, POS)
}
for (i in dis_topSNP[20:45]){
  topSNP <- disese3[disese3$rsids == i,]
  POS <- topSNP$pos
  pos <- c(pos, POS)
}
for (i in dis_topSNP[46]){
  topSNP <- disese4[disese4$rsids == i,]
  POS <- topSNP$pos
  pos <- c(pos, POS)
}
for (i in dis_topSNP[47:48]){
  topSNP <- disese5[disese5$rsids == i,]
  POS <- topSNP$pos
  pos <- c(pos, POS)
}
summary$disease.pos <- pos
#算出两个topSNP的公共区段
region_list <- list()
for (i in 1:48){
  CADpos <- as.numeric(summary[i,10])
  diseasepos <- as.numeric(summary[i,11])
  CAD_sta <- CADpos - 500000
  CAD_end <- CADpos + 500000
  dis_sta <- diseasepos - 500000
  dis_end <- diseasepos + 500000
  region_sta <- max(CAD_sta, dis_sta)
  region_end <- min(CAD_end, dis_end)
  region <- paste(region_sta,region_end,sep = ':')
  region_list <- c(region_list,region)
}
summary$region <- region_list
summary$CAD.pos <- sapply(summary$CAD.pos, function(x) paste(as.character(unlist(x)), collapse = ", "))
summary$disease.pos <- sapply(summary$disease.pos, function(x) paste(as.character(unlist(x)), collapse = ", "))
summary$region <- sapply(summary$region, function(x) paste(as.character(unlist(x)), collapse = ", "))
write.table(summary,'C:/SMR/coloc/phenotype/coloc_bind/metabolic_CAD_region.txt',sep = '\t', quote = F, row.names = F)
