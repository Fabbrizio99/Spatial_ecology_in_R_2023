#those packages are downloaded from CRAN
#we will use images from sentinel, that is a satellite that send rays of different wavelengths; so we can make an analysis and see differences with different bands
install.packages("imageRy")

library(imageRy)
library(terra)

#to see all the data in the package
im.list() #we get all the different data we can use
#all the functions from imageRy start with I'm.

#we will first use the sentinel data (satellite from ESA). 
#we are using images of the same spatial resolution (10metres). we will use 4 different bands
b2 <- im.import("sentinel.dolomites.b2.tif")
cl <- colorRampPalette(c("black","grey","light grey")) (100) #to change colors
cl <- colorRampPalette(c("dark grey","grey","light grey")) (100)
plot(b2, col=cl)

#every sensor gathers information with different wavelengths
#every color is a spectral band. As an example, band 8 is near infra-red (NIR) with 10 meters of spatial resolution

# import the green band from sentinel-2 (band 3)
b3 <- im.import("sentinel.dolomites.b3.tif")
cl <- colorRampPalette(c("dark grey","grey","light grey")) (100)
plot(b3, col=cl)
# the highest the reflectance, the lightest the colour on the right scale

# to import the red band (band number 4)
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4, col=cl)

# to import the NIR band (band number 8)
b8<-im.import("sentinel.dolomites.b8.tif")
cl<-colorRampPalette(c("black","grey","light grey")) (100)
plot(b8, col=cl)

# multiframe
par(mfrow=c(2,2))
plot(b2, col=cl)
plot(b3, col=cl)
plot(b4, col=cl)
plot(b8, col=cl) # the NIR has more informations

#we can also stack all the bands together and then plot them together. 
#we should see the bands as part of an array
stacksent <- c(b2, b3, b4, b8)
stacksent
plot(stacksent, col=cl) # it's the same but in one command 
dev.off() #it closes devices

plot(stacksent[[4]], col=cl) # i'm asking to select the image number 4, so the NIR one 

plot(c(b2, b3, b4, b8), col=cl) # also working

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


## RGB colours=red, green, blue. The RGB space is how computers create colours. 
#stacksent: band2 blue element 1, stacksent[[1]]
#band3 green element 2, stacksent[[2]]
#band4 red element 3, stacksent[[3]]
#band8 NIR element 4, stacksent[[4]]
im.plotRGB(stacksent, r=3, g=2, b=1 ) #you decide the band to use and how to change the color
im.plotRGB(stacksent, r=4, g=3, b=2) #we see peaks, streets, rivers, two kinds of vegetation
im.plotRGB(stacksent, r=3, g=4, b=2)
im.plotRGB(stacksent, r=3, g=2, b=4) #everything that reflects the NIR will become blue


#if we want to see the correlation of information from one band to another:
?pairs
pairs(stacksent)
#we have the dots plotted and the pearson correlation value
#second and third bands are highly correlated, they give more or less the same information
#the NIR is not that correlated, it adds some more informations
#in the graphs we see the reflectance of the points

#reflectance=ratio between reflected radiant flux (energy) and the incident radiant flux (energy)

