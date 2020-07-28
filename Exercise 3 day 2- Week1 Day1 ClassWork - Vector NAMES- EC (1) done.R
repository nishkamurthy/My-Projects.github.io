#### VECTOR INDEXING, SLICING. VECTOR NAMES
###REFER TO THE SLIDE FROM CLASS PRESENTATION IF NEEDED

y = c(8,9,5,7,14)
 # print 3 continuous items
y[1:3]
 #print 1 and 3rd
y[c(1,3)]
 #everything but the 5th
y[-5]

### STRING VECTOR and VECTOR NAMES
## create a vector of string: use names for days of the week. 
days = c("mon","tues","wed", "thurs", "fri", "sat", "sun" )
days

#Slicing: pick last three days of the week using : and print
last3days = days[5:7]
last3days
#Slicing" pick 1st and 3rd day of the week passing a vector of the indexes
FirstAnd3rdDay = days [c(1,3)]
FirstAnd3rdDay

#VECTOR NAMES create a vector with weekday names and temperature
#create a vector for a week of temperatures using c:
temps = c(81,71,91,90,85,87,89)
temps
#Assign names for the day of the week by passing the temp vector to the names() function
names(temps) = c("mon","tues","wed", "thurs", "fri", "sat", "sun" )
print(temps)

#We could have also simply passed the vector for days of the week that we created before
names(temps) = days
temps

### VECTOR INDEXING WITH NAMES
## print the temperature for Monday and Tuesday
temps = v[c('mon', 'tues')]
temps

########### Yeay!! that was all for week 1 concepts. Practice Concepts and Solve Problem

v1 <- c(100,200,300)
v2 <- c('a','b','c')
v1
v2

v2[2]
v1[2]

v1[c(1,2)]
v2[c(1,3)]
v2[c(2,3)]

v = c(1,2,3,4,5,6,7,8,9,10)
v[2:4]
v[7:10]

v <- c(1,2,3,4)
names(v) <- c('a','b','c','d')
v['b']
v['c']

v[c('a', 'd', 'b')]

#######################


stock.prices = c(25, 27 , 25, 21,34)
print(stock.prices)

days= c("mon","tues","wed", "thurs", "fri")

names(stock.prices) = days
print(stock.prices)

stock.prices [3:5]
stock.prices [c('mon', 'wed', 'fri')]

mean(stock.prices)

over.25 = stock.prices>25
print (over.25)

stock.prices[stock.prices == max(stock.prices)]


















