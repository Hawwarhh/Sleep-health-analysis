library(tidyverse)
library(psych)
library(gridExtra)
library(dplyr)
library(knitr)
library(ggplot2)
library(caret)


data<-read.csv("Sleep_health_and_lifestyle_dataset.csv")

summary(data)
View(data)
head(data)


tail(data)

glimpse(data)


data$sleep_category <- cut(data$Sleep.Duration, breaks = c(0, 6.5, 9),
                                  labels = c("Poor Sleep", "Good Sleep"))
data



#finding missing

is.na(data)

colSums(is.na(data))

attach(data)

ggplot(data, aes(x = Age,fill =Age )) +
  geom_bar(fill='brown3')+
  ggtitle("Age Distribution") 

ggplot(data, aes(x = Age, fill = Gender)) +
  geom_bar() +
  ggtitle("Distribution of Age by Gender")

#ggplot(data, aes(x= 'Strip Chart', y = Age))+
 # geom_jitter(width = 0.2,height = 10, color="brown3")
  
  #grid Chart for BMI category and Age
stripchart(Age~BMI.Category,
           data = data,
           main='Strip Chart for BMI Category by Age',
           xlab='BMI Category',
           ylab= 'Age',
           col='brown3',
           vertical=TRUE,
           pch=16)

stripchart(Age~Sleep.Disorder,
           data = data,
           main='Strip Chart Sleep Disorder by Age',
           xlab='Sleep Disorder',
           ylab= 'Age',
           col='brown3',
           vertical=TRUE,
           pch=16) 



ggplot(data, aes(x = sleep_category, y = BMI.Category, color = Gender)) +
  geom_jitter() +
  ggtitle("Pairwise Comparison of Sleep category and BMI by Gender")

ggplot(data, aes(x = Physical.Activity.Level, fill = sleep_category)) +
  geom_density(alpha = 0.5) +
  ggtitle("Density Plot of Phsical Activity by Sleep Category")

ggplot(data, aes(x = Physical.Activity.Level, fill = sleep_category)) +
  geom_histogram(binwidth = 5, position = "identity") +
  facet_grid(.~Gender) +
  ggtitle("Distribution of Gender by Sleep Category and Physical Avtivity Level")


ggplot(data, aes(x = Stress.Level, fill = sleep_category)) +
  geom_density(alpha = 0.5) +
  ggtitle("Density Plot of Stress Level by Sleep Category")

ggplot(data, aes(x = Heart.Rate,fill =sleep_category )) +
  geom_density(alpha=0.5)+
  ggtitle("Impact of heart Rate on Sleep")

ggplot(data, aes(x = Sleep.Duration, fill = Occupation)) +
  geom_histogram(binwidth = 2, position = "identity") +
  facet_grid(.~Occupation) +
  ggtitle("Distribution of Sleep Duration  by Occupation")



grid.arrange(
  ggplot(data, aes(x = sleep_category, y = Stress.Level, fill = sleep_category)) +
    geom_boxplot() +
    ggtitle("Stress Level by Sleep Category"),
  
  ggplot(data, aes(x = sleep_category, y = Daily.Steps, fill = sleep_category)) +
    geom_boxplot() +
    ggtitle("Product Daily Steps by Sleep Category"),
  
  
  ncol = 2
)

library(rpart)
library(rpart.plot)

# Fit the decision tree model
tree_model <- rpart(sleep_category ~ Age + Physical.Activity.Level + Sleep.Duration +Quality.of.Sleep + Stress.Level +Heart.Rate + Daily.Steps,
                    data = data, method = "class")

# Visualize the decision tree
rpart.plot(tree_model, extra = 1)

# Predictions using the decision tree model
predictions_tree <- predict(tree_model, data, type = "class")

# Confusion Matrix for Decision Tree
conf_matrix_tree <- table(predictions_tree, data$sleep_category)

# Calculate metrics for the decision tree model
calculate_metrics <- function(conf_matrix) {
  precision <- conf_matrix[2, 2] / sum(conf_matrix[, 2])
  recall <- conf_matrix[2, 2] / sum(conf_matrix[2, ])
  f1_score <- 2 * (precision * recall) / (precision + recall)
  accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)
  
  return(c(Precision = precision, Recall = recall, F1_Score = f1_score, Accuracy = accuracy))
}

metrics_tree <- calculate_metrics(conf_matrix_tree)

cat("Decision Tree Model Precision:", metrics_tree["Precision"], "\n")
cat("Decision Tree Model Recall:", metrics_tree["Recall"], "\n")
cat("Decision Tree Model F1 Score:", metrics_tree["F1_Score"], "\n")
cat("Decision Tree Model Accuracy:", metrics_tree["Accuracy"], "\n")

# Create a SVM model

library(caTools)
set.seed(123) 
sample = sample.split(data$sleep_category, SplitRatio = .80)


train = subset(data, sample == TRUE)
test  = subset(data, sample == FALSE)

testc<-test$sleep_category
test <- test[ c(1:14)]

test$Occupation <-factor(test$Occupation,levels = levels(train$Occupation))
test$sleep_category<-factor(test$sleep_category, levels = levels(train$sleep_category))

colnames(data)
colnames(test)
colnames(testc)



library(e1071)

SVMFIT <- svm(as.factor(sleep_category)~., data = train, kernel = "polynomial", cost = 5, tolerance = 0.001, epsilon = 0.1,
              shrinking = TRUE, cross = 0)
# Plot Results
summary(SVMFIT)


#Predictions = predict(SVMFIT, test)
#SVMCLASSIFIER= table(Predictions, testc)
#confusionMatrix(SVMCLASSIFIER)

library(C50)

CTree<-C5.0(as.factor(sleep_category) ~ ., data = train , trials = 10, rules = FALSE)
summary(CTree) 


#plot(CTree, metric = "Accuracy")



oneTreeProbs <- predict(CTree, test)
c50<- table(oneTreeProbs, testc)
confusionMatrix(c50)


