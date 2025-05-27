tissues <- c('blood','brain','liver')
diseases <- c('diabetes','hyperlipidemia','hypertension','obesity','type_2_diabetes')
save <- file('C:/SMR/coloc/MS_CAD_coloc.txt','w')
for (i in tissues){
  tissue <- i
  for (t in diseases){
    command_cad <- paste0('C:/SMR/coloc/', i, '_CAD.txt')
    CAD <- read.table(command_cad, sep = '\t', header = T)
    CAD <- CAD[CAD$PP.H4.abf > 0.8,]
    CAD <- CAD$gene
    command_disease <- paste0('C:/SMR/coloc/', i, '_', t, '.txt')
    disease <- read.table(command_disease, sep = '\t', header = T)
    disease <- disease[disease$PP.H4.abf > 0.8,]
    disease <- disease$gene
    gene <- intersect(CAD, disease)
    title <- c(i, t, paste(gene, collapse = ','))
    write(title, file = save, append = T, sep = '\n')
  }
}
close(save)