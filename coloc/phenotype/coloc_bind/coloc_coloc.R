dia_phe <- read.table('C:/SMR/coloc/phenotype/coloc_bind/dia.txt',sep = '\t', header = T)
dia_phe <- dia_phe$x

lip_phe <- read.table('C:/SMR/coloc/phenotype/coloc_bind/lip.txt',sep = '\t', header = T)
lip_phe <- lip_phe$x

ten_phe <- read.table('C:/SMR/coloc/phenotype/coloc_bind/ten.txt',sep = '\t', header = T)
ten_phe <- ten_phe$x

obe_phe <- read.table('C:/SMR/coloc/phenotype/coloc_bind/obe.txt',sep = '\t', header = T)
obe_phe <- obe_phe$x

T2D_phe <- read.table('C:/SMR/coloc/phenotype/coloc_bind/T2D.txt',sep = '\t', header = T)
T2D_phe <- T2D_phe$x

CAD_blood <- read.table('C:/SMR/coloc/blood_CAD.txt',sep='\t',header=T)
CAD_blood <- CAD_blood[CAD_blood$PP.H4.abf > 0.8,]
CAD_blood <- CAD_blood$gene

CAD_brain <- read.table('C:/SMR/coloc/brain_CAD.txt',sep='\t',header=T)
CAD_brain <- CAD_brain[CAD_brain$PP.H4.abf > 0.8,]
CAD_brain <- CAD_brain$gene

CAD_liver <- read.table('C:/SMR/coloc/liver_CAD.txt',sep='\t',header=T)
CAD_liver <- CAD_liver[CAD_liver$PP.H4.abf > 0.8,]
CAD_liver <- CAD_liver$gene

diseases <- c('dia','lip','ten','obe','T2D')
tissues <- c('blood','brain','liver')
save <- file('C:/SMR/coloc/phenotype/coloc_bind/region_gene/coloc_coloc.txt','w')
for (i in tissues){
  command_tissue <- paste0('C:/SMR/coloc/',i,'_CAD.txt')
  tissue_gene <- read.table(command_tissue, sep = '\t', header = T)
  tissue_gene <- tissue_gene[tissue_gene$PP.H4.abf > 0.8, ]
  tissue_gene <- tissue_gene$gene
  for (t in diseases){
    command_disease <- paste0('C:/SMR/coloc/phenotype/coloc_bind/',t,'.txt')
    disease_gene <- read.table(command_disease, sep = '\t', header = T)
    disease_gene <- disease_gene$x
    gene <- intersect(tissue_gene, disease_gene)
    write(c(i, t, gene), file = save, sep = ',', append = T)
  }
}
