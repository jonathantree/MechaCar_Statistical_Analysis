###########################################################################
###########################################################################
###                                                                     ###
###                          LINEAR REGRESSION                          ###
###                             PREDICT MPG                             ###
###                                                                     ###
###########################################################################
###########################################################################
library(tidyverse)

#Data Source
data <- "~/R_Analysis/BootCamp_Mod15/Challenge/Data/MechaCar_mpg.csv"

# read in the data
data_mpg <- read.csv(file = data, check.names = F, stringsAsFactors = F)

#Get the names of the columns
colnames(data_mpg) 

mpg_matrix <- as.matrix(data_mpg[,c("vehicle_length","vehicle_weight","spoiler_angle","ground_clearance", "AWD","mpg")]) 

#calculate correlation coefficient
correlation_matrix <- cor(mpg_matrix)

#Generate the multivariate linear regression model
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = data_mpg)

#Generate a summary table
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD, data = data_mpg))


############################################################################
############################################################################
###                                                                      ###
###                          SUMMARY STATISTICS:                         ###
###                         SUSPENSION COIL DATA                         ###
###                                                                      ###
############################################################################
############################################################################

#Data Source
data <- "~/R_Analysis/BootCamp_Mod15/Challenge/Data/Suspension_Coil.csv"

# read in the data
SC_data <- read.csv(file = data, check.names = F, stringsAsFactors = F)

#Create a summary statistics dataframe

summary_stats <- SC_data %>% summarise(mean = mean(PSI),
                                       median = median(PSI),
                                       variance=var(PSI),
                                       SD = sd(PSI),
                                       n = n())
#Use grouping to reveal the summary breakdown by Lot
Lot_Summary <- SC_data %>% group_by(Manufacturing_Lot) %>% 
  summarize(mean = mean(PSI),
             median = median(PSI),
             variance=var(PSI),
             SD = sd(PSI),
             n = n(),
            .groups = 'keep')


###########################################################################
###########################################################################
###                                                                     ###
###                     T-TESTS ON SUSPENSION COILS                     ###
###                                                                     ###
###########################################################################
###########################################################################

#Define variables to hold the mean value for the entire dataset and each Lot
pop_mean <- summary_stats$mean
Lot1 <- SC_data %>% filter(Manufacturing_Lot=="Lot1")
Lot2 <- SC_data %>% filter(Manufacturing_Lot=="Lot2")
Lot3 <- SC_data %>% filter(Manufacturing_Lot=="Lot3")

# t-test to compare the mean values
t.test(SC_data$PSI, mu = 1500)
t.test(Lot1$PSI, mu = 1500)
t.test(Lot2$PSI, mu = 1500)
t.test(Lot3$PSI, mu = 1500)

t.test(subset(SC_data$PSI, SC_data$Manufacturing_Lot=="Lot1"), mu = 1500)
t.test(subset(SC_data$PSI, SC_data$Manufacturing_Lot=="Lot2"), mu = 1500)
t.test(subset(SC_data$PSI, SC_data$Manufacturing_Lot=="Lot3"), mu = 1500)
