install.packages("vegan")
library(vegan)
install.packages("overlap")
library(overlap)

# we need to recall the data from the dataset with the function data()
data(dune)
dune
head(dune) # it gives us only the first 6 rows of data
tail(dune) # last 6 rows

ord <- decorana(dune) #Performs detrended correspondence analysis, to see how species are correlated together in a plot

#meausures of the axis lenght
ldc1 = 3.7004
ldc2 = 3.1166
ldc3 = 1.30055
ldc4 = 1.47888

total = ldc1+ldc2+ldc3+ldc4

#calculate thee percentage of each axes lenght to the total 
pldc1= ldc1 * 100 / total
pldc2= ldc2 * 100 / total
pldc3= ldc3 * 100 / total
pldc4= ldc4 * 100 / total

pldc1  
pldc2
plcd3
plcd4

total

pldc1 + pldc2 # togethere tey are more than 70%

#final plot, we can see how different specis are related to each other
plot(ord)













