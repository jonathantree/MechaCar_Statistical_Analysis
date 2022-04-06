# MechaCar Statistical Analysis

## Project Overview
Using the datasets MechaCar_mpg.csv  Suspension_Coil.csv this project set out to run a statistical analysis with the following objectives:
- Deliverable 1: Linear Regression to Predict MPG
- Deliverable 2: Summary Statistics on Suspension Coils
- Deliverable 3: T-Test on Suspension Coils
- Deliverable 4: Design a Study Comparing the MechaCar to the Competition

This project used RStudio to conduct these analyses and tidyverse and ggplot libraries.

### Deliverable 1 Results:
Code:
```RScript
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
```


