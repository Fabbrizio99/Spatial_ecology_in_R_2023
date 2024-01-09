# we are going to use Rmarkdown to create reports, with html 
# Final script including all the diffrent scripts during lectures


#--------------------


# summary:
# 01 Beginning
# 02.1 Populations density
# 02.2 populations distribution
# 03.1 community multivariate analysis
# 03.2 community overlap
# 04 remote sensing data vizualisation
# 05 spectral indeces 
# 06 time series
# 07 external data
# 08 Copernicus data
# 09 Classification

#--------------------


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

#--------------------
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

#--------------------
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
# 03.1 community multivariate analysis

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

# 03.2 community overlap

# relation among species in time 

install.packages("overlap")
library(overlap)

data(kerinci)

tiger <- kerinci[kerinci$Sps == "tiger",]

kerinci$timeRad<-kerinci$Time * 2 + pi

timetig <- tiger$timeRad
densityPlot(timetig, rug=TRUE)

overlapPlot(timetig, timecac)

#--------------------

# 04 remote sensing data vizualisation

#those packages are downloded from CRAN
#we will use images from sentinel, that is a satellite that send rays of different wavelengths; so we can make analysis and see differences with different bands
install.packages("imageRy")

library(imageRy)
library(terra)

#list the data, evrything starting with im is from the package imagerRy
im.list()

b2 <- im.import("sentinel.dolomites.b2.tif")
cl <- colorRampPalette(c("black","grey","light grey")) (100)
cl <- colorRampPalette(c("dark grey","grey","light grey")) (100)
plot(b2, col=cl)

# import the green band from sentinel-2 (band 3)
b3 <- im.import("sentinel.dolomites.b3.tif")
cl <- colorRampPalette(c("dark grey","grey","light grey")) (100)
plot(b3, col=cl)

b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col=cl)

#multiframes 
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl) #the NIR has more informations

#create a stack image of all the bands together and then plot it
stacksent <- c(b2, b3, b4, b8)
stacksent
plot(stacksent, col=cl) #its the same but in one command 
dev.off() #it closes devices

plot(stacksent[[4]], col=cl) #i'm asking to select the image number 4, so the NIR one 

plot(c(b2, b3, b4, b8), col=cl) #also working

#Exercise: plot in multiframe the band with different color ramps
cl2 <- colorRampPalette(c("dark grey","grey","light grey")) (100)
cl3 <- colorRampPalette(c("dark blue","blue","light blue")) (100)
cl4 <- colorRampPalette(c("dark red","red","light red")) (100)
cl8 <- colorRampPalette(c("dark green","green","light green")) (100)
par(mfrow=c(2,2))
plot(b2, col=cl2)
plot(b3, col=cl3)
plot(b4, col=cl4)
plot(b8, col=cl8)

## RGB
#stacksent: band2 blue element 1, stacksent[[1]]
#band3 green element 2, stacksent[[2]]
#band4 red element 3, stacksent[[3]]
#band8 NIR element 4, stacksent[[4]]
im.plotRGB(stacksent, r=3, g=2, b=1 ) #you decide the band to use and how to change the color
im.plotRGB(stacksent, r=4, g=3, b=2)
im.plotRGB(stacksent, r=3, g=4, b=2)
im.plotRGB(stacksent, r=3, g=2, b=4)


pairs(stacksent)

#--------------------

# 05 spectral indeces 

# Indices derived from RS imagery

library(imageRy) # beloved package developed at unibo
library(terra)
library(ggplot2)
library(viridis)

im.list()

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

# layer 1: NIR
# layer 2: red
# layer 3: green

im.plotRGB.user(m1992, 1, 2, 3)
im.plotRGB.user(m1992, 2, 1, 3)
im.plotRGB.user(m1992, 2, 3, 1)

# import the 2006 image
m2006 <- im.import("matogrosso_ast_2006209_lrg")

# Exercise: plot the 2006 image with NIR in the Green component of the RGB space
im.plotRGB.user(m2006, 2, 1, 3)

# Exercise: plot the 2006 image with NIR in the Blue component of the RGB space
im.plotRGB.user(m2006, 2, 3, 1)

# Exercise: plot the two images one beside the other
par(mfrow=c(1,2))
im.plotRGB.user(m1992, 1, 2, 3)
im.plotRGB.user(m2006, 1, 2, 3)

# Calculating the DVI
# dvi1992
dvi1992 = m1992[[1]] - m1992[[2]]
dvi1992

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100) # specifying a color scheme
plot(dvi1992, col=cl)

# dvi2006
dvi2006 = m2006[[1]] - m2006[[2]]
dvi2006

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100) # specifying a color scheme
plot(dvi2006, col=cl)

# dvi by imageRy
dvi1992i <- im.dvi(m1992, 1, 2)
dvi2006i <- im.dvi(m2006, 1, 2)

# ndvi
ndvi1992 = (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]])
ndvi2006 = (m2006[[1]] - m2006[[2]]) / (m2006[[1]] + m2006[[2]])

dev.off()
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

# scientifically meaningful image for everyone!
clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100) # specifying a color scheme
plot(ndvi2006, col=clvir)

#--------------------

# 06 time series

#time series analysis

library(imageRy)
library(terra)

im.list()

#impot the data of levels of no2 in two different periods 
EN01 <- im.import("EN_01.png")
EN13 <- im.import("EN_13.png")

par(mfrow=c(2,1))
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)
#now we want to see the differences between the two values from the first image and the second

dif = EN01[[1]] - EN13[[1]]
#we change the colors
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(dif, col=cldif)

