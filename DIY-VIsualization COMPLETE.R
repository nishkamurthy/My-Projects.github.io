# -----------------------------------------------
# Exploration and Visualizaton of mpg dataset
# ------------------------------------------------
# Load tidyverse (which contains ggplot2!)
# You may need to install packages for tidyverse from the packages window bottom right
library(tidyverse)         
library(ggplot2)

#Explore the mpg dataset
mpg 

#use summary and str functions to explore the datasets
summary(mpg)
str(mpg)
########### HISTOGRAMS
mpg=mpg
print(mpg)
#====================== HISTOGRAMS AND BAR PLOTS
#Draw distributions for manufacturers, year of manufacturing, displacement, transmission type
#Pick the right plot for each variable. ( Histogram vs. Bar)
ggplot(data=mpg, aes(x=manufacturer)) + geom_bar() #distribution of manufacturer
ggplot(data=mpg, aes(x=year)) + geom_histogram(bins=30) #distribution of  year of manufacturing
ggplot(data=mpg, aes(x=displ)) + geom_histogram(bins=30) #distribution of displacement
ggplot(data=mpg, aes(x=trans)) + geom_bar() #distribution of transmission type

### Adding color dimension. use fill=.. inside the aes() function
#Group the manufacturer distribution by drive type
ggplot(data=mpg, aes(x=manufacturer, fill=drv)) + geom_bar()

#Group the manufacturer distribution by class
ggplot(data=mpg, aes(x=manufacturer, fill=class)) + geom_bar()


################### SCATTER PLOT
# Create a scatter plot using geom_point() where engine displacement (displ) and highway miles per gallon (hwy) are mapped to the x and y aesthetics
ggplot(mpg, aes(x=displ, y=hwy)) + geom_point() #complete the code to draw the plot

#Assign vehicle class to create another dimension by using color= in the asthetics function.
myPlot = ggplot(mpg, aes(x=displ, y=hwy, color=class)) + geom_point()

# Let's decorate the plot. 
#Add Labels with labs()
labs(x="Engine Displacement in Liters", y="Highway miles per gallon", title = "MPG data", subtitle = "Cars with higher engine displacement tend to have lower highway mpg", caption = "Source: mpg data in ggplot2")
#x label "Engine Displacement in Liters",
#y lable "Highway miles per gallon",
#title = "MPG data",
#subtitle = "Cars with higher engine displacement tend to have lower highway mpg",
#caption = "Source: mpg data in ggplot2")
labs(x="Engine Displacement in Liters", y="Highway miles per gallon", title = "MPG data", subtitle = "Cars with higher engine displacement tend to have lower highway mpg", caption = "Source: mpg data in ggplot2")
myPlot= myPlot + labs(x="Engine Displacement in Liters", y="Highway miles per gallon", title = "MPG data", subtitle = "Cars with higher engine displacement tend to have lower highway mpg", caption = "Source: mpg data in ggplot2")
myPlot
print()# Add a smooth line of blue color using geom_smooth. you may notice a warning.. 
myPlot + geom_smooth(color="blue")

# Facet by class. Create facets by class. syntax is facet_grid(class~.) add the facet to the plot
myPlot + facet_grid(class~.)

# Challenge

# In a scatter plot above, map a continuous variable to size. Hint: simply replace color=variableName to size=variableName in the aesthetics mapping
myPlot = ggplot(mpg, aes(x=displ, y=hwy, size=class)) + geom_point()
myPlot
# In a scatter plot, with displ and hwy, convert the continuous variable displacement to factor. Observe the changes...instead of shaded hues, is it discrete colors
myPlot = ggplot(mpg, aes(x=factor, y=hwy, size=class)) + geom_point()
myPlot
# What happens if you map an aesthetic to something other than a variable name, like aes(...color = displ < 5)? Change your code above to color=displ<5
myPlot = ggplot(mpg, aes(x=displ <5 , y=hwy, size=class)) + geom_point()
myPlot
#Show the relationship between city and highway miles per gallon for cars, and map the color for only SUVs. (hint:add a condition for class equal to SUV. Check the mpg dataframe to see how SUV appears in the dataframe. You need to pick the exact label from the dataframe for the condition to work.)
myPlot = ggplot(mpg, aes(x=cty, y=hwy, size=class, class(suv))) + geom_point()
myPlot
#### - Next EDA of MPG Dataset.  