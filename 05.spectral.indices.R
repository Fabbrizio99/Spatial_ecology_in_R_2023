# vegetation indices

library(imageRy)
library(terra)

im.list()

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")   
# bands: 1=NIR, 2=RED, 3=GREEN
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m1992, 1, 2, 3) #it's the same
im.plotRGB(m1992, r=2, g=1, b=3)
im.plotRGB(m1992, r=2, g=3, b=1)


# import the recent image
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
im.plotRGB(m2006, r=2, g=3, b=1)

#build a multiframe with 1992 and 2006 images (with the par function)
par(mfrow=c(1,2))
im.plotRGB(m1992, r=1, g=2, b=3)
im.plotRGB(m2006, r=1, g=2, b=3)

plot(m1992[[1]])#it gives us the plot only from the first data, the maximum on the y axe is 255 because of we are speaking about bit 

# DVI = NIR - RED
dvi1992 = m1991[[1]] - m1992[[2]]
plot(dvi1992)

cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100)
plot(dvi1992, col=cl)

#NDVI, the range is from -1 to 1
ndvi1992 = (m1992[[1]] - m1992[[2]]) / (m1992[[1]] + m1992[[2]])
ndvi2006 = dvi1992 / (m1992[[1]] + m1992[[2]])
plot(ndvi1992, col=cl)


ndvi2006 = dvi2006 / (m2006[[1]] + m2006[[2]])
plot(ndvi2006, col=cl)

par(mfrow=c(1,2)) #plotting the two images together
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)

#speeding up calculation
ndvi2006a <- im.ndvi(m2006, 1, 2) #don't need to write the whole formula 
plot(ndvi2006, col=cl)
