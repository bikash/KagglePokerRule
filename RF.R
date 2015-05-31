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


x = data.frame(S1count=train2$S1count, S2count=train2$S2count, S3count=train2$S3count, S4count=train2$S4count, C12diff=train2$C12diff, 
               C23diff=train2$C23diff,
               C34diff=train2$C34diff, C45diff=train2$C45diff, C51diff=train2$C51diff, hand=hand)

model <- randomForest(hand~., data=x,
                       mtry=9,
                       ntree=1500,
                       do.trace=10)


prediction <- predict(model, test, type="class")

# Create submission dataframe and output to file
submit <- data.frame(id = test$id, hand = prediction)
write.csv(submit, file = "ouput/feature_random_forest_mtry.csv", row.names = FALSE)

