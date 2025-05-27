dia <- read.table('C:/SMR/graph/locuszoom/circos/dia_circos_point.tsv', sep = '\t', header = T)
lip <- read.table('C:/SMR/graph/locuszoom/circos/lip_circos_point.tsv', sep = '\t', header = T)
ten <- read.table('C:/SMR/graph/locuszoom/circos/ten_circos_point.tsv', sep = '\t', header = T)
obe <- read.table('C:/SMR/graph/locuszoom/circos/obe_circos_point.tsv', sep = '\t', header = T)
T2D <- read.table('C:/SMR/graph/locuszoom/circos/T2D_circos_point.tsv', sep = '\t', header = T)
dia$color <- '#9DD0C7'
lip$color <- '#9180AC'
ten$color <- '#D9BDD8'
obe$color <- '#E58579'
T2D$color <- '#8AB1D2'
point_data <- rbind(dia, lip)
point_data <- rbind(point_data, ten)
point_data <- rbind(point_data, obe)
point_data <- rbind(point_data, T2D)

point_data$chrom <- paste0('chr', point_data$chrom)
point_data <- point_data[point_data$chrom != 'chr5',]
point_data <- point_data[point_data$chrom != 'chr13',]
point_data <- point_data[point_data$chrom != 'chr14',]
point_data <- point_data[point_data$chrom != 'chr21',]
point_data <- point_data[point_data$chrom != 'chr22',]
