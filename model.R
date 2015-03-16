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
library(rattle)
library(rpart.plot)
library(RColorBrewer)
library(lattice)
sessionInfo()

##########################################################################
########Cleaning up training dataset #####################################
##########################################################################
print("Data Cleaning up process......")
train <- read.csv("data/train.csv", header=TRUE)
test <- read.csv("data/test.csv", header=TRUE)
##########################################################################


##########################################################################
########Sorting cards and creating new fatures as the absolute value######
##########################################################################
len = length(train[,11])
for (i in 1:len)
{
  train$S1count[train$S1[i] == 1] <- train$S1count[i]+1
  train$S1count[train$S2[i] == 1] <- train$S1count[i]+1
  train$S1count[train$S3[i] == 1] <- train$S1count[i]+1
  train$S1count[train$S4[i] == 1] <- train$S1count[i]+1
  train$S1count[train$S5[i] == 1] <- train$S1count[i]+1
  
  train$S2count[train$S1[i] == 2] <- train$S2count[i]+1
  train$S2count[train$S2[i] == 2] <- train$S2count[i]+1
  train$S2count[train$S3[i] == 2] <- train$S2count[i]+1
  train$S2count[train$S4[i] == 2] <- train$S2count[i]+1
  train$S2count[train$S5[i] == 2] <- train$S2count[i]+1
  
  train$S3count[train$S1[i] == 3] <- train$S3count[i]+1
  train$S3count[train$S2[i] == 3] <- train$S3count[i]+1
  train$S3count[train$S3[i] == 3] <- train$S3count[i]+1
  train$S3count[train$S4[i] == 3] <- train$S3count[i]+1
  train$S3count[train$S5[i] == 3] <- train$S3count[i]+1
  
  train$S4count[train$S1[i] == 4] <- train$S4count[i]+1
  train$S4count[train$S2[i] == 4] <- train$S4count[i]+1
  train$S4count[train$S3[i] == 4] <- train$S4count[i]+1
  train$S4count[train$S4[i] == 4] <- train$S4count[i]+1
  train$S4count[train$S5[i] == 4] <- train$S4count[i]+1
  
}

##########################################################################
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




train <- train[1:17999,]
#test <- combi[892:1309,]
test <- train[18000:25010,]

set.seed(61)
rf <- randomForest(as.factor(hand) ~
                     S1 + C1 + S2 + C2 + S3 + C3 + S4 + C4 + S5 + C5, data=train, ntree=2000, mtry=9)
prediction <- predict(rf, test, type="class")

## calculate accuracy of model
accuracy = sum(prediction==test$hand)/length(prediction)
print (sprintf("Accuracy = %3.2f %%",accuracy*100)) ### 82.84% accuracy of model

# Create submission dataframe and output to file
out <- data.frame(id = test$id, hand = prediction)
write.csv(out, "ouput/randomforestCSV.csv", row.names = FALSE)


predictions <- levels(hand)[rf$test$predicted]

r <- data.frame(predictions)
id <- 1:1000000
id <- data.frame(id)
r <- cbind(id, r)
colnames(r) <- c("id", "hand")
write.csv(r, "ouput/randomforestCSV.csv", row.names = FALSE)


##########################################################################
##########################################################################

res <- (0:9)[knn(train2, test, hand, k = 10, algorithm="cover_tree")]
r <- data.frame(res)
id <- 1:1000000
id <- data.frame(id)
r <- cbind(id, r)
colnames(r) <- c("id", "hand")
write.csv(r, "ouput/try1_knn_cover_tree_10.csv", row.names = FALSE, col.names = TRUE)
