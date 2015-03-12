#################################################################################################
#################################################################################################
## Author: Bikash Agrawal
## Date: 12th March Feb 2015
## Email: er.bikash21@gmail.com
## Description: Apply Random forest to predict the survival rate and create a new csv file.
##              https://www.kaggle.com/c/poker-rule-induction
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

## Following Rules are classified in Poker
## 0: Nothing in hand; not a recognized poker hand 
## 1: One pair; one pair of equal ranks within five cards
## 2: Two pairs; two pairs of equal ranks within five cards
## 3: Three of a kind; three equal ranks within five cards
## 4: Straight; five cards, sequentially ranked with no gaps
## 5: Flush; five cards with the same suit
## 6: Full house; pair + different rank three of a kind
## 7: Four of a kind; four equal ranks within five cards
## 8: Straight flush; straight + flush
## 9: Royal flush; {Ace, King, Queen, Jack, Ten} + flush
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
print("Data Cleaning up process......")
train <- read.csv("data/train.csv", header=TRUE)
test <- read.csv("data/test.csv", header=TRUE)

hand <- train[,11]
head(train)
train <- train[,-11]
id <- 1:25010
train2 <- cbind(id, train)
rm("train")

head(train2)
tail(train2)
head(test)
tail(test)


hand <- factor(hand)

set.seed(61)
rf <- randomForest(train2, hand, xtest=test, ntree=1600)
predictions <- levels(hand)[rf$test$predicted]

r <- data.frame(predictions)
id <- 1:1000000
id <- data.frame(id)
r <- cbind(id, r)
colnames(r) <- c("id", "hand")
write.csv(r, "try4_randomForest_1600_withoutMTRY.csv", row.names = FALSE, col.names = TRUE)


res <- (0:9)[knn(train2, test, hand, k = 10, algorithm="cover_tree")]
r <- data.frame(res)
id <- 1:1000000
id <- data.frame(id)
r <- cbind(id, r)
colnames(r) <- c("id", "hand")
write.csv(r, "ouput/try1_knn_cover_tree_10.csv", row.names = FALSE, col.names = TRUE)
