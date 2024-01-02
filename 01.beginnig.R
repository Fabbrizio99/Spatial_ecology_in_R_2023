# here I can write anything I want, and nothing can happen. It is useful to make viewers to undersant what you are doing

# R as a calculaotor 
2+3

# assing to an object a value with the oparator <- and the object will become a variable 
zima <- 2+3
zima

duccio <- 5+3
duccio

#we can make some operations
zima*duccio

#and then rename the variables with wiìhich we perform the operations
final <- zima*duccio
final

final^2

# array, a series of numbers put together 
# we collected data on grams of microplastics in a lake, numbers are called arguments and functions have parentheses
# with arrays we use c = "concatenate" arguments and then assign them to a variable
sophie <- c(10,20,30,50,70) 

# this ine is an array with the amount of people in the different spots where microplastics were collected 
paula <- c(100,500,600,1000,2000) #people

#we can create a plot with the 2 variables, sophie (x) and paula (y) 
plot(paula, sophie) #there is a positive correlation 

#i if you want to put a new label, you can use the plot function with argument xlab=" " and ylab=" "
plot(paula, sophie, xlab="number of people", ylab="microplastics")
#another way is to renamne variables 
people <- paula
microplastics <- sophie

plot(people, microplastics)

# we can change plot characteristics
plot(people, microplastics, pch=19) #to change the symbols, http://www.sthda.com/sthda/RDoc/images/points-symbols.png

plot(people, microplastics, pch=19, cex=2) #cex gives different sizez to the plot  

plot(people, microplastics, pch=19, cex=2, col="blue") #to change colors, here is important to put the quotes


#how to install packages, with the function install.packages 
install.packages("sp") 
# to see if the package is installed succesfully, we recall it with the library function
library(sp)
