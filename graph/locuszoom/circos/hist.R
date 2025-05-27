library(data.table)
dia <- fread('E:/MR/T2D/type 2 diabetes.tsv', sep = '\t', header = T)
dia1 <- dia[dia$pval <= 5e-8,]
dia2 <- dia[dia$pval <= 1e-5,]
write.table(dia2, "C:/SMR/graph/locuszoom/circos/T2D_circos_point.tsv", sep = '\t', quote = F, row.names = F)
dia$chrom <- paste0('chr',dia$chrom)
dia <- read.table('C:/SMR/graph/locuszoom/circos/dia_circos_point.tsv', sep = '\t', header = T)
lip <- read.table('C:/SMR/graph/locuszoom/circos/lip_circos_point.tsv', sep = '\t', header = T)
ten <- read.table('C:/SMR/graph/locuszoom/circos/ten_circos_point.tsv', sep = '\t', header = T)
obe <- read.table('C:/SMR/graph/locuszoom/circos/obe_circos_point.tsv', sep = '\t', header = T)
T2D <- read.table('C:/SMR/graph/locuszoom/circos/T2D_circos_point.tsv', sep = '\t', header = T)
dia$color <- 'blue'
lip$color <- 'green'
ten$color <- 'red'
obe$color <- 'purple'
T2D$color <- 'pink'
hist_data <- rbind(dia, lip)
hist_data <- rbind(hist_data, ten)
hist_data <- rbind(hist_data, obe)
hist_data <- rbind(hist_data, T2D)
hist_data$chrom <- paste0('chr', hist_data$chrom)
hist <- hist1[0,]

for (color in unique(hist_data$color)){
  color_data <- hist_data[hist_data$color == color,]
  print(color)
  for (i in unique(color_data$chrom)){
    chr_data <- color_data[color_data$chrom == i,]
    circle <- ceiling(max(chr_data$pos)/10000000)
    start <- 0
    for (cir in 1:circle){
      end <- start + 10000000
      vari_data <- chr_data[chr_data$pos >= start & chr_data$pos < end, ]
      num <- length(vari_data$pos)
      hist1 <- data.frame(chr = i, value = num, color = color, cir = cir)
      hist <- rbind(hist, hist1)
      start <- start + 10000000
    }
  }
}

hist <- vari_data[0,]
for (color in unique(hist_data$color)){
  color_data <- hist_data[hist_data$color == color,]
  print(color)
  for (i in unique(color_data$chrom)){
    chr_data <- color_data[color_data$chrom == i,]
    circle <- ceiling(max(chr_data$pos)/10000000)
    start <- 0
    for (cir in 1:circle){
      end <- start + 10000000
      vari_data <- chr_data[chr_data$pos >= start & chr_data$pos < end, ]
      if (length(vari_data$chrom) == 0){
        
      }else{
      vari_data$value <- as.numeric(cir)
      hist <- rbind(hist, vari_data)
      
      }
      start <- start + 10000000
    }
  }
}

hist <- hist[hist$value != 0,]
write.table(hist, 'C:/SMR/graph/locuszoom/circos/hist.tsv', sep = '\t', quote = F, row.names = F)
write.table(hist, 'C:/SMR/graph/locuszoom/circos/hist_sample.tsv', sep = '\t', quote = F, row.names = F)
