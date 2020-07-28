#############################################################################################################
#         Problem - Predict Used Car Sales Price -------------------------------------                      #
#         Use linear regression to predict the value of a car that has 50,000km on speedometer              #
#         The original dataset was downloaded from Kaggle. It has been cleaned and prepared for you already #
#         Download the dataset from the realworldAI.CO/programdocs website                                  #
#############################################################################################################

#Load Libraries
library(ggplot2)
library(caret)


# STEP 0: SET THE WORKING DIRECTORY TO LOCATION OF YOUR DATAFILE -----------------------------



# STEP 1: LOAD THE DATA  --------------------------------------------------------------------

CarSalesData = read_csv("autos_prepared.csv")
CarSalesData

# TEST TO ENSURE FILE WAS READ PROPERLY. PRINT THE DATAFRAME, HEAD, TAIL, AND CHECK IN ENV TAB
summary(CarSalesData)
head(CarSalesData)
tail(CarSalesData)

# STEP 2: VISUALIZE THE DATA ---------------------------------------------------------------- 
# Build the formula for Linear Regression Line y = mx + c + e for your problem.
# what is y for your problem? and what is x? Remember, m and c will be provided to you by the model.

#price = m*km + c + e

# STEP 3: BUILD MODEL USING train() -----------------------------
CarData = train( price ~ kilometer, data = CarSalesData , method = "lm")
CarData

## REVIEW THE MODEL USING Summary(myModelName) AND myModelName$finalModel 
summary(CarData)
CarData$finalModel

# STEP 4: PREDICT USING THE TRAINED MODEL - use predict() ------------------------------------
predictedValues = predict (CarData, CarSalesData)
predictedValues

# STEP 5: WHAT IS THE PRICE FOR CAR WHICH IS 50,000KM.------------------

# METHOD 1: USE THE FORMULA y=mx+c, AND THE VALUES FROM THE MODEL
c=1.599*10000
c

m=-8.797/100
m 
# THIS IS NOT THE FORMULA y = 15990*50000 + -0.08797 DO NOT FILL ANYTHING FOR PLACES M AND C WHEN INPUTTING THE FORMULA
y=m*50000 + c
y

y2=m*75000 + c
y2
# METHOD 2: CHECK THE predictedValues vectors for approximate value
predictedValues

#METHOD 3: SCATTERPLOT
ggplot(data=CarSalesData, aes(x=kilometer, y=price)) + geom_point() 

# STEP 6: MODEL ACCURACY ----------------------
#Calculate MAE(predictedValues, ActualValues)

MAE(predictedValues, CarSalesData$price)


