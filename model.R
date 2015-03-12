#################################################################################################
#################################################################################################
## Author: Bikash Agrawal
## Date: 12th March Feb 2015
## Email: er.bikash21@gmail.com
## Description: Apply Random forest to predict the survival rate and create a new csv file. This algorithm might helps to be in top 10 in Kaggle competition.
##              Kaggle titanic competition in kaggle.com.
##              http://www.kaggle.com/c/titanic-gettingStarted
## Step 1:  Data clean up
## Step 2:  Calculate probability of survival using Condition Inference Random Forest.
## References: 
## [1] http://nbviewer.ipython.org/github/agconti/kaggle-titanic/blob/master/Titanic.ipynb
## [2] http://www.philippeadjiman.com/blog/category/machine-learning/
## [3] http://rforwork.info/tag/linear-discriminant-analysis/
## [4] http://curtwehrley.com/post/75217383699/handicapping-passengers-on-the-unsinkable-ship
## source("/Users/bikash/repos/RFKaggleTitanic/R/CIRF.R")
#################################################################################################
#################################################################################################


### setting path of repo folder.
getwd()
setwd("/Users/bikash/repos/kaggle/KagglePokerRule/")

library(dplyr)
library(zoo)
library(randomForest)
library(rpart)
library(rattle)
library(rpart.plot)
library(RColorBrewer)
library(lattice)
library(caret)
library(party)
library(Amelia) ## Amelia is packages to display missing data using missmap function
library(corrgram) ## display corrgram plot of different varaibles
require(Hmisc) ## used for function bystats to show relation between Age and Title
sessionInfo()

##########################################################################
########Cleaning up training dataset #####################################
##########################################################################