diseases <- c('dia','lip','ten','obe','T2D')
genelist <- list()
for (i in 47:48){
  command <- paste0('C:/SMR/coloc/phenotype/coloc_bind/region_gene/T2D_region',i,'.CSV')
  data <- read.table(command,sep = ',', header = T)
  gene <- data$Gene.symbol
  genelist <- c(genelist,gene)
}
diabetes_gene <- unique(as.character(genelist))
lip_gene <- unique(as.character(genelist))
ten_gene <- unique(as.character(genelist))
obe_gene <- unique(as.character(genelist))
T2D_gene <- unique(as.character(genelist))
data1 <- data.frame(matrix(nrow=549,ncol=5))
names(data1) <- diseases
write.table(diabetes_gene,'C:/SMR/coloc/phenotype/coloc_bind/dia.txt',sep = '\t', quote = F, row.names = F)
write.table(lip_gene,'C:/SMR/coloc/phenotype/coloc_bind/lip.txt',sep = '\t', quote = F, row.names = F)
write.table(ten_gene,'C:/SMR/coloc/phenotype/coloc_bind/ten.txt',sep = '\t', quote = F, row.names = F)
write.table(obe_gene,'C:/SMR/coloc/phenotype/coloc_bind/obe.txt',sep = '\t', quote = F, row.names = F)
write.table(T2D_gene,'C:/SMR/coloc/phenotype/coloc_bind/T2D.txt',sep = '\t', quote = F, row.names = F)

smr <- read.table('C:/SMR/SMR_result/FDR/ms_cad/liver.csv',sep = ',',header = T)
dia_smr <- smr$dia
dia_intersect <- intersect(dia_smr, diabetes_gene)
lip_smr <- smr$hyperlip
lip_intersect <- intersect(lip_gene,lip_smr)
ten_smr <- smr$hyperten
ten_intersect <- intersect(ten_gene,ten_smr)
obe_smr <- smr$obesity
obe_intersect <- intersect(obe_gene,obe_smr)
T2D_smr <- smr$t2d
T2D_intersect <- intersect(T2D_gene,T2D_smr)
fi <- file('C:/SMR/coloc/phenotype/coloc_bind/region_gene/liver_gene.txt', 'w')
write(c(dia_intersect,lip_intersect,ten_intersect,obe_intersect,T2D_intersect),file = fi,sep=',',append = T)
close(fi)



