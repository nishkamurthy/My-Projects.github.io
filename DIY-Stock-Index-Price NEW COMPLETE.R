############## Add Your Name Here.. eg: Tim Smith ############## ############## ############## ############## 
#       
#       Predict the stock index price based on interest rate using Simple Linear Regression 
#       for interest rate = 3.0
#       LINEAR REGRESSION
############### ############## ############## ############## ############## ############## ############## ####
library(caret)
library (ggplot2)
library(hydroGOF)
library(dplyr)
#Read the stock data csv and remember to set the working directory from the Files window on the bottom right

stockPricesFile=read.csv("stockprices_data.csv") 
stockPricesFile
colnames(stockPricesFile)
#Build the model. Use syntax 
# modelName = train(what is being predicted ~ the variable that is helping you predict, data= dataset, method="lm")
names(stockPricesFile)[names(stockPricesFile) == "Unemployment Rate"] <- "UnRate"
names(stockPricesFile)[names(stockPricesFile) == "Stock.Index.Price"] <- "SIP"
names(stockPricesFile)[names(stockPricesFile) == "Interest.Rate"] <- "InRate"
colnames(stockPricesFile)
stockPrices = train(Stock.Index.Price ~ Interest.Rate, data=stockPricesFile, method="lm")
# use modelName$finalModel on the model that you trained to get the coefficients
stockPrices$finalModel
# predict the stock index prices for the entire dataset using predict(modelName, dataset)

#predict stock index for InterestRate 3.0
#Stock.Index.Price = intercept + m*InterestRate
InterestRate=3.0
Stock.Index.Price = -99.46 + 564.20*InterestRate
Stock.Index.Price

#colnames(stockprices_data)  
#print the final stock index price value for interestRate =3.0
1593.14
# calculate R2 and RMSE using sytax R2(predictedValues, actualValues) #actual values are the dataset$columnNames
#print R2
predictedPrices = predict(stockPrices, stockPricesFile)
predictedPrices
R2(predictedPrices, stockPricesFile$Stock.Index.Price) 
#print RMSE
RMSE(predictedPrices, stockPricesFile$Stock.Index.Price)
############################ ############## ############## ############## 
#       
#       Predict the stock index price based on interest rate and unemployment rate using Multiple Linear Regression 
#       for interest rate = 3.0 and unemployment rate = 5.0
#       MULTIPLE LINEAR REGRESSION
############### ############## ############## ############## ############## ############## ############## ####

# Multiple Linear Regression
#model=train(y ~ x1 + x2, data=dataset, method="lm")
#everything else remains the same as above!!!
colnames(stockprices_data)
SIP2=train(Stock.Index.Price ~ Interest.Rate + Unemployment.Rate, data=stockPricesFile, method="lm")
SIP2
SIP2$finalModel

#predict stock index for int rate 3.0 and unemployment rate of 5.0
#Stock.Index.Price = intercept + m1*InterestRate + m2*UnemploymentRate
SIP2 = 1798.4 + 345.5*InterestRate + -250.1*UnemploymentRate
InterestRate = 3.0
UnemploymentRate = 5.0
SIP2

#print the value of Stock Index Price
1584.4
#print R2
R2(predictedPrices, stockPricesFile$Stock.Index.Price) 
#print RMSE
RMSE(predictedPrices, stockPricesFile$Stock.Index.Price)
##################### EXTRAS
#print validation table with predictedValues for Linear Regression and Multiple LR
vTable = stockPricesFile[,c("Stock.Index.Price")]
vTable$predictedValues = predictedPrices
