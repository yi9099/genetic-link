library(ggplot2)
data1 <- read.table('C:/SMR/coloc/phenotype/diabetes_coloc.txt', sep = '\t', header = T)
data1<- data1[data1$chrom == 10,]
data2 <- read.table('C:/SMR/coloc/phenotype/CAD_coloc.txt', sep = '\t', header = T)
data2 <- data2[data2$CHROM == 10,]

gene <- read.table('C:/SMR/coloc/phenotype/coloc_bind/region_gene/diabetes_region1.CSV',sep = ',', header = T)
gene1 <- gene[11,]
gene2 <- gene[14,]
gene1 <- rbind(gene1,gene2)
gene1$y <- 1
gene1[1,7] <- -1
gene1[2,7] <- -2

p <- ggplot()+
  geom_point(aes(x = pos, y = -log10(pval)), color = '#62B197', data = data1)+
  geom_point(aes(x = POS, y = -log10(p)), color = '#F0A780', data = data2)+
  scale_x_continuous(breaks = seq(11500000,13000000,by=250000), limits = c(11750000,12850000))+
  scale_y_continuous(breaks = seq(0,10,by=2),limits = c(-2.5,10))+
  geom_segment(aes(x = Start, xend = Stop, y = y, yend = y), data = gene1)+
  geom_segment(aes(x = Start, xend = Stop, y = y, yend = y), data = gene1)+
  geom_segment(aes(x = Start, y = y+0.2, xend = Start, yend = y-0.2), data = gene1)+
  geom_segment(aes(x = Stop, y = y+0.2, xend = Stop, yend = y-0.2), data = gene1)+
  geom_hline(yintercept = 5, color = "#F0A780", linetype = "dashed") +
  labs(title = 'Chromosome 10 (diabetes)',
       x = 'posiotion',
       y = '-log10(P)')+
  theme_minimal()+
  theme(axis.line = element_line(colour = "black"), 
        panel.grid = element_blank(),
        axis.ticks = element_line())+
  coord_fixed(ratio = 50000)
ggsave('C:/SMR/graph/locuszoom/dia_blood_gene.pdf', p, width =8, height = 8, dpi = 300)










