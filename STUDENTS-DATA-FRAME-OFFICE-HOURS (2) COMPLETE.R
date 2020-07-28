#We usually create a data frame with vectors. Create 3 vectors with 2 elements

nm = c("Angela", "Shondra") #Example: Names of patients
ag = c(37, 43)                     #Add Age of patients\
ins = c(TRUE, TRUE)                   #Add Insurance - do they have insurance True/False values

#Create a data frame named patients and pass the 3 vectors nm, ag, ins
--code
patients=data.frame(nm,ag,ins)
print(patients)
##ANSWER should like below
##     nm ag ins
## 1  Angela   27      TRUE
## 2 Shondra   36      TRUE


#We can also create a data frame with different column names and this is how you do it. Run the statement
patients = data.frame("names"=nm, "ages" = ag, "insurance"=ins)
print(patients)
##     names    ages    insurance
## 1  Angela   27      TRUE
## 2 Shondra   36      TRUE

#We may wish to add rows or columns to our data. We can do this with: #rbind() #cbind(). remember it as r(row)bind..
#For example we can go back to our patient data and say we wish to add another #patient we could just do the following
newPatient = c(names="Liu Jie", age=45, insurance=TRUE)
patients=rbind(patients, newPatient)
print(patients)
##     names ages insurance
## 1  Angela   27      TRUE
## 2 Shondra   36      TRUE
## 3 Liu Jie   45      TRUE
## You may get a Warning in `[=.factor`(`*tmp*`, ri, value = "Liu Jie"): invalid factor
## level, NA generated. OR it may not have added the row..
#This warning serves as a reminder to always know what your data type is. 
# In this case R has read our data in as a factor so use as.character 
# patients$names = as.character(patients$names) #this is ensuring all patients names as character
# patients = rbind(patients, newPatient)
# patients

#if we decide to  place another column of data in we could use cbind function
# Next appointments
next.appt = c("09/23/2016", "04/14/2016", "02/25/2016")

#Lets R know these are dates
next.appt = as.Date(next.appt, "%m/%d/%Y")
next.appt
print(patients)
## [1] "2016-09-23" "2016-04-14" "2016-02-25"
#We then have a vector of dates which we can cbind (column bind) in R.
patients = cbind(patients, next.appt)
patients
##     names ages insurance  next.appt
## 1  Angela   27      TRUE 2016-09-23
## 2 Shondra   36      TRUE 2016-04-14
## 3 Liu Jie   45      TRUE 2016-02-25

##### getting information on a particular column you the format dataframeName$columnName
patients$names

# [1] "Angela"  "Shondra" "Liu Jie"

#print ages of all patients using the example above
patients$ages

## "37" "43" "45"
############################TITANIC: Accessing Data Frames
#we will use  built in data on Titanic from R. In this case, lets create a new data frame from Titanic
library(datasets)
Titanic
titanic = data.frame(Titanic)
print(summary(titanic))
titanic
#Print Summary of the Titanic dataframe

# Answer
# Class       Sex        Age     Survived      Freq       
# 1st :8   Male  :16   Child:16   No :16   Min.   :  0.00  
# 2nd :8   Female:16   Adult:16   Yes:16   1st Qu.:  0.75  
# 3rd :8                                   Median : 13.50  
# Crew:8                                   Mean   : 68.78  
# 3rd Qu.: 77.00  
# Max.   :670.00  

#We can look at the different columns that we have in the data set:
colnames(titanic)
## [1] "Class"    "Sex"      "Age"      "Survived" "Freq"


#print value of Age column using the syntax dataframeName$columNname
titanic$Age

#ANS
# [1] Child Child Child Child Child Child Child Child Adult Adult Adult Adult Adult Adult Adult Adult Child Child Child Child Child Child Child
# [24] Child Adult Adult Adult Adult Adult Adult Adult Adult
# Levels: Child Adult

#Observe the Levels information above Levels: Child Adult. This means how many unique values are there for a particular column. 
#Similar to unique() function. Let's use this instead. Use unique(pass the column name. 
# Remember: use the syntax dataframeName$columNname for refer to a column.

uniqueAge = unique(titanic$Age)
uniqueAge
# ANS
#Levels: Child Adult


#Now let's print information based on various conditions
# if you need all rows or all columns, simply pass ',' without quotes. else provide indexes based on the
#rules learned during vectors
#to print all rows and all columns.
titanic[,]

#Print first 2 rows of data with all columns using indexing and :.
titanic[2,]
# titanic[2,]
# Class  Sex   Age Survived Freq
# 2   2nd Male Child       No    0

#Print all rows of data with first 3-4th columns using indexing and :.
titanic[,3:4]
#Print first 3, 9, 6th rows and 2nd, 3rd and 5th column. Use the indexing rules for vectors. 
#when you want non-continuous columns or rows, you need to pass it in a vector 
titanic[c(3,6,9), c(2,3,5)]

#Ans 
#Sex   Age Freq
#3   Male Child   35
#9   Male Adult  118
#6 Female Child    0

