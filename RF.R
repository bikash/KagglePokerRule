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

library(randomForest)
train <- read.csv("data/train_modified.csv", header=TRUE)
test <- read.csv("data/test_modified.csv", header=TRUE)

hand <- train[,10]
head(train)
train <- train[,-10]
id <- 1:25010
train2 <- cbind(train,id)
rm("train")
head(train2)
tail(train2)
head(test)
tail(test)

hand <- factor(hand)


set.seed(1234)


model <- randomForest(x=train2,
                       y=hand,
                       mtry=9,
                       ntree=1500,
                       do.trace=10)


rf <- randomForest(train2, hand, xtest=test, ntree=1600, mtry=9)
predictions <- levels(hand)[rf$test$predicted]

pred <- data.frame(predictions)
id <- 1:1000000
id <- data.frame(id)
pred <- cbind(id, pred)
colnames(pred) <- c("id", "hand")
write.csv(pred, "poker_randomForest.csv", row.names = FALSE, col.names = TRUE)
