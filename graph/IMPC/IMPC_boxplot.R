library(readxl)
library(ggplot2)
data <- read_excel("C:/SMR/IMPC_result/CAMK1D/h_heart_weight.xlsx", sheet = 1)
data <- read.table('C:/SMR/graph/IMPC/新建文件夹/AGPAT1_Glucose.tsv', sep = '\t', header = T)

for (x in 1){ # 批量运行代码
  col <- c(21,22,28)
  #y_name <- data[1,3]
  #y_name <- 'Circulating Alanine aminotransferase Level'
  y_name <- 'Circulating Glucose Level'
  #y_name <- 'Prolong RR Interval'
  #y_name <- 'Circulating Alkaline Phosphatase Level'
  #y_name <- 'Circulating Total Protein Level'
  #y_name <- 'Blood Urea Nitrogen Level'
  #y_name <- 'Lean Body Mass'
  #y_name <- 'Spleen Weight'
  #y_name <- 'Total Body Fat Amount'
  #y_name <- 'Fasting Circulating Glucose Level'
  #y_name <- 'Locomotor Activity'
  #y_name <- 'Vertical Activity'
  #y_name <- 'Hyperactivity'
  #y_name <- 'Startle Reflex'
  #y_name <- 'Glucose Tolerance'
  x_name <- data[1,10]
  file_name <- paste0('C:/SMR/graph/IMPC/',x_name, '_', y_name,'.pdf')
  x_name <- paste(x_name,'(Metabolism/Adipose tissue)')
  #x_name <- paste(x_name,'(Cardiovascular system)')
  #x_name <- paste(x_name,'(Behavior/Nervous system)')
  data <- data[,col]
  female_wt <- data.frame(group = 'female_HOM', value = data[data$biological_sample_group == 'experimental' & data$sex == 'female', 3], colour = '#B8DDBC')
  female_hom <- data.frame(group = 'female_WT', value = data[data$biological_sample_group == 'control' & data$sex == 'female', 3], colour = '#F0A780')
  male_wt <- data.frame(group = 'male_HOM', value = data[data$biological_sample_group == 'experimental' & data$sex == 'male', 3], colour = '#B8DDBC')
  male_hom <- data.frame(group = 'male_WT', value = data[data$biological_sample_group == 'control' & data$sex == 'male', 3], colour = '#F0A780')
  df <- rbind(female_wt,female_hom,male_wt,male_hom)
  colnames(df)[2] <- 'data_point'
  df$data_point <- as.numeric(df$data_point)
  df$group <- factor(df$group, levels = c('female_WT','female_HOM','male_WT','male_HOM'))
  y_start_female <- max(max(as.numeric(female_wt$data_point)), max(as.numeric(female_hom$data_point)))*1.05
  y_start_male <- max(max(as.numeric(male_wt$data_point)), max(as.numeric(male_hom$data_point)))*1.05
  
  
  p <- ggplot(df, aes(x=group,y=data_point))+
    geom_boxplot(colour = c('#62B197','#F0A780','#62B197','#F0A780'), 
                 fill = c(alpha('#62B197',0.3), alpha('#F0A780',0.3), alpha('#62B197',0.3), alpha('#F0A780',0.3)),
                 width = 0.3)+
    theme(panel.background = element_blank(), 
          panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(),
          axis.line = element_line(colour = "black", size = 0.5),
          axis.ticks = element_line(colour = "black"),
          axis.text = element_text(size = 18),
          axis.title = element_text(size = 24))+
    geom_segment(aes(x = 1, xend = 2, y = y_start_female), size = 0.3)+
    geom_segment(aes(x = 3, xend = 4, y = y_start_male), size = 0.3)+
    labs(x = x_name, y = y_name)
  print(p)
  ggsave(file_name, plot = p, width = 8, height = 5, dpi = 300)
}



data <- read.csv("C:/SMR/IMPC_result/G-P/MARS_FAT_MASS.tsv", sep = '\t', header = T)


col <- c(21,22,28)
#y_name <- data[1,3]
#y_name <- 'Circulating Alanine  Transaminase Level'
#y_name <- 'Circulating Glucose Level'
y_name <- 'Total Body Fat Amount'
#y_name <- 'Circulating Creatinine Level'
#y_name <- 'Circulating Cholesterol Level'
#y_name <- 'Circulating LDL Cholesterol Level'
#y_name <- 'Circulating Glycerol Level'
#y_name <- 'Circulating Alkaline Phosphatase Level'
#y_name <- 'Fasting Circulating Glucose Level'
x_name <- data[1,10]
file_name <- paste0('C:/SMR/graph/IMPC/g-p/',x_name, '_', y_name,'.pdf')
x_name <- paste(x_name,'(Metabolism/Adipose tissue)')
data <- data[,col]
female_wt <- data.frame(group = 'female_WT', value = data[data$biological_sample_group == 'experimental' & data$sex == 'female', 3])
female_hom <- data.frame(group = 'female_HOM', value = data[data$biological_sample_group == 'control' & data$sex == 'female', 3])
male_wt <- data.frame(group = 'male_WT', value = data[data$biological_sample_group == 'experimental' & data$sex == 'male', 3])
male_hom <- data.frame(group = 'male_HOM', value = data[data$biological_sample_group == 'control' & data$sex == 'male', 3])
df <- rbind(female_wt,female_hom,male_wt,male_hom)
colnames(df)[2] <- 'data_point'
df$data_point <- as.numeric(df$data_point)
df$group <- factor(df$group, levels = c('female_WT','female_HOM','male_WT','male_HOM'))
y_start_female <- max(max(as.numeric(female_wt$data_point)), max(as.numeric(female_hom$data_point)))*1.05
y_start_male <- max(max(as.numeric(male_wt$data_point)), max(as.numeric(male_hom$data_point)))*1.05

p <- ggplot(df, aes(x=group,y=data_point))+
  geom_boxplot(colour = c('#62B197','#F0A780','#62B197','#F0A780'), 
               fill = c(alpha('#62B197',0.3), alpha('#F0A780',0.3), alpha('#62B197',0.3), alpha('#F0A780',0.3)),
               width = 0.3)+
  theme(panel.background = element_blank(), 
        panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        axis.line = element_line(colour = "black", size = 0.5), 
        axis.ticks = element_line(colour = "black"),
        axis.text = element_text(size = 18),
        axis.title = element_text(size = 24))+
  geom_segment(aes(x = 1, xend = 2, y = y_start_female), size = 0.5)+
  geom_segment(aes(x = 3, xend = 4, y = y_start_male), size = 0.5)+
  labs(x = x_name, y = y_name)
print(p)
ggsave(file_name, plot = p, width = 8, height = 6, dpi = 300)


x_name <- paste(x_name,'(Cardiovascular system)')
x_name <- paste(x_name,'(Metabolism/Adipose tissue)')