diseases <- c('diabetes','hyperlipidemia','hypertension','obesity','T2D')

for (i in diseases){
  command_CAD <- paste0('C:/SMR/graph/locuszoom/', i, '_CAD_CAD.txt')
  command_MS <- paste0('C:/SMR/graph/locuszoom/', i, '_CAD_MS.txt')
  data1 <- read.table(command_CAD, sep = '\t', header = T)
  data2 <- read.table(command_MS, sep = '\t', header = T)
  data3 <- unique(rbind(data1, data2))
  command_result <- paste0('C:/SMR/graph/locuszoom/', i,'.txt')
  write.table(data3, command_result, sep = '\t', quote = F, row.names = F)
}

