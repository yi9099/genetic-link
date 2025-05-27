library(ggplot2)
data1 <- read.table('C:/SMR/coloc/phenotype/hyperlipidemia_coloc.txt', sep = '\t', header = T)
data1 <- data1[data1$chrom == 16,]
data1 <- data1[data1$pval <= 0.1,]
data2 <- read.table('C:/SMR/coloc/phenotype/CAD_coloc.txt', sep = '\t', header = T)
data2 <- data2[data2$CHROM == 16,]
data2 <- data2[data2$p <= 0.1,]

gene <- read.table('C:/SMR/coloc/phenotype/coloc_bind/region_gene/lip_region19.CSV',sep = ',', header = T)
set <- c(18,19)
gene1 <- gene[set,]
gene1$y <- seq(-1,-2)

p <- ggplot()+
  geom_point(aes(x = pos, y = -log10(pval)), color = '#F0A780', data = data1)+
  geom_point(aes(x = POS, y = -log10(p)), color = '#62B197', data = data2)+
  scale_x_continuous(breaks = seq(71500000,72700000,by=200000), limits = c(71500000,72700000))+
  scale_y_continuous(breaks = seq(0,20,by=2),limits = c(0,20))+
  geom_segment(aes(x = Start, xend = Stop, y = y, yend = y), data = gene1)+
  geom_segment(aes(x = Start, xend = Stop, y = y, yend = y), data = gene1)+
  geom_segment(aes(x = Start, y = y+0.4, xend = Start, yend = y-0.4), data = gene1)+
  geom_segment(aes(x = Stop, y = y+0.4, xend = Stop, yend = y-0.4), data = gene1)+
  geom_hline(yintercept = 5, color = "#F0A780", linetype = "dashed") +
  labs(title = 'Chromosome 16 (hyperlipidemia)',
       x = 'posiotion',
       y = '-log10(P)')+
  theme_minimal()+
  theme(axis.line = element_line(colour = "black"), 
        panel.grid = element_blank(),
        axis.ticks = element_line())+
  coord_fixed(ratio = 25000)
ggsave('C:/SMR/graph/locuszoom/lip_blood.pdf', p, width =8, height = 8, dpi = 300)










