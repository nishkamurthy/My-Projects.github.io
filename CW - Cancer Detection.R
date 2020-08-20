#Capstone: Breast Cancer Prediction
#Optional: calculate accuracy with just one set of attributes for mean

library(corrplot)
library(caret)
library(ggplot2)
library(utils)
library(rpart)
library(kknn)
library(readr)

#Data Preparation
#Read the data file
cancerSet = read.csv("cData.csv")
#Data Exploration
#Inspect the data using the View function. 
View(cancerSet)
#Write code for str, summary, head, tail, is.na
str(cancerSet)
summary(cancerSet)
head(cancerSet)
tail(cancerSet)
sum(is.na(cancerSet))
nrow(cancerSet)
#Plot the diagnosis variable on single variable graph and identify any odd behavior
ggplot(cancerSet, aes(diagnosis)) + geom_bar(color="white", fill="pink")
#some odd behavior is that because i haven't cleaned my dataset, there is a column on the x axis
#that is unlabeled. those are the NAs. there is one datapoints with no diagnosis code.

#how many are benign and malignant observations are found?
#table() function
table(cancerSet$diagnosis)
#what is the percentage split between M and B
#Use: prop.table(table(data$diagnosis))
prop.table(table(cancerSet$diagnosis))

colSums(is.na(cancerSet))
########### Data Wrangling 
# Are there any columns that need to be dropped?
colnames(cancerSet)
cancerSet=cancerSet[,-c(1, 2, 34)] #deleted first column so the second column moved to 1 >>
#I deleted these 3 columns because 31 and 2 were filled with NAs and blank spaces, and they had no overall effect on diagnosis. 
#Column 1 was only a way to identify a patient, which is also unnecessary when figuring out if the tumor was cancerous or not.
View(cancerSet) 
# Are there rows that should be dropped?
cancerSet=cancerSet[-6,]
cancerSet=cancerSet[-13,]
cancerSet=cancerSet[-22,]
sum(is.na(cancerSet))
cancerSet=cancerSet[-which(cancerSet$diagnosis==""),]
View(cancerSet)
# Which variables/features are not significant in predicting the outcomes?
#y,id,unnamed
# Remove complete.cases

############## Data Visualization
#Check Diagnosis distribution by drawing a single variable plot
ggplot(cancerSet, aes(diagnosis)) + geom_bar() #?????
#Find correlation of all variables
#Use cor(datasetname)           #Got error? Drop the variable that is not numeric when creating a correlation matrix
#Draw a correlation plot
# install.packages("corrplot")
# library(corrplot)
# corrplot(datasetname)
#corrplot without diagnosis
colnames(cancerSet)
all2 = cor(cancerSet[,-1])
corrplot (all, method="pie", type="lower")
### OR ###
cancerSet$diagnosis=ifelse(cancerSet$diagnosis=="M", 1, ifelse(cancerSet$diagnosis=="B", 0, 1))
View(cancerSet)
table(cancerSet$diagnosis)
x=cor(cancerSet)
corrplot (x, method="pie", type="lower")
#Should they be observed independently for mean, error, and worst?
#there are 3 different datasets in cancer data for mean, se and worst 

#Correlation between all variables

#cor for mean
#corrplot for mean. Show pie graph with only lower half
colnames(cancerSet)
meanCor = cor(cancerSet[2:11])
corrplot (meanCor, method = "pie", type = "lower")
#repeat for se, and worst
#SE: 
colnames(cancerSet)
seCor = cor(cancerSet[12:21])
corrplot (seCor, method = "pie", type = "lower")

#WORST:
colnames(cancerSet)
worstCor = cor(cancerSet[22:31])
corrplot (worstCor, method = "pie", type = "lower")

#heatmap
col<-colorRampPalette(c('blue','white','red'))(20)
heatmap(all2,col=col,symm=F)

############### Feature Engineering - which variables to pick?
#analysis:  high correlation value means it has “multicollinearity” between variables.
#Use one variable only with high correlation for model development 

############## building models
#logistic regression
#KKNN - knearest neighbor
#rpart and confusion matrix
#--- To be continued --


#analysis:  high correlation value means it has “collinearity” between variables.
#Use one variable only with high correlation for model development as it does not add much value to use similar features.

