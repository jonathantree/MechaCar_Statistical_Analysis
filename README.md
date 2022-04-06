# MechaCar Statistical Analysis

## Project Overview
Using the datasets MechaCar_mpg.csv  Suspension_Coil.csv this project set out to run a statistical analysis with the following objectives:
- Deliverable 1: Linear Regression to Predict MPG
- Deliverable 2: Summary Statistics on Suspension Coils
- Deliverable 3: T-Test on Suspension Coils
- Deliverable 4: Design a Study Comparing the MechaCar to the Competition

This project used RStudio to conduct these analyses and tidyverse and ggplot libraries.

### Linear Regression to Predict MPG:
Hypotheses:
H<sub>0</sub> : The slope of the linear model is zero, or m = 0

H<sub>a</sub> : The slope of the linear model is not zero, or m ≠ 0

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
#### *Correlation Matrix*
![CorrelationMatrix.png](/Images/D1_CorrMatric.png)

#### *Summary Statistics for the Regression Model*
![SummaryStats.png](/Images/D1_LR_Summary.png)

- Question 1: Which variables/coefficients provided a non-random amount of variance to the mpg values in the dataset?
  - As seen from the summary report of the linear model, the variables/coefficients provided a non-random amount of variance to the mpg values in the dataset were the intercept, vehicle length, and ground clearence and are statistically unlikely to provide random amounts of variance to the linear model. All of the remaining variables produced `Pr(>|t|)` that are above our defined confidence level of 0.05 and thus cannot be satistically considered unlikely sources of variance when predicting the MPG.
- Question 2: Is the slope of the linear model considered to be zero? Why or why not?
  - No the slope cannot be considered equal to zero based on a  `p-value: 5.35e-11`. We can thus reject the null hypothesis that the slope is equal to zero.
- Question 3: Does this linear model predict mpg of MechaCar prototypes effectively? Why or why not?
  - Base on the R<sup>2</sup> value of 0.71, this linear model is effective in predicting the MPG. Although the multiple linear regression model is effective at predicting our current dataset, the lack of significant variables is evidence of overfitting.


 