#Print  all rows with class, sex and age columns
titanic[, c("Class", "Sex", "Age")]
#Print start of the data using head()
head(titanic)
#Print last few rows of the data using tail()
tail(titanic)
#Access the age information, using the column number
titanic[,3]
## ANS [1] Child Child Child Child Child Child Child Child Adult Adult Adult
## [12] Adult Adult Adult Adult Adult Child Child Child Child Child Child
## [23] Child Child Adult Adult Adult Adult Adult Adult Adult Adult
## Levels: Child Adult

#Use the column name for age instead to get the information:
colnames(titanic)[3]
## ANS [1] Child Child Child Child Child Child Child Child Adult Adult Adult
## [12] Adult Adult Adult Adult Adult Child Child Child Child Child Child
## [23] Child Child Adult Adult Adult Adult Adult Adult Adult Adult
## Levels: Child Adult

#Change column names using index position. change column name for Sex to Gender. Hint - Sex is 3rd column.
colnames(titanic)[3] = "Age"
colnames(titanic)
#Ans[1] "Class"    "Sex"      "Gender"   "Survived" "Freq"  

##### Create subset of data frames
## create a data frame using 4-8th row and 2nd and 3rd column of Titanic
d1=data.frame(titanic[4:8, 2:3])
d1
## your turn
#Create a data frame with 2, 3, 4th row and 1st, 2nd, and 3rd column
d2=data.frame(titanic[2:4, 1:3])
d2
#Ans
# Class  Sex   Age
# 2   2nd Male Child
# 3   3rd Male Child
# 4  Crew Male Child


###################################CHALLENGE and OPTIONAL: ##########################
titanic=data.frame(Titanic)
#####WASNt ABLE TO GET PAST FIRST PROBLEM
#PROBLEM:We wish to know information about a particular class. Find all information on the 1st class passengers
titanic["1st", ] #did this work? NO.. you probably got the below information
##    Class  Sex  Age Survived Freq
## NA  <NA> <NA> <NA>     <NA>   NA

#HINT: What we need to do instead is to use comparison symbol == and pass the condition where Class is equal to 1st" at the row position..
#HINT: Remember to use the column name as titanic$COLUMNAME.try!
titanic= data.frame(titanic$class=="1st")
titanic["1st", ]
(titanic$Class == "1st")

  #ANS
  # Class    Sex   Age Survived Freq
  # 1    1st   Male Child       No    0
  # 5    1st Female Child       No    0
  # 9    1st   Male Adult       No  118
  # 13   1st Female Adult       No    4
  # 17   1st   Male Child      Yes    5
  # 21   1st Female Child      Yes    1
  # 25   1st   Male Adult      Yes   57
  # 29   1st Female Adult      Yes  140
dataset

### What is the frequency of the first class passengers? use "1st" and "Freq" and the comparison operator..
### Hint: in the above example, you had all column. in this question, we are asking you to print only "Freq"
first.class.freq = titanic[titanic$Class=="1st", "Freq"]
first.class.freq

### Another challenge: how many total passengers in first class?
### No hints;) it's really simple. Was taught in the first class to use the a built-in function
### I wasnt kidding when I said, whatever you learned in first class will be used as well...



# Ans
#[1] 325

### Ok! now that you got the hang of it, calculate how many TOTAL male passengers were on the ship called Titanic

--code..

## Ans
##  [1] 1731

#PROBLEM: Change column name using names; Change column name for Freq to Frequency. This is a trick problem, but we have done it twice in class similar problems
--code here

colnames(titanic)
# [1]ANS "Class"     "Sex"       "Age"       "Survived"  "Frequency"

###CURIOUS TO LEARN MORE? Since we talked about this in class! Let's try to change the row names for Titanic. 
### let's try to give rows for 1st class passengers are "First Class"
###
rownames(patients)[patients$ages=="1st"]="First Class"
# we get the following error. So row names are possible, and can be changed but only for certain datasets.
#   duplicate 'row.names' are not allowed
#   non-unique value when setting 'row.names': ‘First Class’ 

###### USE of which() function. It returns the indices/positions when the condition is TRUE
which(titanic$Freq>100)
# [1]  9 10 11 12 28 29

which(titanic$Class=="1st")
# [1]  1  5  9 13 17 21 25 29

### THINk!! could you have used this for stock.prices problem? YES! and it would have been so much easier.

## Which() is a useful function to get the column position.
## We will use the concept to change the column name of hp to Horse Power in two steps.
#Find what is the column position of 'hp' in mtcars
mtcars=datasets::mtcars
colPositionForhp = which(names(mtcars)== 'hp') 
colPositionForhp
#Ans [1] 4

#Now use this column position to change the name of the column- Simple?? eh?

colnames(mtcars)[colPositionForhp] = "Horse Power"
#test your code by printing the new column names. Does it show you "Horse Power" as a column, yes!
colnames(mtcars)
#[1] "mpg"         "cyl"         "disp"        "Horse Power" "drat"        "wt"          "qsec"        "vs"         
#[9] "am"          "gear"        "carb"     
# 

#Another use of Which
#Find how many first class passengers rode Titanic. 
a=which(titanic$Class=="1st") #Return all positions in Titanic
sum(titanic$Freq[a]) #Sums all the Frequency value of the position which is for 1st

################# IF YOU FINISHED ALL PROBLEMS ABOVE THEN YOU ALREADY KNOW MORE THAN MOST ON DATA FRAMES AT YOUR LEVEL
## VISUALIZATION IS NEXT!!



