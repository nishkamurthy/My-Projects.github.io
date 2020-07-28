# Train a k-nearest neighbor classifier for iris flower to predict the specifis of the flower
# in order to predict Species
library(caret)
library(ggplot2)
library(kknn)
iris=iris
ggplot(iris,aes(Sepal.Length,Petal.Length, color = Species))+geom_point()

# add a color dimension for species to separate the flowers by species

# Step1: split to training and testing in any one of the ways. either odd and even rows, or by using createDataPartition
index = createDataPartition(iris$Species, list=FALSE, p=0.7)
index
training = iris[index,]
testing  = iris[-index,]

# Step2: train a classification model using K Nearest Neighbor Algorithm using method="kknn"
#modelName = train( VariableThatIsBeingPredicted ~., dataset, method="kknn")
irisModel = train(Species ~., training, method="kknn")
# Step3: predict the results on testing dataset
results = predict (irisModel, testing)
results
testing$results = results
# Step4: measure accuracy. accuracy is measured 
#accuracy = sum (predictedValues == actualValue) / TotalNumberOfObservations
accuracy = sum (results == testing$Species) / nrow(testing)
accuracy
# Step5: Visual Validation using a validation table
# Add the column of predicted results to testing dataset
testing$accuracy = accuracy
################# Will the precision improve if you create a random split using another technique?
# Part2: split  training and testing using a different technique than above
# Use a subset of data - petal.length and sepal.length only to split the dataset 
# Repeat the task and check the accuracy