#the radius, parameter and area are highly correlated as expected from their relation so from these we will use anyone of them
#compactness_mean, concavity_mean and concavepoint_mean are highly correlated so we will use compactness_mean from here
#so selected Parameter for use is perimeter_mean, texture_mean, compactness_mean, symmetry_mean*

####################################### Visualization
################# UNIVARIATE ANALYSIS ONE VARIABLE PLOTS

#These plots show that, in general, malignant diagnoses have higher scores in all variables.

# library(reshape2)
# df.m <- melt(data[,-c(12:32)], id="diagnosis" )
### Melts the dataset for diagnosis and creates the boxplots
###ggplot(data = df.m, aes(x=variable, y=value)) + 
##  geom_boxplot(aes(fill=diagnosis)) + facet_wrap( ~ variable, scales="free")+ xlab("Variables") + ylab("")+ guides(fill=guide_legend(title="Group"))

#### converting the diagnosis column back to factor so that color dimension can be used
cancerSet$diagnosis = as.factor(cancerSet$diagnosis)
View(cancerSet)
####These plots show that, in general, malignant diagnoses have higher scores in all variables.
p1=ggplot(cancerSet, aes(y=radius_mean, fill=diagnosis)) + geom_boxplot() 
#plot boxplots for all variables for _mean and assign them to a variable
p2=ggplot(data = cancerSet, aes(y=texture_mean, fill=diagnosis)) + geom_boxplot() 
p3=ggplot(data = cancerSet, aes(y=perimeter_mean, fill=diagnosis)) + geom_boxplot() 
p4=ggplot(data = cancerSet, aes(y=area_mean, fill=diagnosis)) + geom_boxplot() 
p5=ggplot(data = cancerSet, aes(y=smoothness_mean, fill=diagnosis)) + geom_boxplot() 
p6=ggplot(data = cancerSet, aes(y=compactness_mean, fill=diagnosis)) + geom_boxplot() 
p7=ggplot(data = cancerSet, aes(y=concavity_mean, fill=diagnosis)) + geom_boxplot() 
p8=ggplot(data = cancerSet, aes(y=concave.points_mean, fill=diagnosis)) + geom_boxplot() 
p9=ggplot(data = cancerSet, aes(y=symmetry_mean, fill=diagnosis)) + geom_boxplot() 
p10=ggplot(data = cancerSet, aes(y=fractal_dimension_mean, fill=diagnosis)) + geom_boxplot() 

#### put all plots on one graph
library(cowplot)    # used for combining multiple plots 
plot_grid(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10, nrow=3)
#-------------- Visualization Complete ---------------# 
  
index = createDataPartition(cancerSet$diagnosis, p=0.7, list=F)
trainSet = cancerSet[index,]
testSet = cancerSet[-index,]

testSet=trainSet[,c(1:11)]

prediction_var = c('diagnosis', 'texture_mean', 'perimeter_mean', 'smoothness_mean', 'compactness_mean', 'symmetry_mean')

trainSet_features = trainSet[, prediction_var]
testSet_features = testSet[, prediction_var]
cancerSet$diagnosis
model = glm(diagnosis~., trainSet_features, family=binomial(link="logit"))

predict = predict(model, testSet_features, type="response")

results = ifelse(predict<0.5, 0, 1)
set.seed(123)
accuracy.glm = mean(results == testSet_features$diagnosis)
accuracy.glm #0.9176471


#######################
Framework:
  Visualization
Split data - train and test
Logistic Regression
KKNN

############## building models ############
#Split Test and Training Dataset
index = createDataPartition(cancerSet$diagnosis, p=0.7, list=F)
trainSet = cancerSet[index,]
testSet = cancerSet[-index,]

#testSet=trainSet[,c(1:11)]

prediction_var = c('diagnosis', 'texture_mean', 'perimeter_mean', 'smoothness_mean', 'compactness_mean', 'symmetry_mean')

trainSet_features = trainSet[, prediction_var]
testSet_features = testSet[, prediction_var]
cancerSet$diagnosis
model = glm(diagnosis~., trainSet_features, family=binomial(link="logit"))

