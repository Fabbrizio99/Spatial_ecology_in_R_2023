#time series analysis

library(imageRy)
library(terra)

im.list() # to check the content

#impot the data of levels of no2 in two different periods 
EN01 <- im.import("EN_01.png") # situation in january 2020
EN13 <- im.import("EN_13.png") # situation in march, during quarantine, we can see that the red part has decreased

par(mfrow=c(2,1)) # create a multiframe 
im.plotRGB.auto(EN01)
im.plotRGB.auto(EN13)

#now we want to see the differences between the two values from the first image and the second
dif = EN01[[1]] - EN13[[1]] # we use only the first band 
#we change the colors
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(dif, col=cldif)

#red part are where the values were higher in january due to stop of cars, and blue is where the value is higher in march

#example with temperature in greenland
g2000 <- im.import("greenland.2000.tif") # this is a single band representing temperature in 16 bits
g2000

clg <- colorRampPalette(c('black','blue','white','red'))(100) #blue one is the zone with lower temperature
plot(g2000, col=clg)

# import data from the following years
g2005 <- im.import("greenland.2005.tif")
g2010 <- im.import("greenland.2010.tif")
g2015 <- im.import("greenland.2015.tif")

plot(g2015, col=clg)

par(mfrow=c(2,1))
plot(g2000, col=clg)
plot(g2015, col=clg)
# black area is restricting during years

# stacking the data together and all the 4 images in a plot 
stackg <- c(g2000, g2005, g2010, g2015)
plot(stackg, col=clg)

#exercise: make the diffeerence betweeen the first and the final elements of the stack
difg = g2000[[1]] - g2015[[1]] 
# or difg <- stackg[[1]] - stackg[[4]]
plot(difg, col=cldif)

# we can see that in the center the temperature is incresing

#exercise: make a RGB plot usign diffreent years (with RGB.plot)
# high values in 2000 will be red, in 2005 green and in 2010 blue
im.plotRGB(stackg, r=1, g=2, b=3)
#since its more darker we know that the temperature is increasing in the inner part 




