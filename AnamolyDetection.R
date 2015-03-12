#################################################################################################
#################################################################################################
## Author: Bikash Agrawal
## Date: 12th March Feb 2015
## Email: er.bikash21@gmail.com
## Description: Anamoly detection in twitter using R.
##          
## References: 
## [1] https://blog.twitter.com/2015/introducing-practical-and-robust-anomaly-detection-in-a-time-series
## [2] https://github.com/twitter/AnomalyDetection
## source("/Users/bikash/repos/RFKaggleTitanic/R/CIRF.R")
#################################################################################################
#################################################################################################

### setting path of repo folder.
getwd()
setwd("/Users/bikash/repos/kaggle/KagglePokerRule/")

## Install anomaly detection library in R
install.packages("devtools")
devtools::install_github("twitter/AnomalyDetection")
library(AnomalyDetection)
## for detail see this repo https://github.com/twitter/AnomalyDetection
#######################################

## raw_data is default twitter present in the anomalydetection library.
data(raw_data)
res = AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', plot=TRUE)
res$plot

## anomaly detection using anomalydetection vector. It is used to detect on or more significant anomalies in a vector raw_data (observations)
AnomalyDetectionVec(raw_data[,2], max_anoms=0.02, period=1440, direction='both', only_last=FALSE, plot=TRUE)

## Anomaly detection on the last day where we can see only_last="day" flag for anomaly.
res = AnomalyDetectionTs(raw_data, max_anoms=0.02, direction='both', only_last="day", plot=TRUE)
res$plot