predict = predict(model, testSet_features, type="response")

results = ifelse(predict<0.5, 0, 1)
set.seed(123)
accuracy.glm = mean(results == testSet_features$diagnosis)
accuracy.glm #0.9176471

### CONFUSION MATRIX
#table(as.factor(testingDataset$diagnosis), as.factor(results))
#or
cm_lg  <- confusionMatrix(as.factor(results), as.factor(testSet$diagnosis)) 
cm_lg

# Confusion Matrix and Statistics
# 
#               Reference
# Prediction  0     1
#   0         106   8
#   1         6     50

# Optional: Print ROC and AUC curve
# install.packages("pROC")
# library(pROC)
# # Compute roc
# roc.lg = roc(as.numeric(testingDataset$diagnosis), results)
# plot(roc.lg, print.auc = TRUE)

################################ KNN ###########################KNN
# in KNN the prediction variable as to be a factor or categorical variable
# change the diagnosis to factor 
testSet
trainSet$diagnosis = as.factor(trainSet$diagnosis)
model.kknn = train(diagnosis~., trainSet, method="kknn")
predict.kknn=predict(model.kknn, testSet)
accuracy.kknn = mean(predict.kknn == testSet$diagnosis)
accuracy.kknn  #[1] 0.9588235
#0.9529412
cm_knn  <- confusionMatrix(predict.kknn, as.factor(testSet$diagnosis))   
cm_knn
#             Reference
# Prediction    0  1
# 0           102  5
# 1             5  58
# Optional: Print ROC and AUC curve
install.packages("pROC")
library(pROC)
# # Compute roc
roc.kknn1 = roc(as.numeric(as.numeric(testSet$diagnosis)), as.numeric(predict.kknn))
plot(roc.kknn1, print.auc = TRUE)
# Run the model on entire dataset, and not just selected features to check for accuracy and gradually remove one feature at a time
model.rf = train(diagnosis~., trainSet, method="rf")
predict.rf = predict(model.rf, testSet)
accuracy.rf = mean(predict.rf==testingDataset$diagnosis)
accuracy.rf #0.9705882
cm_rf  <- confusionMatrix(predict.rf, as.factor(testingDataset$diagnosis))   
cm_rf
# 
# Reference
# Prediction   0   1
# 0 104   6
# 1   8  52

############Rpart (recursive partitioning and regression trees)
## Identify the variables that will be used for prediction
## training the model
# Run the model on entire dataset, and not just selected features to check for accuracy and gradually remove one feature at a time
model.rpart = train(diagnosis~., trainSet, method="rpart")
predict.rpart = predict(model.rpart, testSet)
accuracy.rpart = mean(predict.rpart==testSet$diagnosis)
accuracy.rpart #0.9117647
#0.9176471
cm_rpart  <- confusionMatrix(predict.rpart, as.factor(testSet$diagnosis))   
cm_rpart

####################################### Support Vector Machines 
library(e1071)
model.svm <- svm(diagnosis~., data=trainSet)

predict.svm=predict(model.svm, testSet)
accuracy.svm = mean(predict.svm==testingDataset$diagnosis)
accuracy.svm
cm_svm=confusionMatrix(predict, testingDataset$diagnosis)   
cm_svm

################################## Class imbalance
table(trainingDataset$diagnosis)
#There is approximately 60/40 split between benign and malignant samples
#So lets downsample it using the downSample function from caret package.
#To do this you just need to provide the X and Y variables as arguments.

# Down Sample
set.seed(100)
down_train <- downSample(x = trainingDataset[, -1], y = trainingDataset$diagnosis, yname="diagnosis")
table(down_train$diagnosis)

### new prediction to check accuracy with balanced data for knn
down_train$diagnosis = as.factor(down_train$diagnosis)
table(down_train$diagnosis)

model = train(diagnosis~., down_train, method="kknn")
predict = predict(model, testingDataset)
accuracy = mean(predict == testingDataset$diagnosis)
accuracy #0.9588235
cm  <- confusionMatrix(as.factor(predict), as.factor(testingDataset$diagnosis))   
cm
# Confusion Matrix and Statistics
# 
# Reference
# Prediction   0   1
# 0 105   5
# 1   2  58

