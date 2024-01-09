# we are going to use Rmarkdown to create reports, with html 
# Finla script including all the diffrent scripts during lectures


#------------------


# summary:
# 01 Beginning
# 02.1 Populations density
# 02.2 populations distribution
# 03 community multivariate analysis
#------------------


# 01 beginning 
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

#------------------
# 02.1 Populations density


# Code related to population ecology

# A package is needed for point pattern analysis, we need packages from CRAN (comprehensive R archive network)
install.packages("spatstat")
library(spatstat)

# let's use the bei data inside spatstat:
# data description in the CRAN website:
# https://CRAN.R-project.org/package=spatstat

bei

# plotting the data
plot(bei)
# points are representing trees monitored in Amazzonia
# changing dimension - cex
plot(bei, cex=.2)

# changing the symbol - pch
plot(bei, cex=.2, pch=19)

# additional datasets to see a raster (image file)
bei.extra
plot(bei.extra)

# let's use only part of the dataset: elev
# we can select it with the symbol $
plot(bei.extra$elev)
elevation <- bei.extra$elev
plot(elevation)

# second method to select elements, by data filtering
elevation2 <- bei.extra[[1]]
plot(elevation2)

# passing from points to a countinuous surface
# so we can consider each group of dots as a single unit, and here each unit is going to be dense in according
# to the number of dots in that area
# here we create the density function and rename it 
densitymap <- density(bei)
plot(densitymap)
points(bei, cex=.2)

#to change the color of the map we can use the function colorRampPalette, 100 is the gradient
cl <- colorRampPalette(c("black", "red", "orange", "yellow"))(100)
plot(densitymap, col=cl)

cl2 <- colorRampPalette(c("black", "red", "orange", "yellow"))(4) #if i put gradient equal to 4 colors are less blurred
plot(densitymap, col=cl)

clnew <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(densitymap, col=clnew)
#to add another variable, using the bei.extra dataset 
plot(bei.extra)

elev <- bei.extra[[1]] #or bei.extra$elev, to add the elevation to the gradient
plot(elev)

# multiframe, to plot more things together
# inside the array we need to state how many rows and columns we want to plot and concatenate them 
par(mfrow=c(1,2))
plot(densitymap)
plot(elev)

par(mfrow=c(2,1))
plot(densitymap)
plot(elev)

par(mfrow=c(1,3))
plot(bei)
plot(densitymap)
plot(elev)

#------------------
# 02.2 population density 

# why population disperse over tha landscape in acertain manner?

library(sdm)
library(terra)

file <- system.file("external/species.shp", package="sdm")

rana <- vect(file)

rana$Occurrence # questo ci da i "presence absence data", per capire se ci sono o no gli esemplari in determinate posizioni
#facciamo il grafico delle posizioni del vettore rana, cioè presenza e assenza 
plot(rana)
#dobbiamo scegliere solamente dove c'è presenza o assenza

# selecting presences
pres <- rana[rana$Occurrence==1,] #per chiudere si usa la virgola, 

# exercise: select absences and call them abse
abse <- rana[rana$Occurrence==0,]
plot(abse)
# exercise: plot presences and absences, one beside the other
par(mfrow=c(1,2))
plot(pres, cex=0.5)
plot(abse, cex=0.5)

# exercise: plot pre and abse alltogether with two different colours
#prima è meglio chiudere i grafici con la funzione dev.off()
par(mfrow=c(1,2))
plot(pres, cex=0.5, col="blue")
plot(abse, cex=0.5, col="dark green")
#in questo modo lo si fa in due grafici diversi mentre per farlo nello stesso grafico si usa:
plot(pres, col="dark blue")
points(abse, col="light blue")

# predictors: environmnetal variables
elev <- system.file("external/elevation.asc", package="sdm") #questa volta non stiamo importando dati ma immagini, cioè rasters
elevmap <- rast(elev) #from terra package
elevmap
plot(elevmap)
points(pres, cex=.5)

#temperature predictor
temp <- system.file("external/temperature.asc", package="sdm") 
tempmap <- rast(temp) #from terra package
tempmap
plot(tempmap)
points(pres, cex=.5)

#exercise: do the same with the vegetation cover
vege <- system.file("external/vegetation.asc", package="sdm") 
vegemap <- rast(vege) #from terra package
vegemap
plot(vegemap)
points(pres, cex=.5)

prec <- system.file("external/precipitation.asc", package="sdm") 
precmap <- rast(prec) #from terra package
precmap
plot(precmap)
points(pres, cex=.5)

#exercise: multiframe everything together

par(mfrow=c(2,2))

#elev
plot(elevmap)
points(pres, cex=.5)

#temp
plot(tempmap)
points(pres, cex=.5)

#vege
plot(vegemap)
points(pres, cex=.5)

#prec
plot(precmap)
points(pres, cex=.5)

#--------------------
# 03 community multivariate analysis

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
pldc3
pldc4

total

pldc1 + pldc2 # togethere tey are more than 70%

#final plot, we can see how different specis are related to each other
plot(ord)

#--------------------
