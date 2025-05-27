data <- read.table('C:/SMR/graph/coloc_upset/liver.txt', sep = '\t', header = T)
dia <- data$diabetes[data$diabetes != '']
lip <- data$hyperlipdemia[data$hyperlipdemia != '']
ten <- data$hypertension[data$hypertension != '']
obe <- data$obesity[data$obesity != '']
T2D <- data$T2D[data$T2D != '']
CAD <- data$CAD[data$CAD != '']
list <- unique(c(dia, lip, ten, obe, T2D, CAD))
data_chord <- gene[0,]
for (i in list){
  a <- 0
  b <- 0
  c <- 0
  d <- 0
  e <- 0
  f <- 0
  if ( i %in% dia){a <- 1}
  if ( i %in% lip){b <- 1}
  if ( i %in% ten){c <- 1}
  if ( i %in% obe){d <- 1}
  if ( i %in% T2D){e <- 1}
  if ( i %in% CAD){f <- 1}
  #if ( a+b+c+d+e+f >= 3){
  gene <- data.frame(gene = i, diabetes = a, hyperlipidemia = b, hypertension = c, obesity = d, T2D = e, CAD = f)
  data_chord <- rbind(data_chord, gene)#}
}
write.table(data_chord, 'C:/SMR/graph/coloc_upset/liver_chord_cad_ms.csv', sep = ',', quote = F, row.names = F)


data <- read.table("C:/SMR/graph/coloc_upset/liver_chord_cad_ms.csv", sep = ',', header = T)
data1 <- data[0,]
for (i in 1:335) {
  if(data[i,2]+data[i,3]+data[i,4]+data[i,5]+data[i,6]+data[i,7] >= 3){
    data1 <- rbind(data1, data[i,])
  }
}
data1 <- as.data.frame(data1)
write.table(data1, 'C:/SMR/graph/coloc_upset/liver_chord_cad_ms_1.csv', sep = ',', quote = F, row.names = F)
