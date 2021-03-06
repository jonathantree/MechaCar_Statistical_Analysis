# MechaCar Statistical Analysis

## Project Overview
Using the datasets MechaCar_mpg.csv and Suspension_Coil.csv this project set out to run a statistical analysis with the following objectives:
- Deliverable 1: Linear Regression to Predict MPG
- Deliverable 2: Summary Statistics on Suspension Coils
- Deliverable 3: T-Test on Suspension Coils
- Deliverable 4: Design a Study Comparing the MechaCar to the Competition

This project used RStudio to conduct these analyses and tidyverse library.

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
  - As seen from the summary report of the linear model, the variables/coefficients provided a non-random amount of variance to the mpg values in the dataset were the intercept, vehicle length, and ground clearance and are statistically unlikely to provide random amounts of variance to the linear model. All of the remaining variables produced `Pr(>|t|)` that are above our defined confidence level of 0.05 and thus cannot be statistically considered unlikely sources of variance when predicting the MPG.
- Question 2: Is the slope of the linear model considered to be zero? Why or why not?
  - No the slope cannot be considered equal to zero based on a  `p-value: 5.35e-11`. We can thus reject the null hypothesis that the slope is equal to zero.
- Question 3: Does this linear model predict mpg of MechaCar prototypes effectively? Why or why not?
  - Base on the R<sup>2</sup> value of 0.71, this linear model is effective in predicting the MPG. Although the multiple linear regression model is effective at predicting our current dataset, the lack of significant variables is evidence of overfitting.

### Summary Statistics on Suspension Coils
The Suspension_Coil.csv dataset contains the results from multiple production lots. In this dataset, the weight capacities of multiple suspension coils were tested to determine if the manufacturing process is consistent across production lots. The following RScript creates a summary statistics table to show:

- The suspension coil’s PSI continuous variable across all manufacturing lots
- The following PSI metrics for each lot: mean, median, variance, and standard deviation.

```RScript
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
```
 #### Summary Question
- The design specifications for the suspension coils dictate that the variance of the suspension coils must not exceed 100 pounds per square inch. Does the current manufacturing data meet this design specification for all manufacturing lots in total and each lot individually? Why or why not?

#### *Summary Statistics on the whole dataset*
![Summary_Stats](/Images/SC_Summary.png)

#### When we take a look at the summary statistics for the entire dataset, a `variance = 62.29` is within the tolerance established by the manufacturing design specifications

#### *Summary Statistics on each Lot*
![Summary_Stats](/Images/Lot_Summary.png)

#### However, when we break it down by the Manufacturing lots, we can see that the previous variance of the entire dataset was strongly skewed by the variance in Lot 3 (`variance = 170.29`) which is not within the design specifications. The other two lots had much lower variance of 0.98 and 7.47. The data from these lots drives down the variance of the entire dataset to give the impression that the variance of all three lots is within the standard of <100. 


### T-Tests on Suspension Coils:
The goal of this analysis is to perform one-sample t-tests to determine if all manufacturing lots combined and each lot individually are statistically different from the population mean of 1,500 pounds per square inch.

Hypotheses:
H<sub>0</sub> : There is no statistical difference between the observed sample mean and its presumed population mean.

H<sub>a</sub> : There is a statistical difference between the observed sample mean and its presumed population mean.

#### Results

![t-tests](/Images/t-tests.png)

#### *One sample t-test comparing the sample mean 1499 PSI of to the assumed mean of 1500 PSI*
One Sample t-test

data:  SC_data$PSI
- t = -1.8931, df = 149, p-value = 0.06028

The one sample t-test of the sample mean when comparing to the population mean of 1500 PSI yields a p-value of 0.06. Thus, at an alpha of 0.05 we fail to reject the null hypothesis and there is no statistical difference between the sample mean and it presumed population mean.

#### *Testing each lot's sample mean against the population mean of 1500 PSI*

- Lot 1 :
  - Mean : 1500 PSI
  - p-value : 1
  - The sample mean from Lot 1 is numerically equivalent to the population mean of 1500 PSI and thus, produces the p-value of 1.
- Lot 2 :
  - Mean : 1500 PSI (1500.2 with the extra sig-fig)
  - p-value : 0.61
  - The mean from Lot 2 is not statistically different than the population mean at a confidence level of 0.05
- Lot 3 :
  - Mean : 1496 PSI 
  - p-value : 0.04
  - The one-sample t-test comparing the mean PSI from Lot 3 produced a p-value of 0.04. Thus, the mean value of Lot 3 is statistically different than the population mean at an alpha-level of 0.05.

## Study Design: MechaCar vs Competition

### Statistical investigation to evaluate the performance of the MechaCar vehicles against performance of vehicles from other manufacturers.

Considering that the most probabilistic customer will be one who desires a car that is the most cost-effective, this investigation will seek to compare metrics that evaluate the cost-effectiveness of the MechaCar vehicles vs those of their competitors. 

1. The metrics that would be evaluated as the best indicators of cost-effectiveness are the fuel efficiency (both highway and city), the cost of maintenance, and safety ratings. To establish the competitiveness of MechaCar with the competitors, the investigation will establish whether or not the MechaCar vehicles are have statistically higher fuel efficiency means (or are statistically no different), the mean cost of maintenance is statistically lower, and the mean safety rating is statistically higher. A result that confirms two out of the three metrics would then be a good indication that the MechaCar vehicle is more cost-effective than those of its competitors.
2. The hypotheses are as follows:
  - H<sub>0</sub> : The means of all groups are equal, or µ1 = µ2 = … = µn.
  - H<sub>a</sub> : At least one of the means is different from all other groups.  
3. To conduct this investigation, a one-way ANOVA test for each MechaCar and competitor’s metric will be conducted. The ANOVA test is used due to the ability to evaluate multiple samples at once. Because we are evaluating a dependent metric which is numeric and continuous paired with a categorical independent variable (the different competitors and MechaCar), the ANOVA test is a valid approach. If a statistically different mean is identified through this testing, a more direct two-sample t-test will be employed to compare a MechaCar metric to that of one other competitor at a time.
4. Data:
  - Most importantly, so that comparison is accurate, the data would need to include the vehicle class. The analysis should only be conducted on vehicles within the same class. 
  - The data for fuel efficiency, maintenance cost, and safety rating for each vehicle class for all the competitors along with the same data from MechaCar vehicles will be needed. 
  - These datasets should be large enough to establish a normal distribution of each metric. If a distribution other than a normal distribution is observed, a different approach must be taken. Obtaining a sufficiently large dataset will help ensure the data are normally distributed.


