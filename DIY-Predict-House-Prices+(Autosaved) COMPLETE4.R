########## How Good is our Model? ############
#		Examples for Data Split
#		
##############################################


library(utils)
realEstate=read.csv("Sacramentorealestatetransactions.csv")
realEstate
# how many rows have sq__ft=0? assignment.

# for more accuarate results we should remove rows which have a sq__ft of zero
realEstate=realEstate[-which(realEstate$sq__ft==0),]
#Use 'which' function to remove the missing values

sum(is.na(realEstate))

#############################################################################################################
# 2. DIY: Build a linear regression model in order to predict the price of houses from square feet.
library(caret)
library(ggplot2)
library(brnn)
model=train(price ~ sq__ft + beds, data=realEstate,method="lm")
model
predictedPrices = predict(model, realEstate)
predictedPrices
model$finalModel
a1 = RMSE(predictedPrices, realEstate$price)
a1

model=train(price ~ sq__ft + beds, data=realEstate,method="brnn")
model
predictedPrices = predict(model, realEstate)
predictedPrices
model$finalModel
a2 = RMSE(predictedPrices, realEstate$price)
a2

model=train(price ~ sq__ft + beds, data=realEstate,method="bridge")
model
predictedPrices = predict(model, realEstate)
predictedPrices
model$finalModel
a3 = RMSE(predictedPrices, realEstate$price)
a3

model=train(price ~ sq__ft + beds, data=realEstate,method="rf")
model
predictedPrices = predict(model, realEstate)
predictedPrices
model$finalModel
a4 = RMSE(predictedPrices, realEstate$price)
a4
#check $finalModel for coefficients
model$finalModel
#whats the formula
#]price = mx+c
m=125.2
c=30210.6
#what is the houseprice for 625sqft house?
price = 125.2*625 + 30210.6
price
vTable = realEstate[,c("sq__ft","price")]
vTable$predictedValues = predictedPrices
#what's the MAE, RMSE and R2?
R2(predictedPrices, realEstate$price)
MAE(predictedPrices, realEstate$price)
RMSE(predictedPrices, realEstate$price)
#############################################################################################################
# 3. Split the data to half and repeat task 2 on the training set. 

myData = realEstate [,c("beds", "baths", "sq__ft","type")]
myData
trainingDataset = myData[ seq(1,nrow(myData), 2) ,]#pick odd rows for training data set
trainingDataset
testingDataset = myData[seq(2,nrow(myData),2),] # pick even rows for testing data set
testingDataset
library(ggplot2)
ggplot(trainingDataset, aes(price, sq__ft)) + geom_point(color="red") +  geom_point(testingDataset, mapping=aes(price, sq__ft))

#mpg on all columns

model=train(sq__ft ~.,trainingDataset, method="lm")

model$finalModel

predictedMPGs=predict(model,testingDataset)

MAE(predictedMPGs,testingDataset$mpg)
RMSE(predictedMPGs,testingDataset$mpg)
R2(predictedMPGs,testingDataset$mpg)


realEstate=read.csv("Sacramentorealestatetransactions.csv")
# for more accuarate results we should remove rows which have a sq__ft of zero
realEstate=realEstate[-which(realEstate$sq__ft==0),] #Use 'which' function to remove the missing values
r=realEstate[-which(realEstate$sq__ft>5000|realEstate$price>755000),] 

  