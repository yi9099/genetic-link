data1 <- read.table("C:/SMR/graph/coloc_upset/blood.txt", sep = "\t", header = T)
data2 <- read.table("C:/SMR/graph/coloc_upset/brain.txt", sep = "\t", header = T)
data3 <- read.table("C:/SMR/graph/coloc_upset/liver.txt", sep = "\t", header = T)

#blood
gene1 <- intersect(data1$diabetes, data1$hyperlipdemia)
gene2 <- intersect(data1$t2d, data1$hypertension)
gene3 <- intersect(gene1, gene2)
gene4 <- intersect(gene1, data1$hypertension)
gene5 <- intersect(gene1, data1$t2d)
gene6 <- intersect(gene2, data1$hyperlipdemia)
gene7 <- intersect(gene2, data1$diabetes)

#brain
ad <- intersect(data2$hyperlipdemia, data2$t2d)
ns <- intersect(data2$diabetes, data2$hypertension)
adns <- intersect(ad, ns)
ads <- intersect(ad, data2$diabetes)
adn <- intersect(ad, data2$hypertension)
nsy <- intersect(ns, data2$obesity)
nsd <- intersect(ns, data2$t2d)
nsa <- intersect(ns, data2$hyperlipdemia)

#liver
ad <- intersect(data3$hyperlipdemia, data3$t2d)
ns <- intersect(data3$hypertension, data3$diabetes)
adns <- intersect(ad, ns)
nsa <- intersect(ns, data3$hyperlipdemia)
ads <- intersect(ad, data3$diabetes)
ds <- intersect(data3$diabetes, data3$t2d)
dsy <- intersect(ds, data3$obesity)
adn <- intersect(ad, data3$hypertension)
nsd <- intersect(ns, data3$t2d)

