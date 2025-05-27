library(CMplot)
# p_smr plot
data1 <- read.table("C:/SMR/SMR_result/FDR/blood_type_2_diabetes.csv", sep = ",", header = TRUE)
data2 <- read.table("C:/SMR/SMR_result/FDR/blood_obesity.csv", sep = ",", header = TRUE)
data3 <- read.table("C:/SMR/SMR_result/FDR/blood_hypertension.csv",sep = ",", header = TRUE)
data4 <- read.table("C:/SMR/SMR_result/FDR/blood_hyperlipidemia.csv",sep = ",", header = TRUE)
data5 <- read.table("C:/SMR/SMR_result/FDR/blood_diabetes.csv",sep = ",", header = TRUE)
data6 <- read.table('C:/SMR/SMR_result/FDR/blood_CAD.csv', sep = ',', header = T)
colname <- c("SNP", "Chromosome", "Posistion", "T2D", "obesity", "hypertension", "hyperlipidemia", "diabetes", "CAD")

df1 <- data1[,5:7]
df1 <- cbind(df1, NA)
df1[,4] <- data1$p_SMR
names(df1) <- colname

df2 <- data2[,5:7]
df2 <- cbind(df2, NA)
df2[,5] <- data2$p_SMR
names(df2) <- colname

df3 <- data3[,5:7]
df3 <- cbind(df3, NA)
df3[,6] <- data3$p_SMR
names(df3) <- colname

df4 <- data4[,5:7]
df4 <- cbind(df4, NA)
df4[,7] <- data4$p_SMR
names(df4) <- colname

df5 <- data5[,5:7]
df5 <- cbind(df5, NA)
df5[,8] <- data5$p_SMR
names(df5) <- colname

df6 <- data6[,5:7]
df6 <- cbind(df6, NA)
df6[,9] <- data6$p_SMR
names(df6) <- colname

databind <- rbind(df1, df2, df3, df4, df5, df6)
write.table(databind, "C:/SMR/graph/manhatan/blood_manhattan_cad.txt", row.names = FALSE, sep = "\t", quote = FALSE)

CMplot(databind, plot.type="m",multraits=TRUE,threshold=c(1e-6,1e-4),threshold.lty=c(1,2), 
       threshold.lwd=c(1,1), threshold.col=c("#62b197","#E18E6D"), amplify=TRUE,bin.size=1e6,
       
       signal.cex=1, file="pdf",file.name="Blood",dpi=300,file.output=TRUE,verbose=TRUE,
       points.alpha=255,legend.ncol=1, legend.pos="right")
# FDR plot
data1 <- read.table("C:/SMR/SMR_result/FDR/blood_type_2_diabetes.csv", sep = ",", header = TRUE)
data2 <- read.table("C:/SMR/SMR_result/FDR/blood_obesity.csv", sep = ",", header = TRUE)
data3 <- read.table("C:/SMR/SMR_result/FDR/blood_hypertension.csv",sep = ",", header = TRUE)
data4 <- read.table("C:/SMR/SMR_result/FDR/blood_hyperlipidemia.csv",sep = ",", header = TRUE)
data5 <- read.table("C:/SMR/SMR_result/FDR/blood_diabetes.csv",sep = ",", header = TRUE)
data6 <- read.table('C:/SMR/SMR_result/FDR/blood_CAD.csv', sep = ',', header = T)
colname <- c("SNP", "Chromosome", "Posistion", "T2D", "obesity", "hypertension", "hyperlipidemia", "diabetes", "CAD")

df1 <- data1[,5:7]
df1 <- cbind(df1, NA)
df1 <- cbind(df1, NA)
df1 <- cbind(df1, NA)
df1 <- cbind(df1, NA)
df1 <- cbind(df1, NA)
df1 <- cbind(df1, NA)
df1[,4] <- data1$FDR
names(df1) <- colname

df2 <- data2[,5:7]
df2 <- cbind(df2, NA)
df2 <- cbind(df2, NA)
df2 <- cbind(df2, NA)
df2 <- cbind(df2, NA)
df2 <- cbind(df2, NA)
df2 <- cbind(df2, NA)
df2[,5] <- data2$FDR
names(df2) <- colname

df3 <- data3[,5:7]
df3 <- cbind(df3, NA)
df3 <- cbind(df3, NA)
df3 <- cbind(df3, NA)
df3 <- cbind(df3, NA)
df3 <- cbind(df3, NA)
df3 <- cbind(df3, NA)
df3[,6] <- data3$FDR
names(df3) <- colname

df4 <- data4[,5:7]
df4 <- cbind(df4, NA)
df4 <- cbind(df4, NA)
df4 <- cbind(df4, NA)
df4 <- cbind(df4, NA)
df4 <- cbind(df4, NA)
df4 <- cbind(df4, NA)
df4[,7] <- data4$FDR
names(df4) <- colname

df5 <- data5[,5:7]
df5 <- cbind(df5, NA)
df5 <- cbind(df5, NA)
df5 <- cbind(df5, NA)
df5 <- cbind(df5, NA)
df5 <- cbind(df5, NA)
df5 <- cbind(df5, NA)
df5[,8] <- data5$FDR
names(df5) <- colname

df6 <- data6[,5:7]
df6 <- cbind(df6, NA)
df6 <- cbind(df6, NA)
df6 <- cbind(df6, NA)
df6 <- cbind(df6, NA)
df6 <- cbind(df6, NA)
df6 <- cbind(df6, NA)
df6[,9] <- data6$FDR
names(df6) <- colname

databind <- rbind(df1, df2, df3, df4, df5, df6)
write.table(databind, "C:/SMR/graph/manhatan/blood_manhattan_cad.txt", row.names = FALSE, sep = "\t", quote = FALSE)

CMplot(databind, plot.type="m",multraits=TRUE,threshold=c(0.05),threshold.lty=c(1), 
       threshold.lwd=c(1), threshold.col=c("#62b197"), amplify=TRUE,bin.size=1e6,
       signal.cex=1, file="pdf",file.name="Blood",dpi=300,file.output=TRUE,verbose=TRUE,
       points.alpha=255,legend.ncol=1, legend.pos="right")