#red part are where the values were higher in january due to stop of cars, and blue is where the value is higher in march

#example with temperature in greenland
g2000 <- im.import("greenland.2000.tif")
g2000

clg <- colorRampPalette(c('blue','white','red'))(100) #blue one is the zone with lower temperature
plot(g2000, col=clg)

g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

plot(g2015, col=clg)

par(mfrow=c(2,1))
plot(g2000, col=clg)
plot(g2015, col=clg)

#stacking the data together and all the 4 images in a plot 
stackg <- c(g2000, g2005, g2010, g2015)
plot(stackg, col=clg)

#exercise: make the diffeerence betweeen the first and the final elements of the stack
difg = g2000[[1]] - g2015[[1]] 
# or difg <- stackg[[1]] - stackg[[4]]
plot(difg, col=cldif)

#we can see that in the center the temperature is incresing

#exercise: make a RGB plot usign diffreent years (with RGB.plot)
im.plotRGB(stackg, r=1, g=2, b=3)
#since its more darker we know that the tempaerature is increasing in the inner part 

#--------------------

# 07 external data

# External data

library(terra)

# set the working directory based on your path:
# setwd("youtpath")
# W***** users: C:\\path\Downloads -> C://path/Downloads
# My own:
setwd("~/Downloads")
naja <- rast("najafiraq_etm_2003140_lrg.jpg")  # like in im.import()

plotRGB(naja, r=1, g=2, b=3) # im-plotRGB

# Exercise: Download the second image from the same site and import it in R
najaaug <- rast("najafiraq_oli_2023219_lrg.jpg")
plotRGB(najaaug, r=1, g=2, b=3)

par(mfrow=c(2,1))
plotRGB(naja, r=1, g=2, b=3) # im-plotRGB
plotRGB(najaaug, r=1, g=2, b=3)

# multitemporal change detection
najadif = naja[[1]] - najaaug[[1]] 
cl <- colorRampPalette(c("brown", "grey", "orange")) (100)
plot(najadif, col=cl)

# Download your own preferred image:
typhoon <- rast("mawar_vir2_2023144_lrg.jpg")

plotRGB(typhoon, r=1, g=2, b=3)
plotRGB(typhoon, r=2, g=1, b=3)
plotRGB(typhoon, r=3, g=2, b=1)


# The Mato Grosso image can be downloaded directly from EO-NASA:

mato <- rast("matogrosso_l5_1992219_lrg.jpg")
plotRGB(mato, r=1, g=2, b=3) 
plotRGB(mato, r=2, g=1, b=3) 

#--------------------

# 08 Copernicus data

# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

library(ncdf4)
library(terra)

# install.packages("name_of_the_package_here")

setwd("~/Downloads") # in W*****s \ means /

soilm2023 <- rast("c_gls_SSM1km_202311250000_CEURO_S1CSAR_V1.2.1.nc")
plot(soilm2023)

# there are two elements, let's use the first one!
plot(soilm2023[[1]])

cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(soilm2023[[1]], col=cl)

ext <- c(22, 26, 55, 57) # minlong, maxlong, minlat, maxlat
soilm2023c <- crop(soilm2023, ext)

plot(soilm2023c[[1]], col=cl)

# new image
soilm2023_24 <- rast("c_gls_SSM1km_202311240000_CEURO_S1CSAR_V1.2.1.nc")
plot(soilm2023_24)
soilm2023_24c <- crop(soilm2023_24, ext)
plot(soilm2023_24c[[1]], col=cl)

#--------------------

# 09 Classification

#we want to compare different areas and the differences during time based on the numer of pixels (mountain, wood, urban)
#pixels are training areas-->useful to make known the cluster = is a set of individual object with same carachteristics
#to classify one pixel we see wich class is the nearest (based on the diffrent distances on axis)

##classifying satellite images and estimate the amount of change

library(terra)
library(imageRy)

im.list()

sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#three level of energy of sun's gasses(orange, yellow, black); We want to classify the image finding clusters

sunc <- im.classify(sun, num_clusters=3)
# to see which class is the one with the higher energy we just need to compare the "original" image with this one

#classify satellite 

im.list

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

m1992c <- im.classify(m1992, num_clusters=2)
plot(m1992c)
#classes: human=1, forest=2

plot(m2006)
m2006c <- im.classify(m2006, num_clusters=2)
plot(m2006c)
#classes: human=1; forest=2

par(mfrow=c(1,2))
plot(m1992c)
plot(m2006c)

par(mfrow=c(1,2))#just to make the plot right
plot(m1992c[[1]])
plot(m2006c[[1]])

#command to count pixels(with the frequency of them) 
f1992 <- freq(m1992c)
#to find the percentage we just need to divide the number by the totalt number of pixels
tot1992 <- ncell(m1992c) #function to count the total number
tot1992
p1992 <- f1992 * 100 / tot1992
p1992
#forest=83%; human=17%

#percentage 
f2006 <- freq(m2006c)
#to find the percentage we just need to divide the number by the totalt number of pixels
tot2006 <- ncell(m2006c) #function to count the total number
tot2006
p2006 <- f2006 * 100 / tot2006
p2006
#forest=45%; human=55%

#building the final table
class <- c("forest", "human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)

tabout <- data.frame(class, y1992, y2006)
tabout

#final output
p1 <- ggplot(tabout, aes(x=class, y=y1992, color=class)) + geom_bar(stat="identity", fill="white"))
#aes=it is the class
#geom_bar= to create an histogram
