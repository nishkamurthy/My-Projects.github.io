#STEPS TO USE THIS FILE
#READ EACH COMMENT. FOLLOW THE INSTRUCTIONS
#RUN ONE LINE AT A TIME
#OBSERVE THE RESULTS IN THE CONSOLE WINDOW
#DO NOT RUSH. THIS IS EASY, BUT THIS IS THE ONLY TIME YOU CAN LEARN THE COMMON MISTAKES THAT HAPPENS IN R

#create vector using c() with 6 numeric values. 
v1 = c(1,2,3,4,5,6) 		#add values seperated by commas

#create a second vector v2 of 6 numeric values. name it v2. 
#Both v1 and v2 should have same length
#-- enter your code ---
v2 = c(2,4,6,8,10,12)

#add the two vectors and run
v3=v1+v2

#print the value of v3
#-- enter your code ---
v3=c(3,6,9,12,15,18)

#use the built-in functions on v3 and print it's value. 
#check the environment tab for the values
#max(v3) print(v3), min, length, mean, sd, var passing the value v3

#-- enter your code ---
max(v3)
print(v3)
min(v3)
length(v3)
mean(v3)
sd(v3)
var(v3)
#--
#create a vector of string. 
vectorX = c("apples", "oranges", "bananas")
print(vectorX)


vectorString = c("panther", "lion", "tiger")
print(vectorstring)		#what went wrong?
print(vectorString)

#what happens if you add two vector whose lengths are not same?
## create two vectors of different lengths and add them
## --your code here --
# create vector1 with 3 items
vector1=c(1,2,3)
#create vector2 with 4 items
vector2=c(9,5,6,8)
#add vector1 and Vector 2
vector3=vector1+vector2

###---##

#vector with numeric and string values. Run the line below. What happens?
mixed.Vector  = c(1,2,3,'tony')

#vector with logical values can also be created. Run and see the response
lvec <- c(TRUE,FALSE)

######### VECTOR INDICES
v3 #run to make sure the value for vector v3 is set

#select only one element 
v3[2]  #based on place of number in set (ex. 2 is not a real number in the set)
#select range of elements
v3[1:3] #based on place of number in set
#select all but one element
v3[-3] #based on place of number in set
v3[-3,-4] #test 

## VECTOR SLICING: including only part of the object. When you have to pick elements not in a sequence
## SYNTAX pass a vector of indices
v3[c(1,2,5)] #based on place of number in set

#Selecting based on RULES. select elements based on logical operator
v3[v3>3]
v3[v3>7] #based on ACTUAL NUMBER
 
#vectorX = c("peach", "oranges", "bananas")

#as.() functions are very useful

as.character(2) # run and observe the output #turns numeric into character

as.numeric("2") # run and observe the output #turns character into numeric

 #you can convert entire vector into a different data type
v=as.character(v3)
print(v)	#what did you observe?

v=c(1,2,3,4)
vc=as.character(v) 	
print(vc) #what did you observe?

# Check data types of vector
nvec <- c(1,2,3,4,5)
class(nvec) 

vectorS2 = c("peach" , "potatoes", "brocolli")
class(vectorS2)

#### YOUR TURN TO TRY VECTOR INDEXING AND SLICING. 
###REFER TO THE SLIDE FROM CLASS PRESENTATION IF NEEDED

### --- your code ---

v3=c(1,2,3,4,5,6,7,8)
vs = c("tomato" , "potatoes", "broccoli", "cabbage")

v3[4]
vs[2]
v3[2:4]
vs[3:4]
v3[-2]
vs[-2]
v3[c(1,2,4)]
vs[c(1,2,4)]
v3[v3<4]
partofVector= vs[2:4]
partofVector
vs[2:4]
