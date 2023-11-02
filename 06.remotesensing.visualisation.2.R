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
im.plotRGB(stacksent, r=3, g=2, b=1 ) #you decide the band to use


